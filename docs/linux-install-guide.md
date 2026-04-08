# How to Set Up Your Ekohacks Dojo Machine

This guide turns your HP EliteBook 840r G4 (or similar laptop) into a dojo ready coding machine running Linux. It assumes you have never installed Linux before. Read every word. Do not skip ahead.

---

## What Are We Doing?

You are going to replace Windows with Debian Linux and then run a script that sets up your entire coding environment. When you are done you will have a fast, minimal machine built for test driven development with Vim.

Your laptop currently uses over 7GB of RAM just to show you a desktop. After this process it will use about 200MB. Everything will feel faster.

This takes about 45 minutes. You need a USB stick (at least 1GB) and a wifi connection.

---

## Before You Start

### Back Up Your Files

Anything on your Windows machine will be erased. Copy everything you want to keep to an external drive, Google Drive, or wherever you store things. Do this now before you continue.

### What You Need

One USB stick, at least 1GB, that you do not mind erasing. Another computer or phone to read this guide while your laptop is being wiped. Your wifi network name and password written down on paper.

---

## Part 1: Download Debian 13

On your current Windows machine (or any computer with a browser), go to:

```
https://www.debian.org/distrib/netinst
```

Download the file called **debian-13.x.x-amd64-netinst.iso** (the amd64 version). It is about 600MB. The exact version number will vary. Pick the most recent one.

This file includes wifi drivers for your EliteBook. Older Debian versions did not include them, which caused problems. Debian 13 fixed this.

---

## Part 2: Create a Bootable USB Stick

You need to put that downloaded file onto your USB stick in a special way. Simply copying the file will not work.

### On Windows

Download Rufus from https://rufus.ie. It is free and does not need installing. Just run it.

Plug in your USB stick. Open Rufus. Under "Device" select your USB stick. Under "Boot selection" click SELECT and find the debian .iso file you downloaded. Leave everything else at the defaults. Click START.

If it asks about writing in ISO mode or DD mode, choose ISO mode. Wait for it to finish. It takes a few minutes.

### On Mac

Download balenaEtcher from https://etcher.balena.io. Open it. Click "Flash from file" and select the debian .iso. Click "Select target" and choose your USB stick. Click "Flash". Wait for it to finish.

---

## Part 3: Prepare Your Laptop BIOS

This part matters. If you skip it the installer may not work.

Turn off your laptop completely. Not sleep, not restart. Shut it down.

Now turn it on and immediately start pressing **F10** repeatedly. You will enter a screen called BIOS Setup. It looks old fashioned with blue and grey menus. That is normal.

### Change These Settings

Navigate with the arrow keys on your keyboard. Press Enter to select things.

**Secure Boot:** Find the Security tab. Look for Secure Boot. Set it to **Disabled**. This lets your laptop boot Linux.

**Boot Order:** Find the Boot tab or Boot Options. Make sure USB is listed before the hard drive. If it is not, move it up. This lets your laptop boot from the USB stick.

**Storage Mode (if you see it):** Some EliteBooks have a setting called SATA Emulation or Intel RST. If you see this, change it to **AHCI**. If you do not see it, ignore this step.

Press **F10** to save and exit. Your laptop will restart.

---

## Part 4: Boot From the USB Stick

Turn off your laptop. Plug in the USB stick. Turn it on.

If you set the boot order correctly it will boot from the USB stick and show the Debian installer. If it boots into Windows instead, turn it off and try again, pressing **F9** during startup to get a boot menu where you can select the USB stick manually.

---

## Part 5: Install Debian 13

You will see a menu. Select **Install** (not Graphical Install). The text installer is simpler and works on every machine.

Follow these screens in order. For each one I will tell you what to choose.

### Language

Select **English**.

### Country

Select your country. If you are at the dojo in Greece, select **Greece**. If in Nigeria, select **Nigeria**. If in the UK, select **United Kingdom**.

### Keyboard

Select **British English** if you have a UK keyboard. Select **American English** if you have a US keyboard. If you are not sure, look at the key to the left of the number 1. If it has a backtick and a not sign (¬), it is British.

### Network

The installer will detect your wifi card. It will show you a list of wifi networks. Select yours and type your password. If your wifi does not appear, your laptop may need to be connected with an ethernet cable for the install. This is rare with the EliteBook 840r G4 on Debian 13 but it can happen.

### Hostname

