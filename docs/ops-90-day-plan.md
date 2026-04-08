# Ekohacks Operations Manager: 90 Day Onboarding Plan

This plan turns a complete beginner into someone who runs their work from the terminal, manages the Ekohacks content and admin through git, and can set up dojo machines for incoming students.

Every task in this plan produces real output for Ekohacks. Nothing is busywork. The training is the job.

---

## How This Works

Each week has a focus, a set of tasks, and the tools those tasks teach. Your manager does not study the tools separately. He learns them by doing work that needs doing.

At the end of each week there is a checkpoint. If he can do the checkpoint task without help, he moves on. If he cannot, he repeats the week. There is no shame in repeating. The dojo way is mastery, not speed.

---

## Before Day 1

Set up his machine using the Ekohacks Linux Install Guide. Walk through it together. He watches you do the BIOS changes and the Debian installer. He types the commands himself from Part 7 onwards. This is his first lesson: follow instructions exactly.

---

## Month 1: Terminal and Git

The goal this month is to make the terminal feel like home. By week four he should never need to ask how to navigate folders, edit a file, or commit to git.

---

### Week 1: Survival

**Focus:** Moving around the terminal, setting up communication, and not panicking.

**Tasks:**
- Work through the git guide you already wrote (the newsletter one). Set up git, clone the repo, make a branch, edit a file, commit, push. Do exactly what the guide says.
- Navigate the file system. Practice cd, ls, pwd, mkdir until it is automatic.
- Open and close Neovim ten times. Learn only: i to type, Escape to stop typing, :wq to save and quit, :q! to quit without saving. Nothing else this week.
- Learn to switch between i3 workspaces (Super+1 through Super+4). Open a terminal on workspace 1. Open Firefox on workspace 4. Switch between them.
- Set up Slack in Firefox on workspace 4. Pin the tab. This is how you communicate with the team every day. Check it first thing in the morning and respond to messages within the hour.
- Set up Gmail in Firefox on workspace 4. Pin that tab too.
- Learn the daily rhythm: open terminal, `git pull`, check Slack, check email, start work. End of day: push your work, update Slack with what you did.

**Tools learned:** terminal basics, git basics, i3 basics, Neovim absolute minimum, Slack, daily communication rhythm.

**Checkpoint:** Starting from a fresh terminal, clone a repository, create a branch, open a file in Neovim, add one sentence, save it, commit with a message, and push. Then send a Slack message confirming it is done. Without looking at the guide.

---

### Week 2: The Newsletter Workflow

**Focus:** Doing real content work through git.

**Tasks:**
- Write the first newsletter issue in markdown in Neovim. Use the newsletter repo. The topic is "What is Software Craftsmanship?" since that is already in your content plan.
- Learn basic markdown: headings with #, bold with **, links with [text](url), lists with -. That is all the markdown he needs for now.
- Make multiple commits as he writes. Not one big commit at the end. Commit every paragraph or every meaningful change. Practice the habit.
- Open a pull request on GitHub. Write a description. Send the link to you for review.
- Respond to your review feedback. Edit the file, commit, push. See the pull request update.

**Tools learned:** markdown, Neovim text editing (beyond survival), git workflow with pull requests, GitHub web interface.

**Checkpoint:** Write a 500 word article in markdown, commit it in at least five separate commits with meaningful messages, push it, and open a pull request. The markdown should render correctly on GitHub.

---

### Week 3: File Management and Tmux

**Focus:** Managing multiple things at once without a mouse.

**Tasks:**
- Learn ranger for file browsing. Use it to navigate the newsletter repo, preview markdown files, copy and move files between folders.
- Learn tmux basics. Open tmux, split panes (Ctrl+a v and Ctrl+a s), move between panes (Ctrl+a h/j/k/l). Practice having Neovim in one pane and a terminal in the other.
- Organise the Ekohacks Google Drive content into a local folder structure. Download key documents, put them in a sensible hierarchy, commit the structure to a new repo called ekohacks-ops.
- Write a weekly summary of what he did in a file called `log/week-03.md`. Commit it.

**Tools learned:** ranger, tmux, file organisation, weekly logging habit.

**Checkpoint:** Open tmux, create three panes (editor, terminal, file browser), navigate between them without touching the mouse, find a specific file in the ops repo using ranger, open it in Neovim, and edit it. All in under two minutes.

---

### Week 4: Neovim Comfort

**Focus:** Editing at the speed of thought.

**Tasks:**
- Learn Neovim motions: w, b, e for word movement. 0 and $ for line start/end. gg and G for file start/end. / for search. These are the only motions he needs this month.
- Learn d (delete), y (yank/copy), p (paste), c (change). Combine them with motions: dw deletes a word, d$ deletes to end of line, yy copies a line.
- Edit three newsletter drafts using only keyboard motions. No arrow keys allowed.
- Write newsletter issue two. Full workflow: branch, write in markdown, commit incrementally, push, pull request.
- Start his work log for the month. One file per week in the ops repo under log/.

