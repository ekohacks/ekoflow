# Your 90 Day Plan

You are going to learn to run all your work from the terminal. Not because the terminal is cool, but because it is faster, more reliable, and gives you complete control over what you produce. Every document, every email draft, every report, every schedule will live in plain text files that you track with git. Nothing gets lost. Everything has a history.

By the end of 90 days you will be able to set up a dojo machine from a blank laptop, walk a new student through their first day, and manage Ekohacks operations without needing anyone to tell you what to do next.

Every task in this plan produces real output for Ekohacks. Nothing is practice for the sake of practice. You are learning by doing work that needs doing.

---

## How This Works

Each week has a set of numbered tasks. Do them in order. Tick each one when it is done. Your manager can see your progress by looking at this file.

At the end of each week there is a checkpoint. It is one task you do without help. If you can do it, move on. If you cannot, repeat the week. There is nothing wrong with repeating. The goal is that you actually know how to do it, not that you moved through the plan quickly.

---

## Before Day 1

Your machine gets set up using the Linux Install Guide. You do this with your manager. You are watching now so that when you set up machines for students in Month 3, it is not the first time you are seeing this.

1. Watch your manager do the BIOS changes and the Debian installer. Do not touch the keyboard yet. Just watch and ask questions about anything you do not understand. The install process has decisions that affect whether Linux runs properly, so understanding them now saves you from guessing later.
2. From Part 7 onwards (connecting to wifi and running the setup script), you type the commands yourself while your manager reads them to you. Typing them yourself is how your hands start learning the terminal.
3. After setup, reboot, log in, run `startx`. Confirm you see the i3 screen with the status bar.

---

## Month 1: Terminal and Git

By week four you should not need to think about how to navigate folders, edit a file, or save your work to git. These become automatic, like opening a folder with a mouse is automatic for you now.

---

### Week 1: Survival

The first week is not about being fast. It is about not being afraid. The terminal looks empty and unfamiliar. By Friday it should feel like a place where you know how things work, even if you are still slow.

**Tasks:**

1. Read `docs/your-first-day.md`. Do every command in it. This guide teaches you the basic actions (moving around, opening things, typing commands) that everything else depends on. When you get to "What Comes Next" at the bottom, you are done with this task.
2. Read `docs/git-guide-beginner.md`. Follow every step from "One Time Setup" through "Sending your work to GitHub." These are the same six commands you will use every day for the next 90 days. This is not a tutorial, it is your actual workflow. When you have pushed your first commit, you are done with this task.
3. Practice terminal navigation. These four commands are how you move around your machine. You need them to be automatic, not something you have to think about. Open a terminal and do this sequence 5 times from memory:
   - `pwd` (check where you are)
   - `mkdir test-folder` (make a folder)
   - `cd test-folder` (go into it)
   - `pwd` (confirm you moved)
   - `cd ..` (go back)
   - `ls` (confirm the folder is there)
   - When you can do all six without thinking, this task is done.
4. Practice Neovim open/close. Neovim is your editor and you will use it for everything you write. This week you learn only how to get in and out safely. Do this 10 times:
   - Type `nvim test.txt`
   - Press `i`, type a sentence, press `Escape`
   - Type `:wq` and press Enter
   - Type `cat test.txt` to confirm your sentence was saved
   - When you can do this without hesitation, this task is done.
5. Practice i3 workspaces. Workspaces let you organise your screen so terminals live on one workspace and the browser on another. Switching between them is instant, which is why this is faster than alt tabbing through a pile of windows. Do this 3 times:
   - Press `Super+1` (workspace 1)
   - Press `Super+Enter` (open terminal)
   - Press `Super+4` (workspace 4)
   - Press `Super+d`, type `firefox`, press Enter
   - Press `Super+1` (back to terminal)
   - Press `Super+4` (back to Firefox)
   - When you can switch without looking at your hands, this task is done.