Type **ekohacks**. This is just the name of your computer on the network. It does not matter much.

### Domain

Leave this blank. Press Enter.

### Root Password

**Leave this blank.** Press Enter twice. When you leave root blank, Debian gives your normal user sudo access automatically. This is what we want.

### User Account

Type your full name. Then choose a username. Use something short and lowercase. For example: **kofi** or **ada** or **nico**. Type a password and confirm it. Remember this password. You will need it every time you install software.

### Time Zone

Select your time zone.

### Partitioning

This is the part that erases Windows. Select **Guided - use entire disk**. Select your hard drive (there should be only one). Select **All files in one partition**. Select **Finish partitioning and write changes to disk**. When it asks "Write the changes to disk?" select **Yes**.

This is the point of no return. Windows is being erased now.

### Package Manager

Select a mirror close to your country. For the UK, **ftp.uk.debian.org** works well. For Greece, **ftp.gr.debian.org**. For Nigeria, any European mirror is fine.

If it asks about an HTTP proxy, leave it blank and press Enter.

### Software Selection

This is important. You will see a list with checkboxes. **Uncheck everything except:**

- [x] standard system utilities

That is it. Uncheck "Debian desktop environment", uncheck "GNOME", uncheck everything else. We do not want any of these. The setup script installs exactly what we need later.

Use the arrow keys to move and the spacebar to check or uncheck items.

### GRUB Boot Loader

When it asks if you want to install the GRUB boot loader to your primary drive, select **Yes**. Select your hard drive (usually /dev/sda or /dev/nvme0n1). This is what lets your laptop start Debian when you turn it on.

### Finish

The installer will say "Installation complete." Remove your USB stick. Select **Continue**. Your laptop will restart.

---

## Part 6: First Boot

Your laptop will restart and show a text login prompt. It will say something like:

```
ekohacks login:
```

Type your username and press Enter. Type your password and press Enter. You will not see any characters when typing your password. That is normal. It is still being typed.

You are now logged in. You will see a blinking cursor. This is your terminal. Everything from here on happens in this terminal.

---

## Part 7: Connect to Wifi

Your wifi is probably not connected yet. Type this:

```bash
sudo nmtui
```

Type your password when asked. A blue menu will appear. Select **Activate a connection**. Find your wifi network, select it, and type the password. Press Escape twice to exit.

Test it works:

```bash
ping -c 3 google.com
```

You should see three lines with times in milliseconds. If you see "Network is unreachable" your wifi is not connected. Try nmtui again.

---

## Part 8: Get the Setup Script

Now you need to download and run the Ekohacks setup script. This single script installs and configures everything.

First install git:

```bash
sudo apt install -y git
```

Then clone the dojo setup repository:

```bash
git clone https://github.com/ekohacks/dojo-setup.git
```

Go into the folder:

```bash
cd dojo-setup
```

Make the script executable:

```bash
chmod +x ekohacks-dojo-setup.sh
```

Run it:

```bash
./ekohacks-dojo-setup.sh
```

The script will ask for your sudo password once at the beginning. After that it runs for 10 to 15 minutes. You will see a lot of text scrolling past. That is normal. Do not close the terminal or turn off the laptop.

When it finishes you will see a message saying "SETUP COMPLETE" with next steps.

---

## Part 9: Reboot and Start

Reboot your machine:

```bash
sudo reboot
```

Log in again with your username and password. Then start the graphical environment:

```bash
startx
```

You will see a mostly black screen with a thin bar at the top showing your CPU, memory, battery, and time. That is i3, your window manager. There is nothing wrong. This is what it looks like.

Press **Super + Enter** to open a terminal. The Super key is the Windows key on your keyboard.

You will see the Ekohacks dojo session banner with your workspace info and available commands.

---

## Part 10: Your First Kata

Create your first project:

```bash
dojo-init my-first-kata
```

This creates a project folder with a test file, installs vitest, and makes your first git commit. Now start the TDD workflow:

```bash
tmux
```

Then press **Ctrl+a** followed by **T** (capital T). This creates the dojo layout: Neovim on the left, vitest in watch mode on the right.

In the left pane, type:

```
nvim test/example.test.js
```

You are now in the dojo. Write a failing test. Watch it go red. Make it pass. Watch it go green. Refactor. Commit.

---

## Quick Reference: Key Bindings

### i3 (Window Manager)