**Tools learned:** Neovim motions, Neovim operators, fluent text editing.

**Checkpoint:** Open a file with 20 deliberate errors (typos, wrong words, missing punctuation). Fix all of them using Neovim motions and operators in under five minutes. No arrow keys, no mouse.

---

## Month 2: Ops Systems

The goal this month is to run all Ekohacks operations from the terminal. By week eight he should be managing schedules, producing documents, tracking tasks, and communicating, all without leaving i3.

---

### Week 5: Documents with Pandoc

**Focus:** Producing professional output from markdown.

**Tasks:**
- Learn the md2pdf, md2docx, and md2pptx commands from the shell config. Write a one page document in markdown, convert it to PDF. Open the PDF in Firefox to check it.
- Create an Ekohacks one pager for potential corporate clients. Write it in markdown, convert to PDF. Iterate on it until it looks professional.
- Create a simple slide deck for a dojo introduction talk. Write it in markdown with --- between slides. Convert to PPTX with pandoc.
- Learn the watchfile command. Run `watchfile proposal.md md2pdf` and watch the PDF update every time he saves the markdown file.

**Tools learned:** pandoc, document workflow, LaTeX basics (margins, fonts via pandoc flags).

**Checkpoint:** Produce a three page PDF proposal and a ten slide PPTX deck from markdown source files. Both should look clean enough to send to a client.

---

### Week 6: Task and Schedule Management

**Focus:** Running operations from the terminal.

**Tasks:**
- Set up calcurse for schedule management. Enter the dojo session dates, deadlines, and recurring events.
- Create a task tracking system in the ops repo. One markdown file per week or per project. Tasks are lines starting with `- [ ]` (unchecked) and `- [x]` (done). Git tracks the history.
- Start tracking student enquiries in a CSV file. One row per enquiry: date, name, source, status. Edit it with sc-im (terminal spreadsheet).
- Write a weekly ops report in markdown summarising tasks completed, tasks pending, and blockers. Commit it to the ops repo. This becomes a standing Friday task.

**Tools learned:** calcurse, sc-im, task management in plain text, CSV handling.

**Checkpoint:** Show the current week's schedule in calcurse, the task list for the week in markdown, and the student enquiry tracker in sc-im. Explain what is pending and what is done.

---

### Week 7: Templates and Professional Communication

**Focus:** Writing clearly and efficiently for different audiences.

**Tasks:**
- Set up a templates folder in the ops repo. Common emails he sends repeatedly become markdown files he edits and copies.
- Write the student welcome email template. Write the dojo logistics email template. Write the corporate enquiry response template.
- Learn to draft longer messages in Neovim first, then paste them into Slack or Gmail. This forces him to think before sending. Write the draft, review it, then copy it over.
- Write an Ekohacks intro message for cold outreach to potential corporate clients. Iterate on it until it is sharp and short.
- Create a Slack message template for weekly team updates. Start using it every Friday.
- Review all his sent messages from the past six weeks. Identify patterns: what does he write most often? Turn those into templates too.

**Tools learned:** writing templates, professional tone, efficient communication, self review.

**Checkpoint:** Receive a mock student enquiry email. Draft a response using the template in Neovim, personalise it, and send it. Under ten minutes.

---

### Week 8: Scripting Basics

**Focus:** Automating repetitive ops tasks.

**Tasks:**
- Learn basic bash scripting. Variables, echo, if statements, for loops. Nothing fancy.
- Write a script that creates a new weekly log file with today's date and a template (headings for tasks done, tasks pending, blockers, notes).
- Write a script that counts how many student enquiries are in each status (new, contacted, enrolled, declined) from the CSV file.
- Write a script that generates the monthly ops report by combining all weekly logs from that month into one markdown file and converting it to PDF.
- Commit all scripts to the ops repo under scripts/.

**Tools learned:** bash scripting, text processing, automation mindset.

**Checkpoint:** Run the monthly report script. It should produce a clean PDF covering four weeks of operations with no manual intervention beyond running the command.

---

## Month 3: Machine Setup and Student Onboarding

The goal this month is to make him self sufficient. By week twelve he can set up a dojo machine for a new student, walk them through their first day, and handle problems without you.

---

### Week 9: Understanding the Setup Script

**Focus:** Knowing what every part of the dojo machine does.

**Tasks:**
- Read the entire ekohacks-dojo-setup.sh script line by line. For each section, write one sentence in plain English explaining what it does and why. Save this as docs/setup-explained.md in the ops repo.
- Read the Linux Install Guide. Note anything confusing or unclear. Suggest edits as a pull request.
- Learn what these commands do by running them and reading the output: `uname -a`, `lsb_release -a`, `free -h`, `df -h`, `lscpu`, `ip a`, `nmcli`. These are the commands he will use to diagnose problems on student machines.
- Intentionally break something on his own machine (change a config file, uninstall a package) and fix it. This builds confidence that things can be recovered.