6. Set up Slack in Firefox on workspace 4. Go to your Slack workspace URL. Log in. Right click the tab and select "Pin Tab." Slack is how you communicate with the team, so if you are not checking it, nobody knows if you are working or stuck.
7. Set up Gmail in Firefox on workspace 4. Go to gmail.com. Log in. Pin the tab.
8. Do the daily rhythm once from start to finish. This rhythm is not bureaucracy. It is how distributed teams stay connected. When people cannot see you working, your commits and your Slack messages are the proof that work is happening.
   - Open terminal
   - Run `git pull` in the newsletter repo
   - Press `Super+4`, check Slack, reply to anything
   - Check Gmail, reply to anything
   - Post in Slack: "Today I am working on: [what you are doing]"
   - At end of day: run `git push`, post in Slack what you did

**Checkpoint:** Starting from a fresh terminal, do all of these without looking at any guide:
- Clone a repository
- Create a branch
- Open a file in Neovim
- Add one sentence
- Save it
- Commit with a message
- Push
- Send a Slack message confirming it is done

---

### Week 2: The Newsletter Workflow

Last week you learned the commands. This week you use them to produce something real. The difference matters because following a tutorial is not the same as doing work. Work means making decisions about what to write, how to structure it, when to save.

**Tasks:**

1. Learn these four markdown rules. Markdown is plain text with formatting hints. The reason we use it instead of Word is that git tracks it line by line, it converts to any format, and it never has compatibility problems. You do not need more than these four for now:
   - `# Heading` makes a heading
   - `**bold**` makes bold text
   - `[text](url)` makes a link
   - `- item` makes a bullet list
2. Create a branch for the first newsletter issue:
   - `git checkout -b draft/issue-01`
3. Open the file in Neovim:
   - `nvim issues/01-what-is-software-craftsmanship.md`
4. Write the first paragraph. Save it. Go to the terminal and commit it:
   - `git add issues/01-what-is-software-craftsmanship.md`
   - `git commit -m "draft: issue 01 first paragraph"`
5. Write the second paragraph. Save. Commit again with a different message. The reason for committing after every paragraph instead of at the end: if you write for three hours and commit once, your entire session is one blob. If you commit every twenty minutes, you can see the shape of your work, where you started, where you rewrote, where you added. Small commits also make it easy to undo one thing without losing everything.
6. Continue until the article is at least 500 words. You should have at least 5 commits by the end.
7. Push your branch:
   - `git push origin draft/issue-01`
8. Open GitHub in Firefox. Find the yellow bar that says your branch has recent changes. Click "Compare & pull request." Write one sentence describing what you did. Click "Create pull request." A pull request is how you ask someone to look at your work before it gets merged. It is quality control, and it is also a record of the conversation about the work.
9. Send the pull request link to your manager for review.
10. When you get review feedback: open the file, make the changes, commit, push. The pull request updates automatically. This back and forth of writing, submitting, getting feedback, and revising is how professional work happens everywhere.

**Checkpoint:** The pull request is open on GitHub with at least 5 commits, meaningful commit messages, and markdown that renders correctly.

---

### Week 3: File Management and Tmux

Until now you have worked with one terminal doing one thing. Real work is messier because you need to edit a file while looking at another file, or write while checking your tests. Tmux and ranger exist because doing one thing at a time is too slow when you have real work to do.

**Tasks:**

1. Open tmux. Tmux lets you divide your screen into sections so you can see multiple things at once, like editing code on one side and running tests on the other. That is why it matters.
   - Type `tmux` and press Enter
2. Split into two vertical panes:
   - Press `Ctrl+a` then `v`
3. Move between panes:
   - Press `Ctrl+a` then `h` (left) or `Ctrl+a` then `l` (right)
4. Practice: open Neovim in the left pane, keep a terminal in the right pane. Edit a file on the left, run `git status` on the right. Do this 5 times until switching feels natural.
5. Split horizontally:
   - Press `Ctrl+a` then `s`
