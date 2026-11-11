# Secure Files When Working With Agents

Use a root-owned folder lock when you want private files temporarily unavailable to an agent. Lock before starting the agent; stop it before unlocking. Only the top-level folder changes, so files inside keep their original permissions.

An agent running as your user can undo a plain `chmod`. Changing the folder owner to root prevents that; an immutable flag also prevents renaming or removing the folder. This protects against unprivileged access through that folder, subject to the limits below. See the [Linux attribute manual](https://man7.org/linux/man-pages/man1/chattr.1.html) and [Apple's flag documentation](https://github.com/apple-oss-distributions/file_cmds/blob/main/chflags/chflags.1).

## Lock and Unlock Script

Save this as `folder_lock.sh`. Use it for an ordinary local directory without ACLs or existing immutable/append-only flags. Stop processes using it first, and test the complete cycle on a disposable folder before protecting real files. Keep the script outside the folder being locked.

```bash
#!/usr/bin/env bash
# usage: sudo bash folder_lock.sh lock|unlock /absolute/path/to/folder
set -euo pipefail
PATH=/usr/sbin:/usr/bin:/sbin:/bin
export PATH
umask 077

fail() { echo "$*" >&2; exit 1; }
[ "$EUID" -eq 0 ] || fail "Run with sudo"
[ "$#" -eq 2 ] || fail "Usage: $0 lock|unlock /absolute/path/to/folder"
ACTION=$1
case "$ACTION" in lock|unlock) ;; *) fail "Use lock or unlock" ;; esac
[[ $2 = /* ]] || fail "Use an absolute folder path"
DIR=$(CDPATH= cd -- "$2" && pwd -P)
[ "$DIR" != / ] || fail "Refusing to lock the filesystem root"

case $(uname -s) in
  Darwin)
    STATE=/var/db/folder-lock
    KEY=$(printf '%s' "$DIR" | shasum -a 256 | awk '{print $1}')
    ;;
  Linux)
    STATE=/var/lib/folder-lock
    KEY=$(printf '%s' "$DIR" | sha256sum | awk '{print $1}')
    ;;
  *) fail "This script supports Linux and macOS only" ;;
esac

mkdir -p "$STATE"
[ ! -L "$STATE" ] || fail "Metadata directory must not be a symlink"
chown 0:0 "$STATE"
chmod 700 "$STATE"
META="$STATE/$KEY.meta"
trap 'echo "Operation failed. Inspect folder state; preserve recovery metadata: $META" >&2' ERR

case "$ACTION" in
  lock)
    [ ! -e "$META" ] || fail "Recovery record exists; inspect or unlock first"
    case $(uname -s) in
      Darwin) ORIGINAL=$(stat -f '%u:%g %OLp' "$DIR") ;;
      Linux) ORIGINAL=$(stat -c '%u:%g %a' "$DIR") ;;
    esac
    (set -o noclobber; printf '%s\n' "$ORIGINAL" > "$META")
    chown 0 "$DIR"
    chmod 000 "$DIR"
    case $(uname -s) in
      Darwin) chflags schg "$DIR" ;;
      Linux) chattr +i "$DIR" ;;
    esac
    echo "Locked: $DIR"
    ;;
  unlock)
    [ -f "$META" ] || fail "No recovery record for this folder"
    read -r OWNER MODE < "$META"
    case $(uname -s) in
      Darwin) chflags noschg "$DIR" ;;
      Linux) chattr -i "$DIR" ;;
    esac
    chown "$OWNER" "$DIR"
    chmod "$MODE" "$DIR"
    rm -- "$META"
    echo "Unlocked: $DIR"
    ;;
esac
```

Run these yourself in a trusted terminal. Use an exact folder path, avoiding system folders, your home folder itself, and active project folders:

```bash
sudo bash ./folder_lock.sh lock /absolute/path/to/protected
sudo bash ./folder_lock.sh unlock /absolute/path/to/protected
```

Run one operation at a time. Keep the folder at the same path until unlocked. The script resolves the path using `cd` and `pwd -P`, so it does not need `realpath` on older macOS installations. It also refuses to overwrite an existing recovery record, stores numeric ownership, and hashes the path to avoid filename collisions from replacing `/` with `_`.

## Verify the Lock

Under the same unprivileged account and environment the agent uses, confirm that listing the disposable test folder and reading its harmless test file fail. Also confirm that changing its mode and renaming it fail. Unlock, then confirm its original ownership, permissions, and access return.

Inspect metadata with `ls -ldeO /path/to/folder` on macOS, or `stat /path/to/folder` and `lsattr -d /path/to/folder` on Linux. These checks do not require reading private file contents.

## OS Support

| Environment | Works? | Notes |
|---|---|---|
| Linux on ext4, XFS, Btrfs | Usually | Confirm immutable-flag support and privileges on the actual filesystem |
| Linux on NFS, overlay, some containers | Partly or unsupported | Ownership, modes, or immutable flags may fail; the script stops on errors |
| macOS | Yes, on suitable volumes | Uses `chflags schg`; confirm ownership is enabled and inspect ACLs |
| FreeBSD and other BSDs | Needs adaptation | Use that OS's `chflags`, `stat`, and securelevel rules; this script rejects them |
| WSL on Linux filesystem paths | Generally | Verify filesystem and flag support; this does not restrict Windows administration |
| WSL under `/mnt/c/...` | Limited | DrvFs metadata enables Unix permission checks within WSL; Windows access still follows Windows permissions |
| Native Windows, including PowerShell, CMD, Git Bash | Different approach | Use Windows ownership and ACLs instead of this script |

Filesystem support is not a guarantee based on the OS name. See the [Linux `chattr` manual](https://man7.org/linux/man-pages/man1/chattr.1.html) and [Microsoft's WSL permissions guide](https://learn.microsoft.com/en-us/windows/wsl/file-permissions).

## Essential Caveats

- **Administrator access:** passwordless sudo, usable cached sudo authentication, elevated sessions, or privileged helpers can let an agent undo the lock. Keep passwords out of agent sessions. A separate unprivileged agent account provides stronger separation than sharing your login. See the [`sudo` manual](https://man7.org/linux/man-pages/man8/sudo.8.html).
- **ACLs and metadata:** this script saves only owner/group and mode. It neither detects nor backs up ACLs or extended attributes. On macOS, ACL entries can grant access despite mode `000`; on Linux, mode changes interact with the ACL mask. Use an ACL-aware procedure for such directories. Extended attributes are not generally erased by these commands, but they are not backed up. See [Apple's ACL options](https://github.com/apple-oss-distributions/file_cmds/blob/main/chmod/chmod.1) and the [Linux ACL manual](https://man7.org/linux/man-pages/man5/acl.5.html).
- **Partial failure:** `set -e` stops execution without rolling back previous changes. If setting the immutable flag fails, the folder may already be root-owned with mode `000`. Preserve the printed metadata file. It contains `UID:GID MODE`; after inspecting the flags, use those recorded values with `sudo chown UID:GID /path/to/folder` and `sudo chmod MODE /path/to/folder` to recover. If an immutable flag is present, clear it first using the matching OS command. Remove the recovery record only after restoration succeeds.
- **Existing access:** already-open files remain open. Processes with a working directory or directory handle inside the tree can retain access to descendants. Stop them before locking. Directory permissions govern pathname traversal; see [Linux pathname resolution](https://man7.org/linux/man-pages/man7/path_resolution.7.html).
- **Other copies:** the lock does not protect backups, Git history/remotes, synced clouds, outside hard links, alternate mounts, logs, or content already sent to an agent.
- **Temporary unlocking:** an agent sharing your login can access files while unlocked. Stop it first; lock and verify again before restarting it. The lock provides access control, not encryption.

## Windows Alternative

Use a dedicated standard account for the agent. From a separate Administrator account, keep the protected folder owned by an administrator and configure ACLs so the agent cannot access it or change its permissions. Review group memberships and inherited grants.

An elevated PowerShell can add a deny entry for the specific agent account:

```powershell
icacls "C:\path\protected" /deny "COMPUTER\AgentUser:(OI)(CI)F"
```

Replace the account with the actual agent identity. This requires administrator-controlled ownership and permissions; an agent that can change the ACL or elevate can undo it. Check descendants with inheritance disabled separately.

Before changing ACLs, save the affected DACLs with `icacls /save` to administrator-controlled storage and record ownership separately. Unlock by restoring the saved DACLs with `icacls /restore` using the correct base directory. Test restoration on a disposable folder first.

Avoid a blanket `Everyone` deny because it affects the operator and administrator accounts too. `/remove:d Everyone` removes pre-existing deny entries as well, so it is not a reliable undo operation. See [Microsoft's `icacls` reference](https://learn.microsoft.com/en-us/windows-server/administration/windows-commands/icacls).

Keep agent deny rules and hooks as extra layers. `.gitignore` and instructions alone do not prevent file access. Give the agent sanitized examples and scoped development credentials so routine work can continue with private files locked.
