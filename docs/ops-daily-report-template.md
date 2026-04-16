# Daily Report

**Name:**  
**Date:**  
**Week number:** (e.g. Week 3 of 12)

---

## Every Day

You do these steps in this order, every day. They keep you moving and they make your work visible. When you work independently, nobody sees you typing. Your commits, your Slack updates, and your reports are how the team knows work is happening. This is not about proving yourself. It is about staying connected so problems get caught early and progress is clear.

### First 30 minutes

1. Open your terminal. Run `git pull` on all your repos. This gets you the latest version of everything before you start. Skipping this is the most common cause of git conflicts later.
2. Open Firefox on workspace 4 (`Super+4`). Check Slack. Reply to anything. Slack is how the team communicates, so if you do not check it, nobody knows if you are working or stuck.
3. Check Gmail. Reply to anything urgent.
4. Open the 90-day plan. Read your current week's tasks. Pick the one you are working on today.
5. Post in Slack: "Today I am working on: [one task]." This tells your manager what to expect from you today and lets them redirect you if priorities have changed.

### The rest of the day

6. Work on one task until it is done. Do not start a second task until the first one is finished or you are blocked. Jumping between tasks feels productive but produces less. Finishing one thing is better than half-finishing three.
7. Commit every time you finish something meaningful. A finished draft is a commit. A completed template is a commit. Small commits make it easy to see what you did and undo what went wrong without losing everything else.
8. If you are stuck for more than 15 minutes: (1) reread the docs, (2) search online, (3) if still stuck, set up a screen sharing call. This order matters because most of the time the answer is already in the docs. Searching builds the skill of finding answers yourself. Calling is for when the first two genuinely did not work.
9. When one task is done, pick the next one from the 90-day plan. You do not need to wait for someone to tell you.

### Last 15 minutes

10. Run `git status`. If anything is uncommitted, commit and push it now. Work that is not pushed does not exist to anyone but you.
11. Fill out the report below.
12. Post in Slack: what you finished, what you are doing tomorrow. Three lines maximum.

---

## Daily Report

### 1. What I Did Today

One line per task. Be specific. "Worked on stuff" tells nobody anything. "Wrote the welcome email template and committed it to ops repo" tells exactly what happened.

- 
- 
- 

### 2. What I Produced

Link to every commit, pull request, file, or message you created today. This is the evidence of your work. If you cannot link to it, it is hard for anyone to verify or build on what you did. If you did not produce anything, write why.

- 
- 

### 3. Where I Got Stuck

If a problem slowed you down for more than 15 minutes, write it here. This does two things: it helps your manager know where to support you, and it helps you notice patterns in what trips you up. If the same kind of problem keeps appearing, that is a signal to study it properly instead of just getting past it each time.

- **Problem:**  
  **What I tried:**  
  **Solved? (yes/no):**  

### 4. What I Learned

One thing you understand now that you did not understand this morning. Naming what you learned makes it stick. If you cannot think of anything, look back at what you struggled with. The learning is usually hiding there.

- 

### 5. What I Am Doing Tomorrow

Write it now so you start immediately in the morning instead of spending the first hour figuring out what to do. Planning tomorrow is the last thing you do today, not the first thing you do tomorrow.

- 
- 

---

## How To Submit

1. Save this file as `log/daily/YYYY-MM-DD.md` in the ops repo.
2. `git add` the file, commit with message: `daily report YYYY-MM-DD`.
3. Push.
4. Post a short summary (3 lines max) in Slack before you log off.