6. Now you have three panes. Move between all three using `Ctrl+a` then `h/j/k/l`. Practice until it is automatic.
7. Open ranger. Ranger is a file browser that runs in your terminal. `ls` and `cd` are fine for simple navigation, but when you need to look through many folders and preview files, ranger is faster.
   - Type `r` and press Enter (it is aliased)
   - Use `j/k` to move up and down, `Enter` to go into a folder, `h` to go back
   - Navigate to the newsletter repo. Find a markdown file. Press `Enter` to preview it.
   - Press `q` to quit ranger.
8. Do this in ranger 3 times: navigate to a file, preview it, go back to the parent folder.
9. Download the key documents from Ekohacks Google Drive to your machine. You are creating the organised system that does not exist yet. This is real ops work, not an exercise. Create a folder structure:
   - `mkdir -p ~/ekohacks-ops/docs`
   - `mkdir -p ~/ekohacks-ops/templates`
   - Put documents in the right folders.
10. Turn it into a git repo. Once it is in git, nothing gets lost and you can see the history of every change.
    - `cd ~/ekohacks-ops`
    - `git init`
    - `git add .`
    - `git commit -m "initial: organise ops documents"`
11. Write a weekly summary in `log/week-03.md`. What you did, what you learned, what was hard. Commit it. Weekly logging matters because when someone asks "what happened in March?", the answer is in your logs, not in your memory.

**Checkpoint:** Open tmux, create three panes (editor, terminal, file browser), navigate between them without the mouse, find a specific file using ranger, open it in Neovim, edit it. All in under two minutes.

---

### Week 4: Neovim Comfort

You have been using Neovim for three weeks. You can open files, type, save, quit. But you are probably still using arrow keys and deleting one character at a time. This week you learn to edit the way Neovim was designed to be used, by combining motions and operators.

This matters because text editing is the thing you do most. Every email, every report, every document goes through your editor. A small improvement in how fast you edit multiplies across everything you do.

**Tasks:**

1. Learn these 8 motions. Open any text file in Neovim and try each one. Motions are how you move around a file without touching the arrow keys or the mouse.
   - `w` jumps to the next word
   - `b` jumps to the previous word
   - `e` jumps to the end of the current word
   - `0` jumps to the start of the line
   - `$` jumps to the end of the line
   - `gg` jumps to the start of the file
   - `G` jumps to the end of the file
   - `/word` then Enter searches for "word"
2. Practice: open a long file. Jump to the end (`G`), back to the top (`gg`), search for a word (`/something`), move word by word (`w w w`). Do this for 10 minutes.
3. Learn these 4 operators. Operators are actions you combine with motions. Instead of selecting text with a mouse and pressing delete, you say "delete the next three words" with `3dw`. That is why Vim users are fast.
   - `d` deletes
   - `y` copies (called yank)
   - `p` pastes
   - `c` changes (deletes and enters insert mode)
4. Learn to combine them. Try each one in a file:
   - `dw` deletes one word
   - `d$` deletes from cursor to end of line
   - `dd` deletes entire line
   - `yy` copies entire line, then `p` pastes it
   - `cw` deletes a word and starts typing the replacement
   - `3dw` deletes three words
5. Open a newsletter draft. Edit it using only motions and operators. No arrow keys. If you catch yourself using arrow keys, stop and use `h/j/k/l` instead. Edit for 20 minutes.
6. Do this with two more newsletter drafts. 20 minutes each.
7. Write newsletter issue two. Full workflow:
   - `git checkout -b draft/issue-02`
   - Write in Neovim using motions
   - Commit after every paragraph
   - Push and open a pull request
8. Create `log/week-04.md` in the ops repo. Write your weekly summary. Commit.

**Checkpoint:** Your manager gives you a file with 20 deliberate errors (typos, wrong words, missing punctuation). Fix all of them using motions and operators. Under five minutes. No arrow keys, no mouse.

---

## Month 2: Ops Systems

By week eight you should be able to manage scheduling, communication, tracking, and reporting entirely from the terminal. The reason this matters: when all your work lives in plain text files tracked by git, nothing gets lost, everything is searchable, and you can produce any format (PDF, Word, slides) from the same source. You are building a system that works for you instead of against you.

