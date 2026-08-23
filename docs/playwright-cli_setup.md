## Step 1: Install the Playwright Extension in your Browser

   1. Open Google Chrome and navigate to the [Playwright Extension on Chrome Web Store](https://chromewebstore.google.com/detail/playwright-extension/mmlmfjhmonkocbjadbfplnigmagldckm).
   2. Click Add to Chrome to install it.
   3. Open chrome://extensions/ in your address bar, find the Playwright Extension, and click Details.
   4. Scroll down and toggle Allow access to file URLs to the ON position. [2] 

------------------------------
## Step 2: Global CLI Installation
You must install Microsoft's specialized, agent-centric playwright-cli package globally via npm: [2, 3] 
```bash
npm install -g @playwright/cli
```
Verify your path and confirm the utility is correctly mapped to your shell: [2] 
```bash
playwright-cli --help
```
------------------------------
## Step 3: Install the Playwright CLI Skills Playbook
To ensure AI coding agents (like Claude Code or Codex) can automatically discover and use the terminal browser commands efficiently, you must download the native Playwright CLI Skills playbook into your active workspace directory: [4, 5] 

   1. Open your terminal and navigate to your project workspace directory.
   2. Execute the official skill installation command: [2] 
```bash
playwright-cli install --skills
```

* What this does: This creates a hidden configuration file and a local .playwright-cli/ directory containing structured markdown files (SKILL.md). When your coding agent initializes inside your project folder, it automatically references these localized skill maps to execute token-optimized browser interactions rather than processing massive accessibility schemas. [1, 4, 6] 

------------------------------
## Step 4: Authorize and Establish the Extension Connection
Because the extension uses a strict browser permissions layer, you must anchor the session manually before running navigation commands: [7] 

   1. Keep your target application server running on its standard port (e.g., localhost:8080).
   2. Run the attachment command specifying your target browser flavor explicitly: [7] 
```bash
playwright-cli attach --extension=chrome
```

   1. Complete the Handshake: A dynamic browser overlay or prompt from the extension worker will generate inside Chrome. Confirm the window request to visually authorize your current CLI node and lock it directly into your live browser instance. [2] 

------------------------------
## Step 5: (Optional) Set up Environment Variables for Agent Persistence
To allow background terminal loops to automatically re-attach to this specific workspace channel profile without asking for manual permission strings repeatedly, export your targeted session name: [2, 7] 

* Mac/Linux:
```bash
export PLAYWRIGHT_CLI_SESSION=my-dev-ui
```
* Windows (PowerShell):
```bash
$env:PLAYWRIGHT_CLI_SESSION="my-dev-ui"
```

If your installation throws any folder access exceptions during the skills generation process, what operating system and terminal platform are you using?

[1] [https://www.youtube.com](https://www.youtube.com/watch?v=OaFmRHiKp68)
[2] [https://qaskills.sh](https://qaskills.sh/blog/playwright-cli-install-quickstart-2026)
[3] https://playwright.dev
[4] [https://www.youtube.com](https://www.youtube.com/watch?v=4pW1DrERvm0)
[5] [https://playwright.dev](https://playwright.dev/docs/getting-started-cli)
[6] [https://playwright.dev](https://playwright.dev/agent-cli/introduction)
[7] [https://playwright.dev](https://playwright.dev/agent-cli/commands/attach)
