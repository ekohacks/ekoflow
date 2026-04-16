# Your First Day

You are sitting in front of a machine that looks nothing like what you are used to. There is no desktop. There are no icons. There is a black screen with a thin bar at the top and a blinking cursor.

That is not broken. That is your workspace.

This guide gets you comfortable before anything else happens. By the end of it you will know how to move around, open things, and feel in control. Everything else builds on this.

---

## What You Are Looking At

The bar at the top of your screen shows your CPU usage, memory, battery, and the time. That bar is part of something called **i3**. It is your window manager. Instead of dragging windows around with a mouse, you control everything with your keyboard.

There is a reason for this. A mouse is slow. You move your hand off the keyboard, you find the pointer, you click, you come back. Multiply that by hundreds of times a day and you are losing hours. At the dojo, everything is built so your hands stay on the keyboard.

You will feel slow at first. That is normal. By the end of the week it will feel natural.

---

## The Super Key

On your keyboard there is a key with a Windows logo on it, usually between Ctrl and Alt on the left side. At the dojo we call this the **Super** key.

Super is how you talk to i3. Almost everything you do starts with Super plus another key.

Try it now:

```
Super + Enter
```

Press both at the same time. A terminal window opens. That dark window with the blinking cursor is where you type commands.

---

## Your First Commands

The terminal is waiting for you to tell it what to do. Everything you type is a command. You press Enter to run it.

### Where am I?

Type this and press Enter:

```bash
pwd
```

You will see something like `/home/kofi`. That is your home folder. It is where your files live. `pwd` stands for "print working directory." It answers the question: where am I right now?

### What is in here?

```bash
ls
```

This lists everything in your current folder. You might see folders like `Desktop` or `Documents`, or it might be empty. `ls` answers: what is in this place?

### Going somewhere

```bash
cd Documents
```

This moves you into the Documents folder. `cd` stands for "change directory." A directory is just another word for folder.

Now check where you are:

```bash
pwd
```

You should see `/home/kofi/Documents` (or whatever your username is). You moved.

### Going back

```bash
cd ..
```

The two dots mean "go up one level." You are back in your home folder. Try `pwd` to confirm.

### Going home from anywhere

No matter where you are, this takes you home:

```bash
cd
```

Just `cd` with nothing after it. Try going somewhere, then coming back:

```bash
cd /etc
pwd
cd
pwd
```

The first `pwd` shows `/etc` (a system folder). The second shows your home folder. You can always get home.

### Making a folder

```bash
mkdir my-stuff
```

This creates a new folder called `my-stuff`. `mkdir` stands for "make directory." Now check it exists:

```bash
ls
```

You should see `my-stuff` in the list.

### Looking inside a file

```bash
cat /etc/hostname
```

This prints the contents of a file to your screen. `cat` answers: what is inside this file? You should see `ekohacks` because that is what your machine is called.

Try another one:

```bash
cat /etc/os-release
```

This tells you what operating system you are running. You will see something about Debian. That is your Linux distribution.

---

## Opening More Terminals

You can have more than one terminal open. Press:

```
Super + Enter
```

Again. Now you have two terminal windows. They are side by side. Each one is independent. You can type different commands in each one.

To move your focus between them:

```
Super + h    (move left)
Super + l    (move right)
Super + j    (move down)
Super + k    (move up)
```

These are the same keys you will use everywhere at the dojo: h, j, k, l for left, down, up, right. They come from an editor called Vim and they are everywhere in this environment.

Try it. Click in one terminal, type `pwd`. Move to the other one with `Super + h` or `Super + l`. Type `ls`. You are controlling two terminals without touching the mouse.

### Closing a window

To close the terminal you are focused on:

```
Super + Shift + q
```

This closes whatever window is active. Try opening two terminals and closing one.

---

## Workspaces

i3 gives you four workspaces. Think of them as four separate desks. You can only see one desk at a time, but you can switch between them instantly.

