To run multiple Claude Code (https://www.google.com/search?q=Claude+Code) accounts side-by-side on the same machine (such as macOS or Linux), you can isolate each account by pointing it to a separate configuration directory using the CLAUDE_CONFIG_DIR environment variable. [1] (https://medium.com/@buwanekasumanasekara/setting-up-multiple-claude-code-accounts-on-your-local-machine-f8769a36d1b1), [2] (https://gist.github.com/KMJ-007/0979814968722051620461ab2aa01bf2)

Step 1: Create Separate Config Directories

Open your terminal and create distinct folders for each account (for example, one for work and one for personal use): [1] (https://gist.github.com/KMJ-007/0979814968722051620461ab2aa01bf2), [2] (https://medium.com/@buwanekasumanasekara/setting-up-multiple-claude-code-accounts-on-your-local-machine-f8769a36d1b1)
bash
mkdir -p ~/.claude-work
mkdir -p ~/.claude-personal

Step 2: Set Up Shell Aliases

Add custom aliases to your shell configuration file (~/.zshrc for zsh or ~/.bashrc for bash) so you can easily launch either account. [1] (https://medium.com/@buwanekasumanasekara/setting-up-multiple-claude-code-accounts-on-your-local-machine-f8769a36d1b1), [2] (https://gist.github.com/KMJ-007/0979814968722051620461ab2aa01bf2)
1. Open your shell config file in a text editor (e.g., nano ~/.zshrc):
2. Append the alias lines, ensuring you reference your actual Claude binary path if needed: [1] (https://medium.com/@buwanekasumanasekara/setting-up-multiple-claude-code-accounts-on-your-local-machine-f8769a36d1b1), [2] (https://gist.github.com/KMJ-007/0979814968722051620461ab2aa01bf2)
bash
alias claude-work='CLAUDE_CONFIG_DIR=~/.claude-work claude'
alias claude-personal='CLAUDE_CONFIG_DIR=~/.claude-personal claude'
3. Save the file and reload your shell configuration: [1] (https://medium.com/@buwanekasumanasekara/setting-up-multiple-claude-code-accounts-on-your-local-machine-f8769a36d1b1), [2] (https://gist.github.com/KMJ-007/0979814968722051620461ab2aa01bf2)
bash
source ~/.zshrc

Step 3: Authenticate Each Account

Run each alias for the first time to go through the OAuth login flow for each respective Anthropic account: [1] (https://dev.to/daksh-gargas/one-brain-two-wallets-two-claude-code-accounts-on-one-machine-5ejb), [2] (https://gist.github.com/KMJ-007/0979814968722051620461ab2aa01bf2)
• For your work account:bash
claude-work
• For your personal account:bash
claude-personal
Each login will store its credentials and session data independently inside its designated folder (~/.claude-work or ~/.claude-personal) rather than colliding with your default ~/.claude directory. [1] (https://medium.com/@buwanekasumanasekara/setting-up-multiple-claude-code-accounts-on-your-local-machine-f8769a36d1b1), [2] (https://gist.github.com/KMJ-007/0979814968722051620461ab2aa01bf2)

Step 4: Run Accounts Concurrently

You can now open multiple terminal tabs or windows and run claude-work in one and claude-personal in another simultaneously, each operating under separate usage limits and subscription accounts. [1] (https://gist.github.com/KMJ-007/0979814968722051620461ab2aa01bf2)
A step-by-step video guide showing how to configure environment variables and aliases for multiple Claude Code accounts:
