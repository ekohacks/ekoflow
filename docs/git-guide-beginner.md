# How to Edit Newsletter Files Using Git

This guide assumes you have never used a terminal before. Read every word. Do not skip ahead.

---

## What Is a Terminal?

A terminal is a window where you type instructions to your computer instead of clicking. On a Mac it is called Terminal. On Windows it is called Command Prompt or PowerShell. On Linux it is called Terminal.

Find it on your machine and open it. You will see a blinking cursor. That is where you type.

---

## What Is Git?

Git is a tool that tracks every change you make to a file. Think of it like a save history for your work. Every time you save a checkpoint in git, you can always go back to it. It also lets other people see your work and leave feedback before it is accepted.

---

## What Is GitHub?

GitHub is a website that stores your git work online. Your manager can see everything you push there. Think of git as the tool and GitHub as the place where the work lives.

---

## Before You Start: One Time Setup

You only do this once on your machine.

### Step 1: Install Git

Go to https://git-scm.com and download git for your operating system. Install it with all the default settings.

### Step 2: Tell Git Who You Are

Open your terminal and type these two lines. Replace the name and email with your own.

```bash
git config --global user.name "Your Name"
git config --global user.email "your@email.com"
```

Press Enter after each line.

### Step 3: Get the Newsletter Folder onto Your Machine

This is called cloning. It downloads the repository to your computer.

```bash
git clone https://github.com/ekohacks/ekohacks-newsletter.git
```

Press Enter. You will see some text appear. When it stops, type:

```bash
cd ekohacks-newsletter
```

Press Enter. You are now inside the newsletter folder. Every command from here on is run from inside this folder.

---

## Every Time You Sit Down to Work

Follow these steps in order every single time. Do not skip any of them.

---

### Step 1: Get the Latest Version

Before you touch any file, run this. It makes sure you have the most recent version of everything.

```bash
git pull origin main
```

Press Enter and wait for it to finish.

---

### Step 2: Create Your Own Working Space

This is called creating a branch. It means you work in your own copy so you do not affect anyone else.

For issue one, type:

```bash
git checkout -b draft/issue-01
```

For issue two it would be `draft/issue-02` and so on. Always follow this pattern.

You only create the branch once per issue. After that you just work in it.

---

### Step 3: Open the File and Write

Go to the newsletter folder on your computer using your normal file explorer. Open the file you need to edit using any text editor. Write your draft. Save the file when you are done.

Come back to the terminal when you are ready to save your work to git.

---

### Step 4: Check What You Have Changed

Type this and press Enter:

```bash
git status
```

You will see the name of the file you edited listed in red. That means git can see the change but has not saved it yet. This is normal.

---

### Step 5: Tell Git to Include Your File

Type this, replacing the filename with the one you edited:

```bash
git add issues/01-what-is-software-craftsmanship.md
```

Press Enter. Nothing obvious will happen. That is fine. Run `git status` again and the file will now appear in green. Green means it is ready to be saved.

---

### Step 6: Save a Checkpoint

This is called a commit. It is your saved checkpoint with a message explaining what you did.

```bash
git commit -m "draft: issue 01 first draft"
```

Press Enter. You will see some confirmation text. That means your work is saved locally.

---

### Step 7: Send Your Work to GitHub

This is called pushing. It sends your saved checkpoint to GitHub so your manager can see it.

```bash
git push origin draft/issue-01
```

Press Enter. When it finishes you will see a link. Copy that link and send it to your manager.

---

### Step 8: Open a Pull Request

Go to https://github.com/ekohacks/ekohacks-newsletter in your browser. You will see a yellow bar near the top saying your branch has recent changes with a button that says Compare and pull request. Click it. Write one sentence describing what you have done. Click Create pull request.

That is it. Your manager will review it and leave feedback.

---

## The Six Commands You Need to Know

These are the only six commands you need for this work. Learn them in order.

```bash
git pull origin main
```
Get the latest version before you start.

```bash
git checkout -b draft/issue-01
```
Create your working space.

```bash
git status
```
Check what has changed.

```bash
git add issues/01-what-is-software-craftsmanship.md
```
Tell git to include your file.

```bash
git commit -m "your message here"
```
Save a checkpoint.

```bash
git push origin draft/issue-01
```
Send your work to GitHub.

---

## Rules

Pull before you start every single time. Not pulling is the most common cause of problems.

Do not guess if something looks wrong. Stop and tell your manager exactly what you see on the screen.

Do not try to fix git errors yourself until you have more experience. Guessing makes things worse.

---

## If You See an Error

Do not panic. Read the error message carefully. Copy the exact text of the error and send it to your manager with a description of what you were doing when it happened. Do not try anything else until you hear back.