---

### Week 5: Documents with Pandoc

You have been writing markdown for a month. Now you turn it into documents other people expect: PDFs for clients, Word files for partners, slides for presentations. The source stays as markdown. The output changes depending on who needs it.

**Tasks:**

1. Convert a markdown file to PDF. This is the core skill. You write once in markdown and produce whatever format the recipient needs.
   - `md2pdf report.md`
   - Open the PDF in Firefox: `Super+4`, then open `report.pdf`
   - Check that it looks right.
2. Convert a markdown file to Word:
   - `md2docx report.md`
3. Create a markdown file with `---` between each slide and convert it to a slide deck:
   - `md2pptx slides.md`
4. Write an Ekohacks one pager for corporate clients in markdown. This is real because Ekohacks needs this document. It should be one page, explaining what Ekohacks does, who it is for, and why it matters. Convert to PDF. Open in Firefox. Is it clean enough to send? If not, edit and convert again. Iterate until it is professional.
5. Write a dojo introduction slide deck in markdown. At least 10 slides. Convert to PPTX.
6. Learn the watch command. This gives you an instant feedback loop so you can change the text, save, and see the result without reconverting manually.
   - `watchfile proposal.md md2pdf`
   - Open Neovim in one tmux pane and Firefox with the PDF in another. Edit, save, watch it update.
7. Commit all your documents to the ops repo.

**Checkpoint:** Show your manager a three page PDF and a ten slide PPTX, both produced from markdown. They should look clean enough to send to a client.

---

### Week 6: Task and Schedule Management

You need to track what is happening, what needs to happen, and when. Most people use apps for this. You are going to use plain text files and a terminal calendar. The advantage: your tasks are in git, so they have history. You can see when you added a task, when you finished it, and what you were working on any given week. No app gives you that.

**Tasks:**

1. Open calcurse. It is a calendar that runs in your terminal. It does what Google Calendar does, but it lives on your machine and does not need internet.
   - Type `cal` and press Enter (it is aliased)
2. Add the next dojo session date. Navigate to the right day using arrow keys, press `a` to add an appointment.
3. Add any deadlines you know about.
4. Add a recurring event: "Weekly report" on Fridays. Press `a`, set it to repeat weekly.
5. Quit calcurse: press `q`, then `y` to save.
6. Create a task tracking file. Task tracking in plain text is simpler than any project management tool, and git gives you the full history of what changed and when.
   - `nvim tasks/week-06.md`
   - Write tasks as `- [ ] task description` (unchecked) and `- [x] task description` (done)
   - Commit it.
7. Create a student enquiry tracker. CSV is a format every spreadsheet tool can read, so you are not locked into any software.
   - `nvim enquiries.csv`
   - First line: `date,name,source,status`
   - Add one example row: `2026-04-16,Jane Doe,website,new`
   - Save and commit.
8. Open the CSV in sc-im to see it as a spreadsheet:
   - `sheet enquiries.csv`
   - Navigate with `h/j/k/l`. Press `q` to quit.
9. Write this week's ops report in markdown. Tasks completed, tasks pending, blockers. Commit to ops repo. This is now a standing Friday task. From here on, every Friday you do this.

**Checkpoint:** Open calcurse and show this week's schedule. Open the task file and show what is done and what is pending. Open the enquiry tracker in sc-im and explain each row.

---

### Week 7: Templates and Professional Communication

A surprising amount of ops work is sending the same kind of message over and over: welcome emails, logistics, enquiry responses, weekly updates. Templates save time and keep quality consistent. Instead of writing each email from scratch and hoping you remember everything, you start from a proven structure and personalise it.

**Tasks:**

1. Create the templates folder:
   - `mkdir -p ~/ekohacks-ops/templates`
2. Write the student welcome email template. Include placeholders like `[STUDENT NAME]`, `[DATE]`, `[LOCATION]` so you can personalise quickly.
   - `nvim templates/welcome-email.md`
   - Commit.
