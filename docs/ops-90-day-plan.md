# Your 90-Day Plan

You are going to learn to run all your work from the terminal. Not because the terminal is cool, but because it is faster, more reliable, and gives you complete control over what you produce. Every document, every email draft, every report, every schedule — all of it will live in plain text files that you track with git. Nothing gets lost. Everything has a history.

By the end of 90 days you will be able to set up a dojo machine from a blank laptop, walk a new student through their first day, and manage Ekohacks operations without needing anyone to tell you what to do next.

Every task in this plan produces real output for Ekohacks. Nothing is practice for the sake of practice. You are learning by doing work that needs doing.

---

## How This Works

Each week has a focus and a set of tasks. The tasks teach you tools, but the tools are not the point — the work is the point. You do not study tmux and then use it. You need to have two things open at once, and tmux is how you do that.

At the end of each week there is a checkpoint. It is a task you should be able to do without help. If you can, move on. If you cannot, repeat the week. There is nothing wrong with repeating. The goal is that you actually know how to do it, not that you moved through the plan quickly.

---

## Before Day 1

Your machine gets set up using the Linux Install Guide. You do this with your manager. Watch the BIOS changes and the Debian installer so you understand what is happening. From Part 7 onwards (connecting to wifi and running the setup script), you type the commands yourself.

This matters because in Month 3, you will be the one setting up machines for students. The first time you see the process should not be the first time you do it alone.

---

## Month 1: Terminal and Git

The goal this month is to make the terminal feel like home. By week four you should not need to think about how to navigate folders, edit a file, or save your work to git. These become automatic, the way opening a folder with a mouse is automatic for you now.

---

### Week 1: Survival

**Focus:** Moving around, communicating, and building your daily rhythm.

The first week is not about being fast. It is about not being afraid. The terminal looks empty and unfamiliar. By Friday it should feel like a place where you know how things work, even if you are still slow.

**Tasks:**

- Work through the git guide (the newsletter one). Follow every step: set up git, clone the repo, make a branch, edit a file, commit, push. Do exactly what the guide says. The reason you follow it exactly is that these steps are the same workflow you will use for the next 90 days.

- Navigate the file system. Practice `cd`, `ls`, `pwd`, `mkdir` until you do not have to think about what they do. If you read the "Your First Day" guide, these are already familiar. Now make them automatic.

- Open and close Neovim ten times. This week you learn only four things about Neovim: press `i` to start typing, press `Escape` to stop typing, type `:wq` to save and quit, type `:q!` to quit without saving. That is it. Nothing else this week. Neovim has hundreds of features. You will learn them when you need them, not before.

- Learn to switch between i3 workspaces. Press `Super+1` through `Super+4`. Open a terminal on workspace 1. Open Firefox on workspace 4. Switch between them. This is how your screen is organised — code on the left workspaces, browser on the right.

- Set up Slack in Firefox on workspace 4. Pin the tab. This is how you communicate with the team. Check it first thing every morning and respond to messages within the hour.

- Set up Gmail in Firefox on workspace 4. Pin that tab too.

- Start the daily rhythm: open terminal, run `git pull`, check Slack, check email, start work. End of day: push your work, post in Slack what you did. This rhythm is not bureaucracy — it is how distributed teams stay connected. When people cannot see you working, your commits and your messages are the proof that work is happening.

**Tools you will use:** terminal basics, git basics, i3 basics, Neovim (absolute minimum), Slack, Gmail.

**Checkpoint:** Starting from a fresh terminal, clone a repository, create a branch, open a file in Neovim, add one sentence, save it, commit with a message, and push. Then send a Slack message confirming it is done. Without looking at any guide.

---

### Week 2: The Newsletter Workflow

**Focus:** Doing real content work through git.

Last week you learned the commands. This week you use them to produce something real. The difference matters — following a tutorial is not the same as doing work. Work means making decisions about what to write, how to structure it, when to save.

**Tasks:**

- Write the first newsletter issue in markdown using Neovim. The topic is "What is Software Craftsmanship?" — it is already in the content plan. You do not need to be an expert on the topic. Research it, write it, improve it.

