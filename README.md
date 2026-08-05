# Agent Driven Development
<img width="1536" height="1024" alt="ChatGPT Image Aug 5, 2026, 01_42_05 PM" src="https://github.com/user-attachments/assets/286eaf20-25c6-4fa8-ae84-e953d1a89a0a" />


## Copy the [AGENTS.md](AGENTS.md) in your repo.

**Linux, macOS, WSL, and Git Bash**:

```bash
set -euo pipefail

url='https://raw.githubusercontent.com/Sourav9063/ADD/refs/heads/main/AGENTS.md'
content="$(curl -fsSL "$url")"

for f in AGENTS.md CLAUDE.md GEMINI.md; do
    touch "$f"
    sed -i.bak '/^## Spec-Driven Development$/,$d' "$f" && rm -f "$f.bak"
    
    [ "$f" = "AGENTS.md" ] && text="$content" || text="@AGENTS.md"
    printf '%s\n' "$text" >> "$f"
done

```

<!-- ```bash
set -euo pipefail

url='https://raw.githubusercontent.com/Sourav9063/notes/refs/heads/main/ai/AGENTS.md'
content="$(curl -fsSL "$url")"

for file in CLAUDE.md AGENTS.md GEMINI.md; do
    touch "$file"

    if grep -q '^## Spec-Driven Development$' "$file"; then
        sed -i.bak '/^## Spec-Driven Development$/,$d' "$file"
        rm -f "$file.bak"
    fi

    printf '%s\n' "$content" >> "$file"
done
``` -->

* Marker exists: replace from the marker to the end.
* Marker absent: append.
* File absent: create it.

For **native Windows**, use Git Bash or WSL to run the same script.