3. Write the dojo logistics email template. Include: date, time, location, what to bring, what to expect.
   - `nvim templates/logistics-email.md`
   - Commit.
4. Write the corporate enquiry response template:
   - `nvim templates/corporate-response.md`
   - Commit.
5. Write a cold outreach message for potential corporate clients. A good intro message is under 100 words and tells the reader exactly what Ekohacks does and why they should care. Read it out loud. If it sounds stiff, rewrite it.
   - `nvim templates/corporate-outreach.md`
   - Commit when it is sharp.
6. Write a Slack weekly update template. Start using it this Friday.
   - `nvim templates/slack-weekly-update.md`
   - Commit.
7. Look through your sent Slack messages and emails from the past six weeks. Write down any message you sent more than twice. Turn each one into a template. You are looking for patterns in your own work because that is how you find what to automate. Commit.
8. Practice the new workflow: when you need to send a message, open the template in Neovim, copy it, replace the placeholders, paste it into Slack or Gmail. Writing in your editor forces you to think before sending. You draft, reread, revise, then copy it over.

**Checkpoint:** Your manager sends you a mock student enquiry email. Draft a response using your template in Neovim, personalise it, and send it. Under ten minutes.

---

### Week 8: Scripting Basics

You have been creating log files, formatting reports, and counting enquiries by hand for seven weeks. This week the computer does the repetitive parts. A script is just a text file full of commands that run in sequence. You have been typing those commands one at a time. Now they run themselves.

**Tasks:**

1. Create the scripts folder:
   - `mkdir -p ~/ekohacks-ops/scripts`
2. Write your first script. This one creates a weekly log file automatically, something you have been doing by hand every week. Now one command does it.
   - `nvim scripts/new-weekly-log.sh`
   - Write these lines:
     ```bash
     #!/bin/bash
     DATE=$(date +%Y-%m-%d)
     WEEK=$1
     FILE="log/weekly/week-${WEEK}.md"
     cat > "$FILE" << EOF
     # Week $WEEK
     **Date:** $DATE
     ## Tasks Done
     -
     ## Tasks Pending
     -
     ## Blockers
     -
     ## Notes
     -
     EOF
     echo "Created $FILE"
     ```
   - Save it. Make it executable: `chmod +x scripts/new-weekly-log.sh`
   - Test it: `./scripts/new-weekly-log.sh 08`
   - Check the file was created: `cat log/weekly/week-08.md`
3. Write a script that counts enquiry statuses. You have been counting by eye. Now the computer counts.
   - `nvim scripts/count-enquiries.sh`
   - It should read `enquiries.csv` and count how many rows have status "new", "contacted", "enrolled", "declined"
   - Test it against your CSV.
4. Write a script that generates a monthly report. You have been doing this manually, combining weekly logs and converting to PDF. Now it takes one command.
   - `nvim scripts/monthly-report.sh`
   - It should combine all weekly logs from a given month into one markdown file and convert it to PDF using `md2pdf`.
   - Test it.
5. Commit all three scripts.
6. Run the monthly report script. Open the resulting PDF in Firefox. Does it look right? If not, edit the script and run again.

**Checkpoint:** Run the monthly report script. It produces a clean PDF covering four weeks of operations. No manual work beyond typing one command.

---

## Month 3: Machine Setup and Student Onboarding

By week twelve you can do everything that needs doing without waiting for someone to tell you how. This is the month where the plan stops being about what you learn and starts being about what you can do for someone else. That shift, from learning for yourself to enabling someone else to learn, is what makes you ready.

---

### Week 9: Understanding the Setup Script

You have been using this machine for two months. You know how to use the tools. Now you need to understand how they got there. When a student's machine has a problem, you cannot fix what you do not understand.

**Tasks:**

1. Open the setup script:
   - `nvim ekohacks-dojo-setup.sh`