```
Super + 1    (workspace 1 — this is where your terminals live)
Super + 2    (workspace 2)
Super + 3    (workspace 3)
Super + 4    (workspace 4 — this is where Firefox lives)
```

Try pressing `Super + 2`. The screen goes empty. That is workspace 2. Nothing is there yet. Press `Super + 1` to go back to your terminals.

---

## Opening Firefox

You will need Firefox for things like Gmail, Slack, and GitHub. Here is how to open it.

Press:

```
Super + d
```

A bar appears at the top of the screen. This is called **dmenu**. It is your app launcher. Start typing:

```
firefox
```

You will see "firefox" or "firefox-esr" appear. Press Enter. Firefox opens.

Now here is the important thing: Firefox opened on whatever workspace you were on. At the dojo, we keep Firefox on workspace 4. So the workflow is:

```
Super + 4        (go to workspace 4)
Super + d        (open dmenu)
firefox          (type it)
Enter            (launch it)
```

Now Firefox lives on workspace 4. You can switch between your terminal on workspace 1 and Firefox on workspace 4 any time:

```
Super + 1    (back to terminal)
Super + 4    (back to Firefox)
```

Try it. Go to workspace 4, open Firefox, load any website. Then press `Super + 1` to go back to your terminal. Press `Super + 4` to go back to Firefox. Your browser is still there, exactly where you left it.

---

## Fullscreen

Sometimes you want a window to take up the whole screen. Press:

```
Super + f
```

The active window fills the screen. Press `Super + f` again to go back to normal. This is useful when you want to focus on one thing.

---

## A Few More Useful Commands

### Clearing the screen

Your terminal gets cluttered with old output. Clean it up:

```bash
clear
```

Or press `Ctrl + l`. Same thing.

### Seeing what is running

```bash
htop
```

This shows everything your computer is doing right now. You can see how much memory and CPU is being used. Press `q` to quit.

### Checking your internet

```bash
ping -c 3 google.com
```

If you see three lines with times in milliseconds, your internet works. If you see "Network is unreachable", your wifi is not connected.

### Connecting to wifi

```bash
sudo nmtui
```

It will ask for your password. A blue menu appears. Choose "Activate a connection", find your wifi, enter the password. Press Escape twice to leave.

The word `sudo` means "do this as an administrator." Some commands need extra permission. When you see `sudo` in front of a command, that is why.

---

## What Each Key Combination Does (Reference)

You do not need to memorise this now. Come back to it when you need it.

| Keys | What it does |
|------|-------------|
| Super + Enter | Open a new terminal |
| Super + d | Open the app launcher |
| Super + h/j/k/l | Move focus between windows |
| Super + 1/2/3/4 | Switch workspace |
| Super + f | Fullscreen toggle |
| Super + Shift + q | Close the focused window |
| Super + Shift + r | Restart i3 (if things look wrong) |

| Command | What it answers |
|---------|----------------|
| `pwd` | Where am I? |
| `ls` | What is in here? |
| `cd folder` | Go into a folder |
| `cd ..` | Go up one level |
| `cd` | Go home |
| `mkdir name` | Make a new folder |
| `cat file` | Show what is inside a file |
| `clear` | Clean up the screen |
| `sudo nmtui` | Connect to wifi |
| `ping -c 3 google.com` | Is my internet working? |

---

## What Comes Next

You now know how to move around your machine. You can open terminals, switch workspaces, open Firefox, navigate folders, and read files.

Everything else you learn at the dojo builds on these basics. When you create your first coding project, you will use `cd` to go into it. When you edit a file, you will use the terminal to open it. When you need to look something up, you will switch to Firefox on workspace 4.

If something feels confusing, go back and try the commands again. The more you type them, the more natural they become. There is no shortcut for this. The only way to learn the terminal is to use it.

You are ready for your first kata. Ask your instructor when you are comfortable, or move on to the next guide.
