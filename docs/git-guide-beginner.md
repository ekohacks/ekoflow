# Tracking Your Work With Git

You write something. You change it. You change it again. Then you realise the version from yesterday was better. But it is gone. You saved over it.

Or worse: you and someone else are both editing the same document. You send yours by email. They send theirs. Now someone has to sit down and merge two versions by hand, line by line, hoping nothing gets lost.

Git exists because these problems are real and they waste time. Git remembers every version of every file you have ever saved. It lets multiple people work on the same project without overwriting each other. And it does this without you needing to think about file names like `report-final-v2-FINAL-fixed.docx`.

This guide teaches you git by using it. You will be editing files in the Ekohacks newsletter repository. By the end, you will know the six commands that cover everything you need.

---

## What Is a Terminal?

A terminal is a window where you type instructions to your computer instead of clicking on things. If you are on a dojo machine, you already have one. Press `Super + Enter` to open it. If you are on your own machine, find the app called Terminal (Mac or Linux) or PowerShell (Windows).

You will see a blinking cursor. That is where you type. Every command you type gets run when you press Enter.

If you have never used a terminal before and you are on a dojo machine, read the "Your First Day" guide first. It covers the basics of moving around.

---

## What Is Git?

Think of git as a save system with memory. Every time you tell git to save (this is called a "commit"), it takes a snapshot of your files. You can look back at any snapshot. You can undo changes. You can see exactly what changed between two snapshots, line by line.

The reason this matters: when something breaks, you can find the exact moment it broke. When you want to try something risky, you can save first, knowing you can come back. When someone asks "what changed?", you can show them.

---

## What Is GitHub?

Git works on your computer. GitHub is a website that stores a copy of your work online. When you "push" your work to GitHub, your instructor can see it, review it, and give feedback, all without needing your laptop.

Git is the tool. GitHub is where the work lives so other people can see it.

---

## One-Time Setup

You do this once on your machine. After that, it is done forever.

### Install git

If you are on a dojo machine, git is already installed. Skip this step.

If you are on your own machine, go to https://git-scm.com and download git. Install it with the default settings.

### Tell git who you are

Open your terminal and type these two commands, replacing the name and email with your own:

```bash
git config --global user.name "Your Name"
git config --global user.email "your@email.com"
```

Why does git need your name? Because every snapshot (commit) you save gets stamped with who made it. When someone looks at the history, they can see that you wrote this paragraph, your colleague wrote that one. It is accountability and credit at the same time.

### Get the newsletter folder

This downloads the entire newsletter project to your computer:

```bash
git clone https://github.com/ekohacks/ekohacks-newsletter.git
```

When it finishes, go into the folder:

```bash
cd ekohacks-newsletter
```

Every command from here on happens inside this folder. If you ever get lost, type `cd` to go home, then `cd ekohacks-newsletter` to come back.

---

## The Workflow

Every time you sit down to work, you follow the same six steps. Each step solves a specific problem. Once you understand why each step exists, you will never forget the order.

---

### Step 1: Get the latest version

```bash
git pull origin main
```

**Why this matters.** Other people might have changed things since the last time you worked. If you start editing without pulling first, you are editing an old version. That causes conflicts later because git does not know whose version to keep.

This is the most important habit. Pull before you start. Every time.

---

### Step 2: Create your own workspace

```bash
git checkout -b draft/issue-01
```

**What this does.** It creates something called a "branch." A branch is your own copy of the project where you can make changes without affecting anyone else. Think of it like making a photocopy of a document so you can scribble on it freely. The original stays clean.

For issue two, it would be `draft/issue-02`. For issue three, `draft/issue-03`. The pattern matters because it tells anyone looking at the project what you are working on.

You only create the branch once. After that, you are already on it.

**Try it.** After running the command, type:

```bash
git branch
```

You will see a list of branches. The one with a star next to it is the one you are on. It should say `draft/issue-01`.

---

### Step 3: Edit your file

Open the file you need to edit. On a dojo machine you can use Neovim:

```bash
nvim issues/01-what-is-software-craftsmanship.md
```

Or use any editor you are comfortable with. Write your draft. Save the file.

---

### Step 4: See what changed

```bash
git status
```

**What you will see.** The file you edited appears in red. Red means git knows something changed, but you have not told it to include that change in your next save yet.

This command answers the question: what have I touched since my last save?

**Try it.** Run `git status` before and after editing a file. Notice how the output changes. Red text means "changed but not saved." No output means "everything is clean."

---

### Step 5: Tell git to include your file

```bash
git add issues/01-what-is-software-craftsmanship.md
```

**Why is this a separate step?** Because sometimes you change five files but only want to save three of them right now. `git add` lets you choose exactly what goes into each snapshot. It is like choosing which photos go into an album. You pick the ones that belong together.

Run `git status` again. The file should now appear in green. Green means "ready to be saved."

---

### Step 6: Save a snapshot

```bash
git commit -m "draft: issue 01 first draft"
```

**What this does.** It takes everything in green (everything you `add`ed) and saves a permanent snapshot with a message explaining what you did. That message matters because six months from now, someone will read it to understand what happened here.

Good messages describe what you did and why:
- `"draft: first draft of issue 01"` is clear
- `"fix: corrected the date in the header"` is specific
- `"updated stuff"` is useless, do not write this

After committing, run `git status` again. It should say "nothing to commit, working tree clean." Everything is saved.

---

### Sending your work to GitHub

```bash
git push origin draft/issue-01
```

This sends your saved snapshots to GitHub. Your instructor can now see your work.

The first time you push a new branch, git might show you a longer command. Just copy and paste what it suggests.

---

### Getting feedback

Go to https://github.com/ekohacks/ekohacks-newsletter in your browser. You will see a yellow bar saying your branch has recent changes with a button that says **Compare & pull request**. Click it. Write one sentence about what you did. Click **Create pull request**.

A pull request is how you say: "I am done. Please look at this." Your instructor reviews it and leaves comments. If they ask you to change something, edit the file, go through Steps 4-6 again (status, add, commit), and push. The pull request updates automatically.

---

## The Six Commands

These are the only six commands you need. Each one answers a question.

| Command | Question it answers |
|---------|-------------------|
| `git pull origin main` | What has changed since I last worked? |
| `git checkout -b draft/issue-01` | How do I start working without affecting others? |
| `git status` | What have I changed? |
| `git add filename` | What do I want to include in my next save? |
| `git commit -m "message"` | Save this snapshot with this description |
| `git push origin draft/issue-01` | Send my work to GitHub |

---

## What To Do When Something Goes Wrong

Errors in git look scary. They are usually not.

**Read the error message.** Git almost always tells you what happened and what to do about it. The answer is usually in the last two lines.

**Do not guess.** If you do not understand the error, copy the exact text and send it to your instructor. Tell them what you were doing when it happened. Guessing at git commands when you are learning makes things worse.

**The most common mistake** is forgetting to pull before you start. If git says something about "divergent branches" or "merge conflicts," this is almost certainly why. Tell your instructor. It is fixable.

---

## Why This Matters

You are not just learning commands. You are learning a way of working that every software team in the world uses. Git is how code gets written, reviewed, and shared. When you are comfortable with these six commands, you already know the workflow that professional developers use every day.

The commands are simple. The habit is what matters: pull, branch, work, save, push, get feedback. That cycle is the same whether you are writing a newsletter or building an application.