2. Read it from top to bottom. For each section (separated by comments), write one sentence explaining what it does and why. If you can explain it in your own words, you understand it. If you cannot, you found what you need to learn. Save your notes:
   - `nvim docs/setup-explained.md`
3. When you finish, commit your explanation file.
4. Read `docs/linux-install-guide.md`. Write down anything that confused you when your machine was set up. Open a pull request with suggested improvements. You are improving the documentation for the next person because you know what was unclear, having gone through it yourself.
5. Run each of these diagnostic commands and write down what the output means. These are the commands you will use to figure out what is wrong when a student's machine is not working:
   - `uname -a` shows what operating system and kernel version
   - `lsb_release -a` shows what Debian version
   - `free -h` shows how much memory is used and available
   - `df -h` shows how much disk space is used and available
   - `lscpu` shows what processor the machine has
   - `ip a` shows what network interfaces exist and their IP addresses
   - `nmcli` shows wifi connection status
6. Save your notes about each command in `docs/diagnostic-commands.md`. Commit.
7. Break something on your own machine on purpose. The point of this is confidence. When something breaks on a student's machine, you need to believe you can figure it out. Breaking and fixing your own machine builds that belief. Pick one:
   - Rename `~/.config/nvim/init.lua` to `init.lua.bak`
   - Or run `sudo apt remove ranger`
8. Fix what you broke:
   - If you renamed the config: `mv ~/.config/nvim/init.lua.bak ~/.config/nvim/init.lua`
   - If you removed ranger: `sudo apt install ranger`
9. Write down what happened and how you fixed it. Add it to `docs/troubleshooting.md`. Commit.

**Checkpoint:** Your manager asks you to explain what each section of the setup script does, why Debian 13 was chosen, and what the i3, Neovim, tmux, and vitest configs do. You explain it in your own words without reading your notes.

---

### Week 10: First Machine Setup

Reading the script is different from running it on a real machine with real problems. This week you do the whole thing end to end.

**Tasks:**

1. Get a second laptop (borrow one, or use a virtual machine).
2. Follow the Linux Install Guide from Part 1. Do every step yourself. Your manager watches but does not help unless you are stuck for more than ten minutes. The reason for the ten minute rule: struggling with a problem teaches you. Being told the answer does not. But struggling for too long without progress is just frustration, not learning.
3. Run the setup script on the new machine:
   - `cd dojo-setup && chmod +x ekohacks-dojo-setup.sh && ./ekohacks-dojo-setup.sh`
4. Verify each of these works on the new machine:
   - [ ] `startx` starts i3
   - [ ] `Super+Enter` opens Alacritty
   - [ ] `nvim` opens Neovim without errors
   - [ ] `tmux` starts, `Ctrl+a T` creates TDD layout
   - [ ] `dojo-init test-kata` creates a project and vitest runs
   - [ ] Git is configured with the student's name and email
   - [ ] Firefox opens with `Super+d` then typing "firefox"
   - [ ] Wifi connects after reboot
5. Write down every problem you hit and how you solved it. Add them to `docs/troubleshooting.md`. You are building a resource for yourself and for whoever comes after you. Commit.
6. Create a pre session checklist: things to verify before a dojo session. Save it as `docs/pre-session-checklist.md`. Commit.

**Checkpoint:** Set up a machine from a blank hard drive to a working dojo environment in under one hour with no help.

---

### Week 11: Student Onboarding Dry Run

Setting up a machine is technical. Onboarding a student is human. You need to explain things clearly, stay patient when they are confused, and let them do things themselves even when it would be faster to do it for them.

**Tasks:**

1. Write a student onboarding guide. This is a document you create, not one that is handed to you. Writing it forces you to organise everything you know into something someone else can follow. Save it as `docs/student-first-day.md`. It should cover:
   - What the student sees when they sit down (i3 screen, status bar)
   - How to log in
   - How to open a terminal (`Super+Enter`)
   - How to run `dojo-start`
   - How to create their first kata (`dojo-init hello-world`)
   - The first five Neovim commands: `i`, `Escape`, `:wq`, `:q!`, `nvim filename`