- Learn basic markdown: headings with `#`, bold with `**`, links with `[text](url)`, lists with `-`. That is all the markdown you need for now. Markdown is plain text with formatting hints. The reason we use it instead of Word is that it works everywhere — git tracks it line by line, it converts to any format, and it never has compatibility problems.

- Commit as you write. Not one big commit at the end. Every paragraph or every meaningful change gets its own commit. This is a habit, not a rule. The reason: if you write for three hours and commit once, your entire session is one blob. If you commit every twenty minutes, you can see the shape of your work — where you started, where you rewrote, where you added.

- Open a pull request on GitHub. Write a description. Send the link for review. A pull request is how you ask someone to look at your work before it gets merged. It is quality control and it is also a record of the conversation about the work.

- Respond to review feedback. Edit the file, commit, push. Watch the pull request update. This back-and-forth — write, submit, get feedback, revise — is how professional work happens.

**Tools you will use:** markdown, Neovim text editing (beyond survival), git pull requests, GitHub web interface.

**Checkpoint:** Write a 500-word article in markdown, commit it in at least five separate commits with meaningful messages, push it, and open a pull request. The markdown should render correctly on GitHub.

---

### Week 3: File Management and Tmux

**Focus:** Managing multiple things at once without a mouse.

Until now you have worked with one terminal doing one thing. Real work is messier — you need to edit a file while looking at another file, or write while checking your tests, or browse folders while keeping your editor open. That is what tmux and ranger are for.

**Tasks:**

- Learn ranger for file browsing. Use it to navigate the newsletter repo, preview markdown files, copy and move files. Ranger is a file browser that runs in your terminal. The reason it exists: `ls` and `cd` are fine for simple navigation, but when you need to look through many folders, preview files, and move things around, ranger is faster.

- Learn tmux basics. Open tmux, split panes (`Ctrl+a v` for vertical, `Ctrl+a s` for horizontal), move between panes (`Ctrl+a h/j/k/l`). Practice having Neovim in one pane and a terminal in the other. Tmux lets you divide your screen into sections. The reason you want this: when you are editing code and running tests, you need to see both at the same time. Switching back and forth wastes time and breaks your focus.

- Organise the Ekohacks Google Drive content into a local folder structure. Download key documents, put them in a sensible hierarchy, commit the structure to a new repo called ekohacks-ops. This is real ops work — you are creating the organised system that does not exist yet.

- Write a weekly summary of what you did in `log/week-03.md`. Commit it. Weekly logging is a habit you are building. It matters because when someone asks "what happened in March?", the answer is in your logs, not in your memory.

**Tools you will use:** ranger, tmux, file organisation, weekly logging.

**Checkpoint:** Open tmux, create three panes (editor, terminal, file browser), navigate between them without the mouse, find a specific file in the ops repo using ranger, open it in Neovim, edit it. All in under two minutes.

---

### Week 4: Neovim Comfort

**Focus:** Editing at the speed of thought.

You have been using Neovim for three weeks. You can open files, type, save, quit. But you are probably still using arrow keys and deleting one character at a time. This week you learn to move and edit the way Neovim was designed to be used — by combining motions and operators.

This matters because text editing is the thing you do most. Every email, every report, every document, every commit message goes through your editor. A small improvement in how fast you edit multiplies across everything you do.

**Tasks:**

- Learn these motions: `w` (next word), `b` (previous word), `e` (end of word), `0` (start of line), `$` (end of line), `gg` (start of file), `G` (end of file), `/` (search). These are the only motions you need this month.

- Learn these operators: `d` (delete), `y` (yank/copy), `p` (paste), `c` (change). The power is in combining them: `dw` deletes a word, `d$` deletes to the end of the line, `yy` copies a line, `cw` deletes a word and puts you in insert mode to type the replacement. This is why Vim users are fast — instead of selecting text with a mouse and pressing delete, you say "delete the next three words" with `3dw`.

- Edit three newsletter drafts using only keyboard motions. No arrow keys.

