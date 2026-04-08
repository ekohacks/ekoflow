---
marp: true
theme: default
paginate: true
backgroundColor: #fff
color: #333
style: |
  section {
    font-family: 'Segoe UI', Tahoma, Geneva, Verdana, sans-serif;
  }
  h1 {
    color: #24292e;
  }
  h2 {
    color: #0366d6;
  }
  h3 {
    color: #24292e;
  }
  code {
    background: #f6f8fa;
    color: #e01e5a;
  }
  pre {
    background: #1e1e2e;
    border-radius: 8px;
  }
  pre code {
    color: #cdd6f4;
    background: transparent;
  }
  section.lead h1 {
    font-size: 2.5em;
  }
  section.lead h2 {
    font-size: 1.8em;
    color: #24292e;
  }
  section.lead p {
    font-size: 1.2em;
    color: #586069;
  }
  blockquote {
    border-left: 4px solid #0366d6;
    padding-left: 1em;
    color: #586069;
    font-style: italic;
  }
---

<!-- _class: lead -->

# Business Update: Our New Content Workflow

How we write, review, and publish -- starting now

---

## Why We Are Changing

- Our current process relies on emailing files back and forth
- Feedback gets lost, versions get confused, work gets duplicated
- We need **one source of truth** that everyone works from
- We need a **review step** before anything goes live

> This is not about becoming developers. This is about working smarter as a team.

---

## What Is Changing

We are adopting **three tools** for our daily content workflow:

| Tool        | What It Is                                           |
|-------------|------------------------------------------------------|
| **Terminal** | A window where you type short commands               |
| **LazyVim** | A fast text editor that runs inside the terminal     |
| **Git**     | A system that tracks every version of every file     |

You will use these every day. They replace emailing drafts around.

---

## Why the Terminal?

- It is **faster** than clicking through folders once you learn the basics
- It is the **same on every machine** -- Mac, Windows, Linux
- It is how professionals manage content at scale
- It removes the need for multiple apps -- everything happens in one window

You are not becoming a programmer. You are learning **six commands**.

---

## Why LazyVim?

LazyVim is a text editor that lives inside your terminal.

- **No switching windows** -- you write and save in the same place you run commands
- **Distraction-free** -- just you and the text, no toolbars or menus
- **Lightweight** -- opens instantly, never slows down
- Markdown files (what our newsletters are written in) look clean and readable

> Think of it as Notepad that lives inside the terminal. That is all.

---

## Why Git?

Git tracks **every change** you make to a file -- like a save history.

- You can always go back to a previous version
- Your manager can review your work **before** it goes live
- No more "final_v2_REAL_final.md" file names
- Everyone works from the **same up-to-date folder**

**GitHub** is the website where this shared folder lives online.

---

## What Your Daily Workflow Looks Like

```
Open terminal
   --> Pull latest changes
      --> Create your branch
         --> Open file in LazyVim, write, save
            --> Stage, commit, push
               --> Open a pull request for review
```

This takes **under two minutes** once it becomes routine.

---

<!-- _class: lead -->

# One-Time Setup

You do these steps **once**. After that, you go straight to the daily workflow.

---

## Setup: Install Git

Go to **https://git-scm.com** and download Git for your operating system.

Install it with **all the default settings**.

---

## Setup: Install Neovim + LazyVim

### Neovim (the engine)

Download from **https://neovim.io** and install with defaults.

### LazyVim (the configuration)

Your team lead will provide a setup script. Run it once:

```bash
bash <(curl -s https://raw.githubusercontent.com/ekohacks/dotfiles/main/setup.sh)
```

After this, typing `nvim` in the terminal opens LazyVim.

---

## Setup: Tell Git Who You Are

Open your terminal and type these two lines (use **your own** name and email):

```bash
git config --global user.name "Your Name"
git config --global user.email "your@email.com"
```

Press **Enter** after each line.

---

## Setup: Clone the Newsletter Folder

This downloads the shared folder to your machine:

```bash
git clone https://github.com/ekohacks/ekohacks-newsletter.git
```

Then enter it:

```bash
cd ekohacks-newsletter
```

Every command from now on is run **from inside this folder**.

---

<!-- _class: lead -->

# Your Daily Workflow

Follow these steps **in order**, every time you sit down to work.

---

## Step 1: Get the Latest Version

Before you touch any file:

```bash
git pull origin main
```

This makes sure you have the **most recent version** of everything.

Not pulling is the number one cause of problems. **Always do this first.**

---

## Step 2: Create Your Working Branch

A branch is your own copy. It keeps your work separate until it is reviewed.

```bash
git checkout -b draft/issue-01
```

For issue two: `draft/issue-02`, and so on.

You create the branch **once per issue**. After that you just work in it.

---

## Step 3: Open the File in LazyVim

Open your file directly in the terminal:

```bash
nvim issues/01-what-is-software-craftsmanship.md
```

### Essential LazyVim keys

| Key          | What It Does            |
|--------------|-------------------------|
| `i`          | Start typing (insert mode) |
| `Esc`        | Stop typing (back to normal mode) |
| `:w` + Enter | Save the file           |
| `:wq` + Enter | Save and close         |
| `:q!` + Enter | Close without saving   |

Write your draft. Press `Esc`, then type `:wq` and press Enter to save and exit.

---

## Step 4: Check What You Changed

```bash
git status
```

Your edited file will appear in **red** -- that means Git sees the change but has not saved it yet. This is normal.

---

## Step 5: Stage Your File

Tell Git to include your file in the next save:

```bash
git add issues/01-what-is-software-craftsmanship.md
```

Run `git status` again -- the file will now appear in **green** (ready to save).

---

## Step 6: Commit (Save a Checkpoint)

```bash
git commit -m "draft: issue 01 first draft"
```

This saves your work **locally** with a message describing what you did.

---

## Step 7: Push (Send to GitHub)

```bash
git push origin draft/issue-01
```

This sends your checkpoint to GitHub so your manager can see it.

You will see a link in the output. **Copy it** -- you will need it next.

---

## Step 8: Open a Pull Request

1. Go to **github.com/ekohacks/ekohacks-newsletter** in your browser
2. Click the yellow **"Compare & pull request"** banner
3. Write one sentence about what you did
4. Click **Create pull request**

Your manager reviews it, leaves feedback, and merges it when ready.

---

## Your Daily Cheat Sheet

| #  | Command                            | Plain English              |
|----|------------------------------------|----------------------------|
| 1  | `git pull origin main`             | Get the latest version     |
| 2  | `git checkout -b draft/issue-01`   | Create your workspace      |
| 3  | `nvim issues/01-...md`             | Open file and write        |
| 4  | `git status`                       | See what changed           |
| 5  | `git add <filename>`               | Stage your file            |
| 6  | `git commit -m "message"`          | Save a checkpoint          |
| 7  | `git push origin draft/issue-01`   | Send to GitHub             |

Print this. Tape it next to your screen.

---

## The Rules

**Always pull before you start.**
Not pulling is the number one cause of problems.

**Do not guess.**
If something looks wrong, stop. Tell your manager exactly what you see on screen.

**Do not try to fix Git errors yourself.**
Copy the error text, send it to your manager, and wait.

---

<!-- _class: lead -->

## If You See an Error

1. Do not panic
2. Read the error message carefully
3. **Copy the exact text** of the error
4. Send it to your manager with what you were doing when it happened
5. Do not try anything else until you hear back

---

<!-- _class: lead -->

# What Success Looks Like

- Everyone works from the **same source of truth**
- Every change is **reviewed** before it goes live
- No more lost drafts or version confusion
- You become faster at this **within a week**

> This is a small change in how you work that makes a big difference in what we ship.

---

<!-- _class: lead -->

# Questions?

Your team lead will walk you through setup one-on-one.

You are not expected to memorize everything today -- just understand the **why**.
