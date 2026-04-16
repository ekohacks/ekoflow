# Ekohacks Dojo Setup

This repo turns a blank laptop into a machine built for learning to code. No experience required.

---

## What Is This Place?

A dojo is a place where you practice. Not a classroom where someone talks at you. You sit down, you write code, you run tests, you see what happens. The machine is set up so there is nothing between you and the work.

There is no desktop with icons. There is no mouse-driven interface. There is a terminal, an editor, and a test runner. That is it.

This might feel uncomfortable at first. That is the point. When you learn to do everything from the keyboard, you are learning the same way professional developers work. There are no training wheels to unlearn later.

---

## What Happens When You Set This Up?

The setup script takes a fresh Debian 13 Linux installation and installs everything you need:

| Tool | What it does for you |
|------|---------------------|
| i3 | Controls your windows — you switch between them with the keyboard |
| Alacritty | Your terminal — where you type commands |
| Neovim | Your text editor — where you write code |
| tmux | Splits your terminal into sections so you can see your code and tests at the same time |
| Node.js 22 | Runs JavaScript — the language you will learn first |
| vitest | Runs your tests and tells you if your code works |
| git | Tracks every change you make so you can always go back |
| Firefox | Your web browser for Gmail, Slack, GitHub, and looking things up |
| pandoc | Turns your writing into PDFs, Word documents, or slide decks |
| ranger | Lets you browse files from the terminal |
| calcurse | A calendar that runs in the terminal |
| sc-im | A spreadsheet that runs in the terminal |
| TLP | Manages your battery so it lasts longer |

After setup, your laptop uses about 200MB of RAM at idle. The same machine running Windows uses over 7GB. Everything you removed was something you did not need.

---

## Who Is This For?

Anyone. You do not need to know how to code. You do not need to have used Linux before. You do not need to know what a terminal is.

If you have never set up a computer before, start with the **Linux Install Guide** — it walks through every step from downloading the operating system to your first working environment.

If someone else already set up your machine and you are sitting in front of it for the first time, start with **Your First Day** — it teaches you how to move around, open apps, and use basic commands.

---

## Getting Started

### If you are setting up a new machine

1. Install Debian 13 following [the install guide](linux-install-guide.md)
2. Connect to wifi and clone this repo:

```bash
sudo nmtui
sudo apt install -y git
git clone https://github.com/ekohacks/dojo-setup.git
cd dojo-setup
```

3. Run the setup script (10-15 minutes, do not run as root):

```bash
chmod +x ekohacks-dojo-setup.sh
./ekohacks-dojo-setup.sh
```

4. Reboot and start:

```bash
sudo reboot
```

Log in, then:

```bash
startx
```

Press Super + Enter to open a terminal.

### If your machine is already set up

Read [Your First Day](your-first-day.md) to get oriented. Then create your first project:

```bash
dojo-init my-first-kata
cd my-first-kata
tmux
```

Press Ctrl+a then Shift+T to get the dojo layout: editor on the left, tests on the right.

---

## The Guides

Read these in order based on where you are.

| Guide | When to read it |
|-------|----------------|
| [Your First Day](your-first-day.md) | You are sitting in front of a dojo machine for the first time |
| [Linux Install Guide](linux-install-guide.md) | You need to install Debian and set up a machine from scratch |
| [Git Guide](git-guide-beginner.md) | You need to start saving and sharing your work |

### For operations managers

| Guide | When to read it |
|-------|----------------|
| [90-Day Onboarding Plan](../ops-90-day-plan.md) | You are starting as an ops manager |
| [Onboarding Checklist](onboarding-checklist.md) | You are preparing a dojo session for students |
| [Daily Report Template](../ops-daily-report-template.md) | End of every work day |
| [Weekly Report Template](../ops-weekly-report-template.md) | Every Friday |

---

## Dojo Commands

After setup, these commands are available in any terminal.

### Create a new project

```bash
dojo-init fizzbuzz
cd fizzbuzz
```

This creates a folder with a test file, installs the test runner, and makes a first git commit.

### Run your tests

```bash
t              # run tests once
tw             # watch mode — re-runs every time you save
tf             # verbose output showing every test
```

### Save your work

```bash
green 'message'      # commit with a "green" prefix (test is passing)
refactor 'message'   # commit with a "refactor" prefix (you cleaned up code)
```

### The dojo layout

```bash
tmux
```

Then press Ctrl+a followed by Shift+T. Editor on the left, tests on the right.

### Convert your writing

```bash
md2pdf report.md       # creates report.pdf
md2docx proposal.md    # creates proposal.docx
md2pptx slides.md      # creates slides.pptx
```

### See where you are

```bash
dojo-start    # shows your workspace, branch, and available commands
```

---

## Key Bindings Reference

You do not need to memorise these. Come back to this page when you need to look something up.

### i3 (Window Manager)

| Keys | What it does |
|------|-------------|
| Super + Enter | Open a terminal |
| Super + d | Open the app launcher (type the name of what you want to open) |
| Super + Shift + q | Close the focused window |
| Super + h/j/k/l | Move focus between windows |
| Super + Shift + h/j/k/l | Move a window |
| Super + 1/2/3/4 | Switch workspace |
| Super + f | Fullscreen |
| Super + Shift + r | Restart i3 |
| Super + Shift + x | Lock screen |

### tmux (Terminal Splitter)

| Keys | What it does |
|------|-------------|
| Ctrl+a v | Split vertically |
| Ctrl+a s | Split horizontally |
| Ctrl+a h/j/k/l | Move between sections |
| Ctrl+a T | Dojo layout (editor + tests) |
| Ctrl+a r | Reload config |

### Neovim (Editor)

| Keys | What it does |
|------|-------------|
| Space t | Run tests for this file |
| Space ta | Run all tests |
| Space tw | Watch tests for this file |
| Space e | File explorer |
| Space w | Save |
| Space q | Quit |
| Space gs | Git status |
| Space gc | Git commit |

---

## Repo Structure

```
dojo-setup/
  ekohacks-dojo-setup.sh    The setup script
  README.md                  This file
  bin/
    dojo-init                Creates new kata projects
  docs/
    freire/                  Guides for complete beginners (you are here)
      your-first-day.md      First day orientation
      linux-install-guide.md Full install walkthrough
      git-guide-beginner.md  Git for absolute beginners
      README.md              This file
    linux-install-guide.md   Original install guide (reference)
    git-guide-beginner.md    Original git guide (reference)
    ops-90-day-plan.md       Operations manager onboarding
    onboarding-checklist.md  Session prep checklist
```

---

## Why These Constraints?

There is no desktop environment. There is no AI code completion. There is no VS Code.

This is not because those tools are bad. It is because when you are learning, shortcuts hide what is actually happening. When you type every command yourself, you understand what each command does. When you use Neovim instead of a graphical editor, you learn how text editing actually works. When you run tests from the terminal, you see exactly what passes and what fails.

After 90 days in this environment, you can sit down at any machine, any operating system, any editor, and be productive. The constraints are temporary. What you learn from them is permanent.

---

## Contributing

This repo is maintained by the Ekohacks team. To suggest changes:

1. Create a branch: `git checkout -b fix/description`
2. Make your changes
3. Push and open a pull request
4. Describe what you changed and why

Do not commit directly to main.

---

## Licence

Internal use. Ekohacks 2026.