- Write newsletter issue two. Full workflow: branch, write in markdown, commit incrementally, push, pull request.

- Start your monthly work log. One file per week in the ops repo under `log/`.

**Tools you will use:** Neovim motions, Neovim operators, fluent text editing.

**Checkpoint:** Open a file with 20 deliberate errors (typos, wrong words, missing punctuation). Fix all of them using Neovim motions and operators in under five minutes. No arrow keys, no mouse.

---

## Month 2: Ops Systems

The goal this month is to run all Ekohacks operations from the terminal. Email drafts, documents, schedules, tracking, reports — all of it. By week eight you should not need to leave i3 for any part of your job.

The reason this matters: when all your work lives in plain text files tracked by git, nothing gets lost, everything is searchable, and you can produce any format (PDF, Word, slides) from the same source. You are building a system that works for you instead of against you.

---

### Week 5: Documents with Pandoc

**Focus:** Producing professional output from markdown.

You have been writing markdown for a month. Now you learn to turn it into documents that other people expect — PDFs for clients, Word files for partners, slide decks for presentations. The source stays as markdown. The output changes depending on who needs it.

**Tasks:**

- Learn the `md2pdf`, `md2docx`, and `md2pptx` commands. Write a one-page document in markdown, convert it to PDF, open the PDF in Firefox to check it.

- Create an Ekohacks one-pager for potential corporate clients. Write it in markdown, convert to PDF. This is real — Ekohacks needs this document. Iterate on it until it looks professional enough to send.

- Create a slide deck for a dojo introduction talk. Write it in markdown with `---` between slides. Convert to PPTX with pandoc. You are learning that a slide deck is just a text file with separators.

- Learn the `watchfile` command. Run `watchfile proposal.md md2pdf` and watch the PDF update every time you save the markdown. This is your feedback loop — change the text, save, see the result immediately.

**Tools you will use:** pandoc, document workflow.

**Checkpoint:** Produce a three-page PDF proposal and a ten-slide PPTX deck from markdown source files. Both should look clean enough to send to a client.

---

### Week 6: Task and Schedule Management

**Focus:** Running operations from the terminal.

You need to track what is happening, what needs to happen, and when. Most people use apps for this. You are going to use plain text files and a terminal calendar. The advantage: your tasks are in git, so they have history. You can see when you added a task, when you finished it, and what you were working on any given week.

**Tasks:**

- Set up calcurse for schedule management. Enter dojo session dates, deadlines, and recurring events. Calcurse is a calendar that runs in your terminal. It does what Google Calendar does, but it lives on your machine and does not need internet.

- Create a task tracking system in the ops repo. One markdown file per week or per project. Tasks are lines starting with `- [ ]` (unchecked) and `- [x]` (done). Git tracks the history. This is simpler than any project management tool, and it works.

- Start tracking student enquiries in a CSV file. One row per enquiry: date, name, source, status. Edit it with sc-im (terminal spreadsheet). CSV is a format that every spreadsheet tool can read. You are not locked into any software.

- Write a weekly ops report in markdown. Tasks completed, tasks pending, blockers. Commit it to the ops repo. This becomes a standing Friday task from now on.

**Tools you will use:** calcurse, sc-im, task management in plain text, CSV handling.

**Checkpoint:** Show the current week's schedule in calcurse, the task list for the week in markdown, and the student enquiry tracker in sc-im. Explain what is pending and what is done.

---

### Week 7: Templates and Professional Communication

**Focus:** Writing clearly and efficiently.

A surprising amount of ops work is writing the same kind of message over and over. Welcome emails, logistics emails, enquiry responses, weekly updates. You are going to turn these into templates — markdown files you copy, personalise, and send. This saves time and keeps quality consistent.

**Tasks:**

- Set up a `templates/` folder in the ops repo. Common emails become markdown files.

- Write the student welcome email template. Write the dojo logistics email template. Write the corporate enquiry response template. Each one should have placeholder text where you fill in the specifics.

