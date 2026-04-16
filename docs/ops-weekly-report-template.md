# Weekly Report

**Name:**  
**Week:** (e.g. Week 3 of 12)  
**Dates:** Monday DD/MM to Friday DD/MM

---

## Every Day

Your daily routine is in the [Daily Report Template](ops-daily-report-template.md). Follow it every day. It covers your morning startup, how to work through the day, and how to close out.

This weekly template adds two things on top of that daily routine: a Monday setup and a Friday report. The rest of the week, you just follow the daily routine and work through your tasks.

### Monday extra (30 minutes)

On Monday morning, after your daily startup (steps 1-5 in the daily template), do these before you start working. This is how you turn five disconnected days into a week with a clear shape. You know exactly what you are trying to finish by Friday.

- [ ] Write down your top 5 tasks for the week in Section 8 of this report. Pull them from the 90-day plan and any ongoing ops work.
- [ ] Check if anything from last week is unfinished. Either carry it forward to this week's list or drop it. If you drop it, write one sentence saying why, so you are making a decision, not just forgetting.
- [ ] Post your weekly plan in Slack: "This week: 1... 2... 3..."

Then start working. Monday is not a planning day. It is a working day with 30 extra minutes of setup.

### Friday extra (45 minutes)

On Friday, stop working 45 minutes before end of day. This is when you step back and see the whole week, not just today, but the pattern of what worked and what did not. That is how you get better week over week.

- [ ] Fill out the full weekly report below.
- [ ] Do the checkpoint for your current week: can you do the checkpoint task without help? Write yes or no honestly. The checkpoint is for you. If you pass it, you know you are ready to move on. If you do not, you know what to practice.
- [ ] Push the weekly report to the ops repo.
- [ ] Post in Slack: what got done this week, what is blocked, what you are doing next week.

### If you finish a big task or checkpoint

Set up a short screen sharing call to show it. Showing your work is how you confirm you actually understand it. Explaining something out loud reveals gaps that reading it in your head does not.

---

## Weekly Report

### 1. Tasks Completed

Everything you finished this week. One line per task with a link to the commit or pull request.

- [ ] 
- [ ] 
- [ ] 

### 2. Tasks Still In Progress

Anything you started but did not finish. Say how far along it is and what remains.

- [ ] 
- [ ] 

### 3. Blockers

Anything stopping you from making progress. For each blocker, say what you need and who can help. Naming the blocker specifically is important — "I am stuck" is not actionable. "I cannot connect to wifi on the second laptop and I need someone to check if the wifi card is supported" is.

| Blocker | What I need | Who can help |
|---------|-------------|-------------|
|         |             |             |

### 4. Numbers

Fill in any that apply this week. Write 0 if none, do not leave blank. Numbers show trends. If enquiries are climbing, you might need to adjust your week. If commits are dropping, something is slowing you down.

- Student enquiries received: 
- Student enquiries responded to: 
- Emails sent: 
- Documents produced (PDF/PPTX): 
- Commits pushed: 
- Pull requests opened: 

### 5. What I Learned This Week

Two or three things you understand better now than you did on Monday. Connect each one to the work you did. "I learned tmux" is weak. "I learned to split tmux panes so I can edit in one pane and test in the other, which made the newsletter workflow faster" is strong.

1. 
2. 
3. 

### 6. Checkpoint

What is the checkpoint for your current week in the 90-day plan? Write it here. Then answer: can you do it without help right now?

**Checkpoint task:**  
**Can I do it without help? (yes/no):**  
**If no, what do I still need to practice?**  

### 7. Reflection

This section is how you get better week over week. Noticing what worked lets you do more of it. Noticing what did not lets you change it. The question "what will I do differently?" turns observation into action.

**What went well this week?**


**What did not go well?**


**What will I do differently next week?**


### 8. Plan for Next Week

List your top 5 tasks for next week in order of priority. Pull these from the 90-day plan and any ongoing ops work. Five is the limit. More than five and nothing gets finished properly.

1. 
2. 
3. 
4. 
5. 

---

## How To Submit

1. Save this file as `log/weekly/week-NN.md` in the ops repo.
2. `git add` the file, commit with message: `weekly report week NN`.
3. Push.
4. Post the full Section 1, Section 3, and Section 8 in Slack on Friday before you log off.