**Tools learned:** system administration basics, reading bash scripts, diagnostic commands.

**Checkpoint:** Explain in his own words what each section of the setup script does, why Debian 13 was chosen, and what the i3, Neovim, tmux, and vitest configs do. Without reading his notes.

---

### Week 10: First Machine Setup

**Focus:** Setting up a dojo machine for someone else.

**Tasks:**
- Get a second laptop (borrow one, buy a cheap one, or use a virtual machine). Follow the Linux Install Guide from scratch. Do every step himself. You watch but do not help unless he is stuck for more than ten minutes.
- Run the setup script on the new machine. Verify everything works: i3 starts, Neovim opens, vitest runs, git is configured, wifi connects.
- Document every problem he hits and how he solved it. Add these to a troubleshooting section in the ops repo at docs/troubleshooting.md.
- Create a pre-setup checklist: things to verify before a dojo session (machines charged, wifi tested, repos cloned, accounts created).

**Tools learned:** full machine setup, troubleshooting, documentation.

**Checkpoint:** Set up a machine from a blank hard drive to a working dojo environment in under one hour with no help.

---

### Week 11: Student Onboarding Dry Run

**Focus:** Walking a new person through their first day.

**Tasks:**
- Write the student onboarding guide. This is a document he creates, not one you give him. It should cover: what the student sees when they first sit down, how to log in, how to open a terminal, how to run dojo-start, how to create their first kata, and the first five Neovim commands they need.
- Role play with you. You pretend to be a student who has never seen a terminal. He walks you through the first hour. You ask dumb questions. You make mistakes. He stays patient and clear.
- Refine the guide based on what went wrong in the role play. Commit the updated version.
- Create a "first day kit" folder in the ops repo: student onboarding guide, git guide, Neovim cheat sheet (just the week 1 commands), i3 cheat sheet, and a one page "what is Ekohacks" overview.

**Tools learned:** teaching, documentation for others, patience, clear communication.

**Checkpoint:** Walk a real person (a friend, a family member, anyone who has not seen this before) through logging in, opening a terminal, creating a kata, and running their first test. Without referring to any notes himself.

---

### Week 12: Full Ownership

**Focus:** Running operations independently.

**Tasks:**
- Set up machines for the next dojo cohort. If there are three students, he sets up three machines.
- Send all pre-dojo communications: welcome emails, logistics, what to bring, what to expect.
- Prepare the dojo space: machines ready, wifi tested, schedule printed (or displayed on a screen as a markdown file, naturally).
- On dojo day, he runs student check-in, walks new students through their machines, and handles any setup issues.
- After the dojo session, he collects feedback, writes the session report, and commits everything to the ops repo.
- Write his own 90 day retrospective in markdown. What he learned, what was hard, what he would change. Commit it.

**Tools learned:** project management, event operations, independence.

**Checkpoint:** Run a dojo session end to end. You observe but do not intervene. Students are set up, the session runs, reports are written. He owns it.

---

## Weekly Rhythm (After Month 1)

Every week follows this pattern:

**Every morning:** Check Slack. Respond to anything from overnight. Post what you are working on today. Pull latest changes from all repos.

**Monday:** Review the week's tasks in the ops repo. Update calcurse with the week's schedule.

**Tuesday to Thursday:** Execute tasks. Commit work daily. Push at end of day. Post a short update in Slack before logging off.

**Friday:** Write the weekly log. Push it. Post a summary in Slack: what got done, what is blocked, what is planned for next week.

---

## Tools Reference

| Tool | What it does | When he uses it |
|------|-------------|----------------|
| Neovim | Text editing | Everything: documents, code, emails, logs |
| git | Version control | Every piece of work he produces |
| tmux | Terminal multiplexer | Whenever he needs multiple things open |
| ranger | File browser | Navigating folders, moving files |
| pandoc | Document conversion | Producing PDFs, DOCX, PPTX from markdown |
| calcurse | Calendar and scheduling | Managing dojo dates and deadlines |
| sc-im | Terminal spreadsheet | Student tracking, simple data |
| Firefox | Web browser | Gmail, Slack, GitHub, web research |
| Slack (in Firefox) | Team communication | Daily standups, updates, questions |
| i3 | Window manager | Always running, everything lives in it |

---

## Graduation Criteria

After 90 days he should be able to:

1. Set up a dojo machine from a blank laptop in under one hour.
2. Walk a new student through their first terminal session with no notes.
3. Produce a professional PDF document from markdown in under five minutes.
4. Manage all Ekohacks operations (scheduling, communication, tracking, reporting) entirely from the terminal.
5. Write a simple bash script to automate a repetitive task.
6. Troubleshoot common machine issues (wifi not connecting, display not working, package not installing) without help.
7. Explain what every part of the Ekohacks setup does and why.

When he can do all seven, he is ready to be the person who onboards others. That is the goal.