- Start drafting longer messages in Neovim first, then pasting into Slack or Gmail. Writing in your editor forces you to think before sending. You draft, you re-read, you revise, then you copy it over. This is not slower — it is better.

- Write an Ekohacks intro message for cold outreach to potential corporate clients. Iterate until it is sharp and short. A good intro message is under 100 words and tells the reader exactly what Ekohacks does and why they should care.

- Create a Slack message template for weekly team updates. Start using it every Friday.

- Review all your sent messages from the past six weeks. What do you write most often? Turn those into templates too. You are looking for patterns in your own work — that is how you find what to automate.

**Tools you will use:** writing templates, professional communication, self-review.

**Checkpoint:** Receive a mock student enquiry email. Draft a response using the template in Neovim, personalise it, and send it. Under ten minutes.

---

### Week 8: Scripting Basics

**Focus:** Automating repetitive work.

You have been doing the same things over and over for seven weeks — creating log files, formatting reports, counting enquiries. This week you learn to make the computer do the repetitive parts for you. A script is just a text file full of commands that run in sequence. You have been typing those commands by hand. Now they run themselves.

**Tasks:**

- Learn basic bash scripting. Variables, `echo`, `if` statements, `for` loops. Nothing fancy. You learn just enough to write useful scripts, not to become a programmer.

- Write a script that creates a new weekly log file with today's date and a template (headings for tasks done, tasks pending, blockers, notes). You have been creating these by hand. Now one command does it.

- Write a script that counts how many student enquiries are in each status (new, contacted, enrolled, declined) from the CSV file. You have been counting by eye. Now the computer counts.

- Write a script that generates the monthly ops report by combining all weekly logs from that month into one markdown file and converting it to PDF. You have been doing this manually. Now it takes one command.

- Commit all scripts to the ops repo under `scripts/`.

**Tools you will use:** bash scripting, text processing, automation.

**Checkpoint:** Run the monthly report script. It should produce a clean PDF covering four weeks of operations with no manual work beyond running the command.

---

## Month 3: Machine Setup and Student Onboarding

The goal this month is independence. By week twelve you can do everything that needs doing without waiting for someone to tell you how. You set up machines, you onboard students, you handle problems.

This is the month where the plan stops being about what you learn and starts being about what you can do for someone else. That shift — from learning for yourself to enabling someone else to learn — is what makes you ready.

---

### Week 9: Understanding the Setup Script

**Focus:** Knowing what every part of the dojo machine does and why.

You have been using this machine for two months. You know how to use the tools. Now you need to understand how they got there. When a student's machine has a problem, you need to know what to check and where to look.

**Tasks:**

- Read the entire `ekohacks-dojo-setup.sh` script line by line. For each section, write one sentence in plain English explaining what it does and why it is there. Save this as `docs/setup-explained.md` in the ops repo. This exercise is for you, not for anyone else. If you can explain it in your own words, you understand it. If you cannot, you found what you need to learn.

- Read the Linux Install Guide. Note anything that confused you when you first set up your machine. Suggest edits as a pull request. You are improving the documentation for the next person. You know what was unclear because you went through it.

- Learn what these diagnostic commands do by running them and reading the output: `uname -a`, `lsb_release -a`, `free -h`, `df -h`, `lscpu`, `ip a`, `nmcli`. These are the commands you will use to figure out what is wrong when a student's machine is not working. `free -h` tells you if the machine is out of memory. `df -h` tells you if the disk is full. `ip a` tells you if the network is connected.

- Intentionally break something on your own machine. Change a config file or uninstall a package. Then fix it. The point of this is confidence. When something breaks on a student's machine, you need to believe that you can figure it out. Breaking and fixing your own machine builds that belief.

**Tools you will use:** system administration basics, reading bash scripts, diagnostic commands.

**Checkpoint:** Explain in your own words what each section of the setup script does, why Debian 13 was chosen, and what the i3, Neovim, tmux, and vitest configs do. Without looking at your notes.

---

### Week 10: First Machine Setup

**Focus:** Setting up a dojo machine for someone else.

