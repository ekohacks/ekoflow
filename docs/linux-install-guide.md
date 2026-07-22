# Setting Up Your Dojo Machine

Right now your laptop runs Windows or macOS. Either way it uses most of its 8GB of RAM just to show you a desktop. Most of that memory goes to things you never asked for: background services, telemetry, preinstalled apps, visual effects. Your machine is working hard, but not for you.

After this guide, your laptop will use about 200MB of RAM at idle. Everything you removed was something you did not need. Everything that remains is something you chose. That is the point.

This takes about 45 minutes. You will need a USB stick (at least 1GB) and a wifi connection. If your machine is the MacBook, you will also need a phone that can do USB tethering or an ethernet adapter, because the MacBook's wifi only starts working once setup completes. Part 5 explains what to do.

---

## Before You Touch Anything

### Back Up Your Files

This process erases Windows completely. Everything on your laptop will be gone. If there is anything you want to keep (photos, documents, anything) copy it to an external drive or Google Drive now. Not later. Now.

### What You Need

- A USB stick, at least 1GB, that you do not mind erasing
- Another device (phone or another computer) to read this guide while your laptop is being set up
- Your wifi network name and password written down on paper
- MacBook only: a phone with a USB cable for tethering, or an ethernet adapter

---

## Part 1: Getting Debian

On your current computer, go to:

```
https://www.debian.org/distrib/netinst
```

Download the file called **debian-13.x.x-amd64-netinst.iso**. It is about 600MB. The version number changes, so pick the most recent one.

Why Debian? There are hundreds of Linux distributions. Debian was chosen because it is stable, well supported, and will receive security updates until 2030. It does not try to be flashy. It does what you tell it and stays out of the way. That matters when you are learning because you do not want your operating system surprising you.

Why the netinst version? It is a minimal installer. Instead of downloading 4GB of software you might not need, it downloads only what you ask for during installation. You are going to ask for almost nothing, because the setup script handles the rest.

---

## Part 2: Making the USB Bootable

You cannot just copy the .iso file onto the USB stick. A bootable USB has a special structure that tells the computer "you can start up from me." Copying the file would be like putting a CD in a drawer. It is there, but nothing knows how to play it.

### On Windows

Download Rufus from https://rufus.ie. It is free and runs without installing.

Plug in your USB stick. Open Rufus. Under "Device" select your USB stick. Under "Boot selection" click SELECT and choose the debian .iso file. Leave everything else as it is. Click START.

If it asks about ISO mode or DD mode, choose ISO mode. Wait a few minutes for it to finish.

### On Mac

Download balenaEtcher from https://etcher.balena.io. Open it. Click "Flash from file" and pick the .iso. Click "Select target" and choose your USB stick. Click "Flash." Wait for it to finish.

---

## Part 3: Changing Your Laptop's BIOS Settings

### On the MacBook: nothing to change

Macs do not have BIOS settings you need to touch. The firmware already knows how to boot from USB. When the time comes (Part 4), you will hold down a key while turning the machine on. Skip ahead to Part 4.

### On the HP EliteBook

Your laptop has a tiny program built into it called the BIOS. It runs before anything else: before Windows, before Linux, before anything. The BIOS decides what to boot from and how the hardware behaves.

You need to change three things in the BIOS so your laptop will start from the USB stick and let Linux run.

Turn off your laptop completely. Not sleep, not restart. Shut it down fully.

Turn it on and immediately start pressing **F10** repeatedly. You will enter a screen with old fashioned blue and grey menus. That is the BIOS. It is supposed to look like that.

### What to change and why

Navigate with arrow keys. Press Enter to select things.

**Secure Boot → Disabled**

Secure Boot is a security feature that only allows the laptop to run software signed by Microsoft. Debian is not signed by Microsoft. If you leave this on, the laptop will refuse to start Linux. Disabling it tells the laptop: I decide what runs here, not Microsoft.

**Boot Order → USB before hard drive**

Find the Boot tab. Make sure USB is listed before the hard drive. This tells the laptop: when you turn on, check the USB stick first. If there is something bootable on it, start from there.

**Storage Mode → AHCI (if you see it)**

Some HP EliteBooks have a setting called SATA Emulation or Intel RST. If you see this, change it to AHCI. This is about how the laptop talks to its hard drive. Linux works better with AHCI. If you do not see this setting, skip it. Not every laptop has it.

Press **F10** to save and exit. The laptop restarts.

---

## Part 4: Booting From the USB

### On the MacBook

