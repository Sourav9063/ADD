# Secure Files When Working With Agents

Use a root-owned folder lock when you want private files temporarily unavailable to an agent. Lock before starting the agent; stop it before unlocking. Only the top-level folder changes, so files inside keep their original permissions.

An agent running as your user can undo a plain `chmod`. Changing the folder owner to root prevents that; an immutable flag also prevents renaming or removing the folder. This protects against unprivileged access through that folder, subject to the limits below. See the [Linux attribute manual](https://man7.org/linux/man-pages/man1/chattr.1.html) and [Apple's flag documentation](https://github.com/apple-oss-distributions/file_cmds/blob/main/chflags/chflags.1).

## Lock and Unlock Script

Save this as `folder_lock.sh`. Use it for an ordinary local directory without extended or default ACLs, without any flags on macOS, and without immutable/append-only flags on Linux. Linux requires `getfacl` (usually in the `acl` package) and `lsattr`/`chattr` (usually in `e2fsprogs`). Stop the agent and other processes using the folder before either operation, and test the complete cycle on a disposable folder before protecting real files. Keep the script outside the folder being locked.

```bash
#!/usr/bin/env bash
# usage: sudo bash folder_lock.sh lock|unlock /absolute/path/to/folder
# Stop the agent and other processes using the folder before either operation.
set -euo pipefail
PATH=/usr/sbin:/usr/bin:/sbin:/bin
export PATH
umask 077

fail() { echo "$*" >&2; exit 1; }
usage() {
  fail "Usage: sudo bash $0 lock|unlock /absolute/path/to/folder
Stop the agent and other processes using the folder before either operation.
Run one operation at a time. Test lock and unlock on a disposable folder first."
}
[ "$EUID" -eq 0 ] || fail "Run with sudo"
[ "$#" -eq 2 ] || usage
ACTION=$1
case "$ACTION" in lock|unlock) ;; *) usage ;; esac
[[ $2 = /* ]] || fail "Use an absolute folder path"
[[ $2 != *$'\n'* ]] || fail "Folder paths must not contain newlines"
DIR=$(CDPATH= cd -- "$2" && pwd -P && printf '.')
DIR=${DIR%$'\n.'}
[[ $DIR != *$'\n'* ]] || fail "Folder paths must not contain newlines"

OS=$(uname -s)
case "$OS" in
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
STATE_PARENT=$(CDPATH= cd -- "${STATE%/*}" && pwd -P)
STATE="$STATE_PARENT/${STATE##*/}"

if [ "$ACTION" = lock ]; then
  [ -n "${DIR%/*}" ] || fail "Refusing to lock a filesystem root or top-level folder"
  case "$DIR" in
    /private/etc|/private/var|/private/tmp|"$HOME")
      fail "Refusing to lock a system folder or home folder" ;;
  esac
  [[ ! $DIR =~ ^/(Users|home)/[^/]+$ ]] || fail "Refusing to lock a home folder"
  [[ $STATE != "$DIR" && $STATE != "$DIR/"* && $DIR != "$STATE/"* ]] ||
    fail "Folder must not contain or be inside the metadata directory"
fi

case "$OS" in
  Darwin) ID=$(stat -f '%d:%i' "$DIR") ;;
  Linux) ID=$(stat -c '%d:%i' "$DIR") ;;
esac

[ ! -L "$STATE" ] || fail "Metadata directory must not be a symlink"
mkdir -p "$STATE"
chown 0:0 "$STATE"
chmod 700 "$STATE"
META="$STATE/$KEY.meta"
report_failure() {
  echo "Operation failed. Inspect folder state." >&2
  if [ -f "$META" ]; then
    echo "Preserve recovery metadata: $META" >&2
  fi
}
trap report_failure ERR

case "$ACTION" in
  lock)
    [ ! -e "$META" ] && [ ! -L "$META" ] || fail "Recovery record exists; inspect or unlock first"
    case "$OS" in
      Darwin)
        FLAGS=$(stat -f '%Sf' "$DIR") || fail "Cannot inspect folder flags"
        [ "$FLAGS" = - ] || fail "Existing flags; use a metadata-aware procedure"
        ACL=$(LC_ALL=C ls -lde "$DIR") || fail "Cannot inspect folder ACL"
        [ -z "$(printf '%s\n' "$ACL" | sed 1d)" ] || fail "ACL present"
        ORIGINAL=$(stat -f '%u:%g %OMp%03OLp' "$DIR")
        ;;
      Linux)
        FLAGS=$(lsattr -d "$DIR") || fail "Cannot inspect folder flags; check lsattr and filesystem support"
        FLAGS=${FLAGS%% *}
        [[ $FLAGS != *[ia]* ]] || fail "Existing immutable/append-only flag"
        ACL=$(getfacl -c -s -p -a -d -- "$DIR") || fail "Cannot inspect folder ACL; check getfacl and filesystem support"
        [ -z "$ACL" ] || fail "ACL present"
        ORIGINAL=$(stat -c '%u:%g %04a' "$DIR")
        ;;
    esac
    (set -o noclobber; printf '%s\n%s\n%s\n' "$ORIGINAL" "$ID" "$DIR" > "$META")
    chown 0 "$DIR"
    chmod 00000 "$DIR"
    case "$OS" in
      Darwin) chflags schg "$DIR" ;;
      Linux) chattr +i "$DIR" ;;
    esac
    echo "Locked: $DIR"
    ;;
  unlock)
    [ -f "$META" ] || fail "No recovery record for this folder"
    if ! {
      read -r OWNER MODE &&
      IFS= read -r SAVED_ID &&
      IFS= read -r SAVED_PATH
    } < "$META"; then
      fail "Incomplete or legacy recovery record; inspect manually: $META"
    fi
    [[ $OWNER =~ ^[0-9]+:[0-9]+$ && $MODE =~ ^[0-7]{4}$ && $SAVED_ID =~ ^[0-9]+:[0-9]+$ ]] ||
      fail "Invalid recovery record; inspect manually: $META"
    [ "$DIR" = "$SAVED_PATH" ] || fail "Saved path differs; not unlocking"
    [ "$ID" = "$SAVED_ID" ] || fail "Directory identity changed; not unlocking"
    case "$OS" in
      Darwin) chflags noschg "$DIR" ;;
      Linux) chattr -i "$DIR" ;;
    esac
    chown "$OWNER" "$DIR"
    chmod "0$MODE" "$DIR"
    rm -- "$META"
    echo "Unlocked: $DIR"
    ;;
esac
```

Run these yourself in a trusted terminal. Use an exact folder path, avoiding system folders, your home folder itself, and active project folders:

```bash
sudo bash ./folder_lock.sh lock /absolute/path/to/protected
sudo -k
sudo bash ./folder_lock.sh unlock /absolute/path/to/protected
sudo -k
```

Run `sudo -k` after each operation, even if it fails, from the same trusted terminal. It invalidates that session's cached authentication. Use `sudo -K` instead to remove all cached authentication timestamps for your user; neither command removes passwordless sudo rights.

Run one operation at a time. Keep the folder and its parents at the same path until unlocked. The script resolves the path using `cd` and `pwd -P`, so it does not need `realpath` on older macOS installations. It refuses to overwrite an existing recovery record, stores numeric ownership and all permission/special bits, and hashes the path to avoid filename collisions from replacing `/` with `_`. Each record also stores the device/inode identity and original path; unlock checks both before changing flags, ownership, or mode. Existing one-line records require manual recovery.

## Verify the Lock

Under the same unprivileged account and environment the agent uses, confirm that listing the disposable test folder and reading its harmless test file fail. Also confirm that changing its mode and renaming it fail. Unlock, then confirm its original ownership, permissions (including sticky/setgid bits when applicable), and access return. Confirm that a second lock refuses to overwrite the record and that ACLs and existing flags are rejected before the folder changes.

Inspect metadata with `ls -ldeO /path/to/folder` on macOS, or `stat /path/to/folder` and `lsattr -d /path/to/folder` on Linux. These checks do not require reading private file contents.

## OS Support

| Environment | Works? | Notes |
|---|---|---|
| Linux on ext4, XFS, Btrfs | Usually | Confirm immutable-flag support and privileges on the actual filesystem |
| Linux on NFS, overlay, some containers | Partly or unsupported | Ownership, modes, or immutable flags may fail; the script stops on errors |
| macOS | Requires a full-cycle test | Uses `chflags schg`; confirm ownership is enabled and that the system permits clearing the flag |
| FreeBSD and other BSDs | Needs adaptation | Use that OS's `chflags`, `stat`, and securelevel rules; this script rejects them |
| WSL on Linux filesystem paths | Generally | Verify filesystem and flag support; this does not restrict Windows administration |
| WSL under `/mnt/c/...` | Limited | DrvFs metadata enables Unix permission checks within WSL; Windows access still follows Windows permissions |
| Native Windows, including PowerShell, CMD, Git Bash | Different approach | Use Windows ownership and ACLs instead of this script |

Filesystem support is not a guarantee based on the OS name. See the [Linux `chattr` manual](https://man7.org/linux/man-pages/man1/chattr.1.html) and [Microsoft's WSL permissions guide](https://learn.microsoft.com/en-us/windows/wsl/file-permissions).

## Essential Caveats

- **Administrator access:** passwordless sudo, usable cached sudo authentication, elevated sessions, or privileged helpers can let an agent undo the lock. Keep passwords out of agent sessions. A separate unprivileged agent account provides stronger separation than sharing your login. See the [`sudo` manual](https://man7.org/linux/man-pages/man8/sudo.8.html).
- **ACLs and metadata:** the script refuses extended/default ACLs and failed ACL inspections; it saves owner/group, mode, identity, and path, without backing up ACLs or extended attributes. On macOS, ACL entries can grant access despite mode `000`; on Linux, mode changes interact with the ACL mask. Use an ACL-aware procedure for such directories. Extended attributes are not generally erased by these commands, but they are not backed up. See [Apple's ACL options](https://github.com/apple-oss-distributions/file_cmds/blob/main/chmod/chmod.1) and the [Linux ACL manual](https://man7.org/linux/man-pages/man5/acl.5.html).
- **Partial failure:** `set -e` stops execution without rolling back previous changes. If setting the immutable flag fails, the folder may already be root-owned with mode `000`. Preserve its recovery record. The three lines contain `UID:GID MODE`, `DEVICE:INODE`, and the original absolute path. Before manual recovery, verify the path and identity against `stat -f '%d:%i' /path/to/folder` on macOS or `stat -c '%d:%i' /path/to/folder` on Linux. Clear an immutable flag if present, then restore using `sudo chown UID:GID /path/to/folder` followed by `sudo chmod 0MODE /path/to/folder`, substituting the recorded values. The extra leading zero makes GNU `chmod` restore directory special bits exactly. Legacy one-line records contain only ownership and mode; verify the intended target independently. Remove the record only after restoration succeeds, then run `sudo -k`.
- **macOS system flags:** `schg` is the system immutable flag. Clearing it can be restricted by the system's security configuration, including securelevel where applicable, and may require recovery or single-user procedures. Test the complete lock/unlock cycle on the actual volume before protecting real files. A successful lock alone does not establish that unlock will work.
- **Path races:** identity checks detect a replacement directory before unlock starts; they do not make the later path-based commands atomic. Keep the agent and any process able to rename the folder or its parents stopped during both operations. The path refusals cover top-level folders, selected system folders, and standard home locations; avoid nonstandard home locations and active project folders yourself.
- **Existing access:** already-open files remain open. Processes with a working directory or directory handle inside the tree can retain access to descendants. Stop them before locking. Directory permissions govern pathname traversal; see [Linux pathname resolution](https://man7.org/linux/man-pages/man7/path_resolution.7.html).
- **Other copies:** the lock does not protect backups, Git history/remotes, synced clouds, outside hard links, alternate mounts, logs, or content already sent to an agent.
- **Temporary unlocking:** an agent sharing your login can access files while unlocked. Stop it first; lock and verify again before restarting it. The lock provides access control, not encryption.

## Windows Alternative

Use a dedicated standard account for the agent. The agent account must not own the folder or have rights to change its DACL or take ownership, including through group memberships or elevation. From a separate Administrator account, keep the protected folder owned by an administrator and configure ACLs so the agent cannot access it. Review inherited grants.

Before changing ACLs, save the affected DACLs with `icacls /save` to administrator-controlled storage and record ownership separately. Test restoration on a disposable folder first.

An elevated PowerShell can add a deny entry for the specific agent account:

```powershell
icacls "C:\path\protected" /deny "COMPUTER\AgentUser:(OI)(CI)F"
```

Replace the account with the actual agent identity. This requires administrator-controlled ownership and permissions; an agent that can change the ACL or elevate can undo it. Check descendants with inheritance disabled separately.

Unlock by restoring the saved DACLs with `icacls /restore` using the correct base directory.

Avoid a blanket `Everyone` deny because it affects the operator and administrator accounts too. `/remove:d Everyone` removes pre-existing deny entries as well, so it is not a reliable undo operation. See [Microsoft's `icacls` reference](https://learn.microsoft.com/en-us/windows-server/administration/windows-commands/icacls).

Keep agent deny rules and hooks as extra layers. `.gitignore` and instructions alone do not prevent file access. Give the agent sanitized examples and scoped development credentials so routine work can continue with private files locked.