| Keys | Action |
|------|--------|
| Super + Enter | Open terminal |
| Super + d | App launcher |
| Super + Shift + q | Close window |
| Super + h/j/k/l | Move focus |
| Super + 1/2/3/4 | Switch workspace |
| Super + f | Fullscreen |
| Super + Shift + r | Restart i3 |
| Super + Shift + x | Lock screen |

### tmux (Terminal Multiplexer)

| Keys | Action |
|------|--------|
| Ctrl+a v | Split vertical |
| Ctrl+a s | Split horizontal |
| Ctrl+a h/j/k/l | Move between panes |
| Ctrl+a T | TDD layout |
| Ctrl+a r | Reload config |

### Neovim

| Keys | Action |
|------|--------|
| Space t | Run tests (current file) |
| Space ta | Run all tests |
| Space tw | Watch tests (current file) |
| Space e | File explorer |
| Space v | Vertical split |
| Space w | Save |
| Space q | Quit |
| Space gs | Git status |
| Space gc | Git commit |

### Shell Aliases

| Command | Action |
|---------|--------|
| t | Run tests once |
| tw | Watch mode |
| green 'message' | Commit all with green prefix |
| gs | Git status |
| gd | Git diff |
| gl | Git log (last 20) |
| dojo-start | Show session info |
| dojo-init name | Create new kata project |
| r | Ranger file browser |
| cal | Calcurse calendar |
| sheet | sc-im spreadsheet |
| md2pdf file.md | Convert markdown to PDF |
| md2docx file.md | Convert markdown to Word |
| md2pptx file.md | Convert markdown to slides |

---

## If Something Goes Wrong

### The laptop boots into a black screen with no login prompt

Wait 30 seconds. Sometimes the display takes a moment. If nothing appears, hold the power button for 10 seconds to force it off, then turn it on again.

### Wifi does not appear in nmtui

Your wifi firmware may not have loaded. Try:

```bash
sudo modprobe iwlwifi
sudo systemctl restart NetworkManager
sudo nmtui
```

If it still does not work, connect an ethernet cable and run `sudo apt install firmware-iwlwifi` then reboot.

### startx gives an error

Make sure i3 is installed:

```bash
sudo apt install -y i3 xorg xinit
```

Then try `startx` again.

### The setup script fails partway through

Read the last error message. Copy it down. Then try running the script again. It is safe to run multiple times. If it keeps failing at the same point, send the error to your instructor along with the log file at `~/ekohacks-setup.log`.

### You accidentally typed something wrong in the Debian installer

You can go back to the previous screen using the Back button at the bottom. If you are too far in, it is fine to restart the installer from scratch. Just reboot and boot from the USB stick again.

### You want to go back to Windows

You will need to download Windows from Microsoft and install it fresh. This guide erased Windows completely. This is why we said to back up your files first.

---

## For Instructors: Bulk Setup

If you are setting up multiple machines for a dojo session, the process is the same for each laptop:

Install Debian 13 minimal with the same settings. Run the setup script. The script handles git name and email interactively, so each student gets their own identity.

To make the Debian install faster across multiple machines, you can create a preseed file that automates the installer choices. This is an advanced topic. Ask in the Ekohacks instructor channel if you need this.

---

## What You Have Now

Your laptop is running a purpose built environment for software craftsmanship training. Here is what is on it and nothing else:

**Operating system:** Debian 13 Trixie (supported until 2030)
**Window manager:** i3 (keyboard driven, no mouse needed)
**Terminal:** Alacritty (fast, GPU accelerated)
**Editor:** Neovim (modal editing, bespoke Ekohacks config)
**Multiplexer:** tmux (split panes, session management)
**Runtime:** Node.js 20 via nvm
**Test runner:** vitest
**Version control:** git with TDD aliases
**Browser:** Firefox ESR (for documentation and web apps)
**Battery management:** TLP (extends EliteBook battery life)
**Documents:** pandoc (markdown to PDF, Word, slides)
**File browser:** ranger (keyboard driven)
**Calendar:** calcurse (terminal calendar and scheduling)
**Spreadsheet:** sc-im (terminal spreadsheet for CSV files)
**Email:** neomutt (terminal email, or Gmail in Firefox)

Idle RAM usage: approximately 200MB.
Available RAM for your work: approximately 7.8GB.

Compare this to Windows on the same machine: over 7GB used, under 1GB free.

Your machine is now a tool, not a distraction. Use it well.