Turn off the laptop. Plug in the USB stick. Turn it on while holding down the **Option** key (also labelled alt) and keep holding until a row of drive icons appears. Use the arrow keys to pick the one called **EFI Boot** and press Enter. The Debian installer appears.

### On the HP EliteBook

Turn off your laptop. Plug in the USB stick. Turn it on.

If you set the boot order correctly, the Debian installer will appear. If Windows starts instead, turn the laptop off and try again. This time press **F9** during startup. That opens a one time boot menu where you can manually select the USB stick.

---

## Part 5: Installing Debian

You will see a menu. Select **Install** (not Graphical Install). The text installer is simpler and works on every machine.

Each screen asks you a question. Here is what to choose and why.

### Language → English

The terminal, the documentation, and the error messages you will search for are all in English. Choosing English means when something goes wrong, you can copy the error message and find help online.

### Country → Where you are

Select your country. This sets your time zone and the nearest download server.

### Keyboard → Match your physical keyboard

Look at the key to the left of the number 1. If it has a backtick and a not sign (¬), you have a British keyboard. If it has a backtick and a tilde (~), you have a US keyboard. Getting this wrong means some keys will type the wrong character. You can always change it later, but it is easier to get it right now.

### Network → Connect to the internet

On the **EliteBook**: the installer will show you a list of wifi networks. Find yours and type the password. If your wifi does not appear, you may need to connect an ethernet cable for the installation. This is rare with the HP EliteBook 840r G4 on Debian 13, but it can happen.

On the **MacBook**: your wifi will not appear, and that is expected. The wifi chip in this MacBook needs a driver that can only be installed later, by the setup script. Plug your phone into the laptop with a USB cable and switch on USB tethering (on Android: Settings, then Network, then Hotspot and tethering). The installer sees the phone as a wired connection and carries on normally. An ethernet adapter works the same way. Keep the phone or adapter connected until the setup script finishes in Part 8.

Why does the installer need internet? Because the netinst image is minimal. It downloads the software you select during installation. No internet, no software.

### Hostname → ekohacks

This is the name your computer uses on the network. It appears in your terminal prompt. Type **ekohacks**.

### Domain → Leave blank

Press Enter. You do not need this.

### Root Password → Leave blank

Press Enter twice. This is intentional.

On Linux, "root" is the administrator account. It can do anything: install software, delete the entire system, change any file. If you set a root password, you get a separate administrator account. If you leave it blank, Debian gives your normal user account the ability to run administrator commands when needed (using a command called `sudo`). That is safer because you use your own password and you have to explicitly ask for admin power each time.

### User Account

Type your full name. Choose a short, lowercase username, something like **kofi** or **ada** or **nico**. Set a password and remember it. You will need it every time you install something.

### Time Zone → Your time zone

Select it.

### Partitioning → Guided, use entire disk

This is where Windows gets erased. Select **Guided - use entire disk**. Select your hard drive (there should be only one). Select **All files in one partition**. Select **Finish partitioning and write changes to disk**. When it asks "Write the changes to disk?" select **Yes**.

This is the point of no return. After this, Windows is gone. Everything on the drive is being replaced with a clean Debian system.

Why are we erasing everything instead of keeping Windows alongside Linux? Because dual-boot setups create confusion. Two operating systems on one machine means two sets of problems. At the dojo, the machine has one purpose. Keeping it simple means fewer things go wrong.

### Package Manager → A mirror near you

Select a download server close to your country. For the UK, **ftp.uk.debian.org**. For Greece, **ftp.gr.debian.org**. For Nigeria, any European mirror works.

If it asks about an HTTP proxy, leave it blank.

### Software Selection → Almost nothing

You will see a list with checkboxes. **Uncheck everything except:**

- [x] standard system utilities

Uncheck "Debian desktop environment", uncheck "GNOME", uncheck everything else. Use the arrow keys to move and the spacebar to check or uncheck.

Why uncheck everything? Because the Ekohacks setup script installs exactly what you need, nothing more, nothing less. If you install GNOME (a desktop environment), you get a mouse driven interface with menus and icons that uses over a gigabyte of RAM. You do not want that. You are going to use i3, which uses almost nothing and is controlled entirely by the keyboard. The setup script handles this.

### GRUB Boot Loader → Yes

When it asks if you want to install GRUB, select **Yes**. Select your hard drive (usually /dev/sda or /dev/nvme0n1).

GRUB is what starts your operating system when you turn on the laptop. Without it, the laptop would not know how to find Debian. Think of it as the bridge between the BIOS and your operating system.

### Finish

The installer says "Installation complete." Remove your USB stick. Select **Continue**. The laptop restarts.

