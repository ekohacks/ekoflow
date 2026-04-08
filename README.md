# Ekohacks Dojo Setup

Turn a blank laptop into a dojo ready coding machine in under an hour.

This repo contains everything needed to set up and manage Ekohacks dojo machines: the install script, the tools, and the documentation for students and staff.

---

## What This Does

Takes a fresh Debian 13 minimal install and configures it as a keyboard driven development environment for test driven development with Vim. No desktop environment. No mouse. No AI tools. Just a terminal, an editor, and a test runner.

**What gets installed:**

| Tool | Purpose |
|------|---------|
| Debian 13 Trixie | Base operating system (supported until 2030) |
| i3 | Window manager (keyboard driven) |
| Alacritty | Terminal emulator |
| Neovim | Text editor (bespoke Ekohacks config) |
| tmux | Terminal multiplexer with TDD layout |
| Node.js 20 | JavaScript runtime via nvm |
| vitest | Test runner |
| git | Version control with TDD aliases |
| pandoc | Document conversion (markdown to PDF, DOCX, PPTX) |
| ranger | Terminal file browser |
| calcurse | Terminal calendar |
| sc-im | Terminal spreadsheet |
| Firefox ESR | Web browser (for Slack, Gmail, GitHub) |
| TLP | Battery management |

**Idle RAM usage after setup:** approximately 200MB.

---

## Target Hardware

Designed for and tested on the HP EliteBook 840r G4 (i5-8250U, 8GB RAM). Works on any x86_64 laptop that supports Debian 13. The setup script includes Intel wifi firmware and EliteBook specific keybindings for brightness and volume but will run fine on other hardware.

---

## Quick Start

### 1. Install Debian 13

Follow the full guide at [docs/linux-install-guide.md](docs/linux-install-guide.md). The short version:

Download the Debian 13 netinst ISO from https://www.debian.org/distrib/netinst. Flash it to a USB stick. Boot from USB. Choose text install. At the software selection screen, check only "standard system utilities" and nothing else.

### 2. Connect to wifi and clone this repo

```bash
sudo nmtui
sudo apt install -y git
git clone https://github.com/ekohacks/dojo-setup.git
cd dojo-setup
```

### 3. Run the setup script

```bash
chmod +x ekohacks-dojo-setup.sh
./ekohacks-dojo-setup.sh
```

This takes 10 to 15 minutes. Do not run it as root. It will ask for sudo when needed.

### 4. Reboot and start

```bash
sudo reboot
```

Log in, then:

```bash
startx
```

Press Super + Enter to open a terminal. You are in the dojo.

---

## Repo Structure

```
dojo-setup/
  ekohacks-dojo-setup.sh    Main setup script
  README.md                  This file
  bin/
    dojo-init                Scaffold a new kata project
  docs/
    linux-install-guide.md   Full Debian 13 install walkthrough
    git-guide-beginner.md    Git guide for absolute beginners
    ops-90-day-plan.md       Operations manager onboarding plan
    onboarding-checklist.md  Student setup and session checklist
  config/
    (future: shared dotfiles)
```

---

## Dojo Commands

These are available after setup in any terminal session.

### Create a new kata

```bash
dojo-init fizzbuzz
cd fizzbuzz
```

This creates a project with vitest, a starter test file, and a first git commit.

### TDD workflow

```bash
t              # run tests once
tw             # watch mode (re-runs on save)
tf             # verbose output
green 'msg'   # commit everything with a green prefix
refactor 'msg' # commit everything with a refactor prefix
```

### tmux TDD layout

```bash
tmux
```

Then press Ctrl+a T to split into Neovim on the left and vitest watch on the right.

### Document conversion

```bash
md2pdf report.md       # creates report.pdf
md2docx proposal.md    # creates proposal.docx
md2pptx slides.md      # creates slides.pptx
```

### Session info

```bash
dojo-start    # shows workspace, branch, and available commands
```

---

## Key Bindings

### i3 (Window Manager)

| Keys | Action |
|------|--------|
| Super + Enter | Open terminal |
| Super + d | App launcher |
| Super + Shift + q | Close window |
| Super + h/j/k/l | Move focus (vim style) |
| Super + Shift + h/j/k/l | Move window |
| Super + 1/2/3/4 | Switch workspace (code/test/git/web) |
| Super + f | Fullscreen |
| Super + r | Enter resize mode |
| Super + Shift + r | Restart i3 |
| Super + Shift + x | Lock screen |

### tmux

| Keys | Action |
|------|--------|
| Ctrl+a v | Vertical split |
| Ctrl+a s | Horizontal split |
| Ctrl+a h/j/k/l | Navigate panes |
| Ctrl+a T | TDD layout |
| Ctrl+a r | Reload config |

### Neovim

| Keys | Action |
|------|--------|
| Space t | Run tests (current file) |
| Space ta | Run all tests |
| Space tw | Watch tests (current file) |
| Space e | File explorer |
| Space v | Vertical split |
| Space s | Horizontal split |
| Space w | Save |
| Space q | Quit |
| Space gs | Git status |
| Space gd | Git diff |
| Space gl | Git log |
| Space gc | Git commit |
| Ctrl + h/j/k/l | Navigate splits |

---

## Documentation

| Document | Audience | Purpose |
|----------|----------|---------|
| [Linux Install Guide](docs/linux-install-guide.md) | Anyone | Step by step Debian 13 install for someone who has never installed Linux |
| [Git Guide](docs/git-guide-beginner.md) | Beginners | Git workflow for the newsletter repo |
| [90 Day Plan](docs/ops-90-day-plan.md) | Ops manager | 12 week onboarding from zero to running dojo sessions independently |
| [Onboarding Checklist](docs/onboarding-checklist.md) | Ops manager | Pre-session, day-of, and post-session checklist for student onboarding |

---

## Setting Up Multiple Machines

For dojo sessions with multiple students, the process is the same for each laptop. The setup script prompts for git name and email interactively so each machine gets a unique identity.

For faster bulk setup, a Debian preseed file can automate the installer. This is not yet in the repo. If you need it, open an issue.

---

## Philosophy

This environment is intentionally constrained. There is no desktop. There is no file manager you can click. There is no AI code completion. There is no VS Code.

Students learn by doing everything the hard way first. The terminal is the interface. Vim is the editor. Tests come before code. Every green test gets a commit. The constraint is the pedagogy.

After 90 days in this environment, a student can sit down at any machine, any operating system, any editor, and be productive. That is the goal.

---

## Contributing

This repo is maintained by the Ekohacks operations team. To suggest changes:

1. Create a branch: `git checkout -b fix/description`
2. Make your changes
3. Push and open a pull request
4. Describe what you changed and why

Do not commit directly to main.

---

## Licence

Internal use. Ekohacks 2026.