Reading the script is different from running it on a real machine with real problems. This week you do the whole thing end to end.

**Tasks:**

- Get a second laptop (borrow one, or use a virtual machine). Follow the Linux Install Guide from scratch. Do every step yourself. Your manager watches but does not help unless you are stuck for more than ten minutes. The reason for the ten-minute rule: struggling with a problem teaches you. Being told the answer does not. But struggling for too long without progress is just frustration, not learning.

- Run the setup script on the new machine. Verify everything works: i3 starts, Neovim opens, vitest runs, git is configured, wifi connects.

- Document every problem you hit and how you solved it. Add these to `docs/troubleshooting.md` in the ops repo. You are building a resource for yourself and for whoever comes after you.

- Create a pre-setup checklist: things to verify before a dojo session (machines charged, wifi tested, repos cloned, accounts created).

**Tools you will use:** full machine setup, troubleshooting, documentation.

**Checkpoint:** Set up a machine from a blank hard drive to a working dojo environment in under one hour with no help.

---

### Week 11: Student Onboarding Dry Run

**Focus:** Walking someone else through their first day.

Setting up a machine is technical. Onboarding a student is human. You need to explain things clearly, stay patient when they are confused, and let them do things themselves even when it would be faster to do it for them.

**Tasks:**

- Write a student onboarding guide. This is a document you create, not one that is handed to you. It should cover: what the student sees when they sit down, how to log in, how to open a terminal, how to run `dojo-start`, how to create their first kata, and the first five Neovim commands they need. Writing this document forces you to organise everything you know into something someone else can follow.

- Role-play with your manager. They pretend to be a student who has never seen a terminal. You walk them through the first hour. They ask basic questions. They make mistakes. You stay patient and clear. The reason for this: the first time you teach is always harder than you expect. It is better to discover that in a role-play than with a real student.

- Refine the guide based on what went wrong in the role-play. Commit the updated version.

- Create a "first day kit" folder in the ops repo: student onboarding guide, git guide, Neovim cheat sheet (just the week 1 commands), i3 cheat sheet, and a one-page "what is Ekohacks" overview.

**Tools you will use:** teaching, documentation, clear communication.

**Checkpoint:** Walk a real person — a friend, a family member, anyone who has not seen this before — through logging in, opening a terminal, creating a kata, and running their first test. Without referring to any notes.

---

### Week 12: Full Ownership

**Focus:** Running operations independently.

This is the week where you do everything. Not because your manager told you to do each thing, but because you know what needs doing and you do it.

**Tasks:**

- Set up machines for the next dojo cohort. If there are three students, you set up three machines.

- Send all pre-dojo communications: welcome emails, logistics, what to bring, what to expect. Use your templates.

- Prepare the dojo space: machines ready, wifi tested, schedule displayed.

- On dojo day, run student check-in, walk new students through their machines, handle any setup issues.

- After the session, collect feedback, write the session report, commit everything to the ops repo.

- Write your own 90-day retrospective in markdown. What you learned, what was hard, what you would change about this plan. Commit it. This retrospective is valuable because you have done something that no guide can fully capture — you went from zero to running operations. Your perspective on what helped and what didn't is worth recording.

**Tools you will use:** project management, event operations, independence.

**Checkpoint:** Run a dojo session end to end. Your manager observes but does not intervene. Students are set up, the session runs, reports are written. You own it.

---

## Weekly Rhythm (After Month 1)

Once you have the basics down, every week follows the same shape:

**Every morning:** Check Slack. Respond to anything from overnight. Post what you are working on today. Pull latest changes from all repos. This takes ten minutes. It keeps the team connected and it means you start each day with a clear plan.

**Monday:** Review the week's tasks. Update your calendar. Know what you are doing this week before you start doing it.

**Tuesday to Thursday:** Execute tasks. Commit work daily. Push at end of day. Post a short update in Slack before logging off.

**Friday:** Write the weekly report. Push it. Post a summary in Slack: what got done, what is blocked, what is planned for next week. Friday is for stepping back and seeing the whole week, not just the day.

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