---

## Part 6: First Login

Your laptop restarts and shows a text prompt:

```
ekohacks login:
```

Type your username and press Enter. Type your password and press Enter.

You will not see any characters when typing your password. The cursor does not move. Nothing appears on screen. That is normal. It is a security feature so nobody looking over your shoulder can see how long your password is. Your keystrokes are being registered. Just type and press Enter.

You are now logged in. You see a blinking cursor. This is your terminal.

---

## Part 7: Checking Your Internet

The connection you used during installation normally carries over to the installed system, so you are probably already online. Check:

```bash
ping -c 3 google.com
```

You should see three lines with times in milliseconds. That means your internet works.

On the **MacBook** this works because your phone or adapter is still plugged in. Leave it that way until the setup script finishes. The script installs the wifi driver, and wifi works on its own after the reboot in Part 9.

If you see "Network is unreachable", the simplest fix on either machine is USB tethering from a phone, exactly as described in Part 5. It gives the machine internet for the setup script, and the script installs the proper wifi tools. After setup you manage wifi with `nmtui`, a tool the script installs. It is not on the machine yet, so do not look for it now.

---

## Part 8: Running the Setup Script

This is the part where your blank Debian machine becomes a dojo machine. One script installs and configures everything.

Install git (a tool for downloading and tracking code):

```bash
sudo apt install -y git
```

Download the Ekohacks repository (the setup script lives inside it):

```bash
git clone https://github.com/ekohacks/ekoflow.git
```

Go into the scripts folder:

```bash
cd ekoflow/scripts
```

Make the script runnable:

```bash
chmod +x ekohacks-dojo-setup.sh
```

Run it:

```bash
./ekohacks-dojo-setup.sh
```

The script first checks it can reach the internet and tells you exactly what to do if it cannot. It then prints which hardware it detected (EliteBook or MacBook) and asks for your password. Partway through it also asks for your name and email, which git stamps onto every piece of work you save, so stay nearby rather than walking away. In total it runs for 10 to 15 minutes. You will see a lot of text scrolling past. That is every tool being downloaded, installed, and configured. Do not close the terminal or turn off the laptop.

When it finishes you will see "SETUP COMPLETE" with next steps. On the MacBook it also confirms that the wifi driver is installed and that you can unplug the phone or adapter after the reboot.

What just happened? The script installed a window manager (i3), a terminal (Alacritty), a text editor (Neovim), a test runner (vitest), Node.js for JavaScript, Firefox for browsing, and a dozen other tools, all configured to work together. It also set up keyboard shortcuts, shell commands, a TDD workflow, and the pairing tools used in XP sessions. Everything you need, nothing you do not.

---

## Part 9: Reboot and Start

Reboot:

```bash
sudo reboot
```

Log in with your username and password. Then start the graphical environment:

```bash
startx
```

You will see a mostly black screen with a thin bar at the top. That is i3. There is nothing wrong. This is what your workspace looks like.

Press **Super + Enter** to open a terminal. The Super key is the one with the Windows logo on the EliteBook, and the Command key on the MacBook.

You will see the Ekohacks dojo banner with your workspace info and available commands.

If this is your first time in this environment, read the "Your First Day" guide before doing anything else. It covers how to move around, open Firefox, and use basic commands.

---

## Part 10: Your First Kata

When you are comfortable with the basics, create your first project:

```bash
dojo-init my-first-kata
```

This creates a folder with a failing test already inside, wired to the test runner, and saves it as your first git commit. Go into it:

```bash
cd my-first-kata
```

Start tmux (a tool that splits your terminal into sections):

```bash
tmux
```

Then press **Ctrl+a** followed by **T** (capital T, so Ctrl+a then Shift+t). This creates the dojo layout: your editor on the left, your test runner on the right.

In the left side, type:

```bash
nvim test/kata.test.js
```

You are now in the dojo. The scaffold already gives you one failing test. Watch it go red. Make it pass. Watch it go green. Clean it up. Commit. Then write the next failing test. That is the cycle.

---

## How to Fix Problems

Before you look at specific fixes below, learn this process. It is the same process every time, for every error, on every computer. Once you know it, you can solve problems nobody has written a guide for.

### Step 1: Read the error

When something goes wrong, the terminal prints an error message. It is usually the last few lines on the screen, often in red or after the word "error" or "failed". Read it. Do not panic. Do not immediately try something else. Just read what it says.

### Step 2: Copy the error exactly