2. Commit the guide.
3. Role play with your manager. They pretend to be a student who has never seen a terminal. Walk them through the first hour using your guide. They will ask basic questions and make mistakes on purpose. Stay patient. The first time you teach is always harder than you expect, so it is better to discover that in a role play than with a real student.
4. After the role play, write down what went wrong or was unclear. Update the guide. Commit.
5. Create a "first day kit" folder in the ops repo. This is everything a new student needs in one place:
   - `mkdir -p ~/ekohacks-ops/first-day-kit`
   - Copy into it: your student onboarding guide, the git guide, a Neovim cheat sheet (just week 1 commands), an i3 cheat sheet, a one page "what is Ekohacks" overview.
   - Write any missing documents. Commit.

**Checkpoint:** Walk a real person (a friend, a family member, anyone) through logging in, opening a terminal, creating a kata, and running their first test. Without looking at any notes.

---

### Week 12: Full Ownership

This is the week where you do everything. Not because your manager told you to do each thing, but because you know what needs doing and you do it.

**Tasks:**

1. Check how many students are in the next cohort. Set up one machine per student.
2. Send the welcome email to every student using your template. Personalise each one.
3. Send the logistics email to every student using your template.
4. The day before the session:
   - [ ] Charge all machines to 100%
   - [ ] Test wifi on every machine
   - [ ] Run `dojo-start` on every machine
   - [ ] Run `dojo-init test-kata` on every machine, confirm vitest works, then delete the test kata
   - [ ] Print cheat sheets (one set per student)
   - [ ] Confirm the room is ready (power sockets, seating, internet)
5. On dojo day:
   - [ ] Arrive 30 minutes before students
   - [ ] Turn on all machines, run `startx`, open a terminal on each
   - [ ] Put cheat sheets at each desk
   - [ ] When students arrive, walk each one through the onboarding guide yourself
   - [ ] Handle any setup issues
6. After the session:
   - [ ] Collect feedback from students
   - [ ] Write the session report: date, number of students, what was covered, any issues
   - [ ] Save it as `reports/session-YYYY-MM-DD.md`. Commit and push.
   - [ ] Update the student tracker CSV. Commit and push.
   - [ ] Send follow up email to students.
7. Write your 90 day retrospective in markdown. What you learned, what was hard, what you would change about this plan. This retrospective is valuable because you have done something no guide can fully capture. You went from zero to running operations. Your perspective on what helped and what did not is worth recording. Commit it.

**Checkpoint:** Your manager watches the entire dojo session without intervening. Students are set up, the session runs, reports are written. You own it.

---

## Tools Reference

| Tool | What it does | When you use it |
|------|-------------|-----------------|
| Neovim | Text editing | Everything: documents, code, emails, logs |
| git | Version control | Every piece of work you produce |
| tmux | Terminal multiplexer | Whenever you need multiple things open |
| ranger | File browser | Navigating folders, moving files |
| pandoc | Document conversion | Producing PDFs, DOCX, PPTX from markdown |
| calcurse | Calendar | Managing dojo dates and deadlines |
| sc-im | Spreadsheet | Student tracking, simple data |
| Firefox | Web browser | Gmail, Slack, GitHub, research |
| Slack | Team communication | Daily standups, updates, questions |
| i3 | Window manager | Always running, everything lives in it |

---

## Graduation Criteria

After 90 days you should be able to:

1. Set up a dojo machine from a blank laptop in under one hour.
2. Walk a new student through their first terminal session with no notes.
3. Produce a professional PDF document from markdown in under five minutes.
4. Manage all Ekohacks operations (scheduling, communication, tracking, reporting) entirely from the terminal.
5. Write a simple bash script to automate a repetitive task.
6. Troubleshoot common machine issues (wifi, display, packages) without help.
7. Explain what every part of the Ekohacks setup does and why.

When you can do all seven, you are the person who onboards others. That is the goal. Not because someone promoted you to it, but because you can actually do it.