Select the error text in your terminal. On most terminals, you can select text by clicking and dragging with the mouse, then copy it with `Ctrl+Shift+C` (not `Ctrl+C`, which does something else in the terminal).

If you cannot copy it, type it out word for word. Do not paraphrase. The exact wording matters because that is what other people have searched for before you.

### Step 3: Search for it

Open Firefox (`Super+4`, then `Super+d`, type `firefox`). Go to google.com. Paste the error message into the search bar. Add the word "debian" or "linux" to narrow the results.

Look at the first few results. Sites like Stack Overflow, Ask Ubuntu, and the Debian forums usually have answers. Read the answers that got the most votes. Often the fix is one or two commands.

### Step 4: Try the fix

If you find a command that looks like a fix, try it. If it works, write down what happened and what you did in your own notes. If it does not work, go back to step 3 and look at the next result.

### Step 5: Ask for help if you are still stuck

If you have spent more than 15 minutes and nothing has worked, send a message to your instructor. Include: what you were trying to do, the exact error message, and what you already tried. This gives them everything they need to help you quickly.

---

## Common Problems and Fixes

### The laptop boots to a black screen with no login prompt

Wait 30 seconds. Sometimes the display takes a moment. If nothing appears, hold the power button for 10 seconds to force it off, then turn it on again.

### Wifi does not work after setup (EliteBook)

```bash
sudo modprobe iwlwifi
sudo systemctl restart NetworkManager
sudo nmtui
```

If it still does not work, connect an ethernet cable or tether a phone and run `sudo apt install firmware-iwlwifi`, then reboot.

### Wifi does not work after setup (MacBook)

The wifi driver is built during setup and loads at the reboot. Make sure the script actually reached "SETUP COMPLETE" and that you have rebooted since. Then check:

```bash
sudo modprobe wl
sudo systemctl restart NetworkManager
sudo nmtui
```

If wifi still does not appear, plug the phone or adapter back in and run the setup script again. It is safe to run more than once, and the log at `~/ekohacks-setup.log` will show what went wrong with the driver build.

Remember that `nmtui` only exists after the setup script has run. Before that, the machine gets its internet from the connection you used during installation.

### startx says something about "console users" or "not on a console"

This means Debian is not allowing your user to start the graphical environment. Run this:

```bash
sudo sed -i 's/allowed_users=console/allowed_users=anybody/' /etc/X11/Xwrapper.config
```

Then try `startx` again. If the file does not exist, run:

```bash
sudo apt install -y xserver-xorg-legacy
```

Then run the `sed` command above, then `startx`.

### startx gives a different error

Make sure i3 and Xorg are installed:

```bash
sudo apt install -y i3 xorg xinit
```

Then try `startx` again. If it still fails, read the error message and follow the troubleshooting steps above. The error log is also saved at `/var/log/Xorg.0.log` if you need more detail.

### The setup script fails partway through

Read the last error message. Copy it down exactly. Then try running the script again. It is safe to run multiple times. If it keeps failing at the same point, send the error to your instructor along with the log file at `~/ekohacks-setup.log`.

### You typed something wrong in the Debian installer

You can go back to the previous screen using the Back button. If you are too far in, restart the installer by rebooting from the USB stick. It is better to start over than to continue with wrong settings.

### You want to go back to Windows

You will need to download Windows from Microsoft and install it fresh. This guide erased Windows completely. That is why we asked you to back up first.

---

## What You Have Now

Your laptop is running a purpose-built environment for learning to code. Here is everything on it:

| Tool | What it does |
|------|-------------|
| Debian 13 | Your operating system (supported until 2030) |
| i3 | Controls your windows with the keyboard |
| Alacritty | Your terminal |
| Neovim | Your text editor |
| tmux | Splits your terminal into sections |
| Node.js 22 | Runs JavaScript |
| vitest | Runs your tests |
| git | Tracks every change you make |
| Firefox | Your web browser |
| pandoc | Converts your writing to PDF, Word, or slides |
| ranger | Browses files from the terminal |
| calcurse | Calendar and scheduling |
| sc-im | Spreadsheet in the terminal |
| neomutt | Email in the terminal |
| dojo-pair | Shares your terminal with a partner for pairing |
| dojo-rotate | Chimes when the pair should swap driver and navigator |
| tmate | Pairing with someone who is not in the room |
| TLP | Manages your battery |

Idle RAM: about 200MB. Available for your work: about 7.8GB.

Compare that to Windows on the same machine: over 7GB used, under 1GB free.

Your machine is now a tool. Everything on it is there because you need it. Nothing is there because someone else decided you should have it. That is what control looks like.
