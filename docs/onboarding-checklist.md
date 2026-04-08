# Ekohacks Student Onboarding Checklist

Use this checklist every time a new student joins a dojo session. Work through it in order. Do not skip steps. Tick each item when done.

---

## One Week Before the Session

- [ ] Confirm student name, email, and GitHub username
- [ ] Send welcome email using the template in ops repo at templates/welcome-email.md
- [ ] Send logistics email (date, time, location, what to bring) using templates/logistics-email.md
- [ ] Ask if they have a laptop or need one provided
- [ ] If they bring their own laptop: note the model, confirm it has at least 4GB RAM
- [ ] If we provide a laptop: assign one from inventory, note the serial number
- [ ] Create their GitHub account if they do not have one
- [ ] Add them to the Ekohacks GitHub organisation
- [ ] Add them to any relevant repos (newsletter, dojo exercises)
- [ ] Update the student tracker CSV with their details

---

## One Day Before the Session

- [ ] Charge all provided laptops to 100%
- [ ] Test wifi on every machine (open Firefox, load github.com)
- [ ] Run `sudo apt update` on every machine to ensure packages are current
- [ ] Run `dojo-start` on every machine to confirm the environment is working
- [ ] Run `npx vitest run` in a test project on every machine to confirm vitest works
- [ ] Print or display the session schedule
- [ ] Print the Neovim cheat sheet (one per student)
- [ ] Print the i3 cheat sheet (one per student)
- [ ] Confirm the room or space is ready (power sockets, seating, internet)
- [ ] Test the wifi bandwidth: at least 5 Mbps per student

---

## If Setting Up a New Machine

Follow the Linux Install Guide. These are the key steps and common pitfalls.

### Before Install

- [ ] Back up any existing data (if this is not a fresh machine)
- [ ] Enter BIOS (F10 on HP EliteBooks)
- [ ] Disable Secure Boot
- [ ] Set USB first in boot order
- [ ] Switch to AHCI mode if you see Intel RST or RAID mode

### During Install

- [ ] Boot from Debian 13 USB stick
- [ ] Choose "Install" (text mode)
- [ ] Language: English
- [ ] Keyboard: match the physical keyboard (check the key left of 1)
- [ ] Network: connect to wifi during install
- [ ] Hostname: ekohacks
- [ ] Root password: leave blank (gives sudo to normal user)
- [ ] Username: student's first name, lowercase, no spaces
- [ ] Partitioning: Guided, use entire disk, all files in one partition
- [ ] Software selection: ONLY "standard system utilities" (uncheck everything else)
- [ ] GRUB: Yes, install to the main drive

### After Install

- [ ] Log in as the new user
- [ ] Connect wifi: `sudo nmtui`
- [ ] Test internet: `ping -c 3 google.com`
- [ ] Install git: `sudo apt install -y git`
- [ ] Clone dojo setup: `git clone https://github.com/ekohacks/dojo-setup.git`
- [ ] Run setup script: `cd dojo-setup && chmod +x ekohacks-dojo-setup.sh && ./ekohacks-dojo-setup.sh`
- [ ] Reboot: `sudo reboot`
- [ ] Log in and run `startx`
- [ ] Open terminal (Super + Enter)
- [ ] Verify dojo-start banner appears
- [ ] Run `dojo-init test-kata` and confirm vitest runs
- [ ] Set git name and email for the student
- [ ] Delete the test kata: `cd ~ && rm -rf test-kata`

### Verification

- [ ] i3 starts with Super + Enter opening Alacritty
- [ ] Neovim opens with `nvim`
- [ ] tmux starts with `tmux`
- [ ] TDD layout works (Ctrl+a T in tmux)
- [ ] Vitest runs tests
- [ ] Git is configured with student's name and email
- [ ] Firefox opens with Super+d then typing "firefox"
- [ ] Wifi reconnects after reboot
- [ ] Battery indicator shows in i3 status bar
- [ ] Brightness keys work (on EliteBooks)
- [ ] Volume keys work (on EliteBooks)

---

## On the Morning of the Session

- [ ] Arrive 30 minutes before students
- [ ] Turn on all machines and run `startx` on each
- [ ] Open a terminal on each machine so students see the dojo banner
- [ ] Put the Neovim and i3 cheat sheets at each desk
- [ ] Write the wifi password on the whiteboard (if students need it for phones)
- [ ] Test one machine end to end: create kata, write test, run it, commit, push

---

## When the Student Arrives

Walk them through these steps. Do not do it for them. Stand behind them and tell them what to type.

1. "This is your machine. The screen you see is called i3. It is your window manager."
2. "Press Super and Enter at the same time to open a terminal." (Show them which key is Super.)
3. "Read the banner. It tells you where you are and what commands you have."
4. "Type `dojo-init hello-world` and press Enter. This creates your first project."
5. "Type `cd hello-world` and press Enter."
6. "Type `nvim test/example.test.js` and press Enter. This opens your first test file."
7. "Press the letter i. Now you can type. You are in insert mode."
8. "Press Escape. Now you cannot type. You are in normal mode."
9. "Type `:q!` and press Enter. You just quit Neovim without saving."
10. "That is the first ten minutes. You will be doing this all day."

After that, hand over to the instructor for the session content.

---

## After the Session

- [ ] Collect feedback from students (verbal or written, whatever the instructor prefers)
- [ ] Write the session report: date, number of students, what was covered, any issues
- [ ] Save the report in the ops repo at reports/session-YYYY-MM-DD.md
- [ ] Commit and push the report
- [ ] Update the student tracker CSV with attendance and status
- [ ] Note any machine issues that need fixing before next session
- [ ] Charge all machines for next time
- [ ] Send follow up email to students with next steps and any homework assignments

---

## Common Problems and Fixes

### Wifi does not connect

```bash
sudo modprobe iwlwifi
sudo systemctl restart NetworkManager
sudo nmtui
```

If it still fails, check if the machine has an Intel wifi card: `lspci | grep Network`. If it says Intel, the driver should work. Reboot and try again. If it is a different brand, search for the Debian driver for that card.

### startx gives an error about no screens found

```bash
sudo apt install -y xorg i3 xinit
```

Then try `startx` again. If it still fails, check `cat /var/log/Xorg.0.log | grep EE` for errors.

### Neovim shows errors on startup

The config file might have a syntax error. Test it:

```bash
nvim --headless -c 'quit'
```

If it shows errors, check `~/.config/nvim/init.lua` for typos. If in doubt, re-run the setup script. It overwrites the config with a clean version.

### Student cannot push to GitHub

They probably have not set up SSH keys or a personal access token. The simplest fix:

```bash
git remote set-url origin https://github.com/ekohacks/REPO-NAME.git
```

Then when they push, GitHub will ask for their username and token. Help them create a token at https://github.com/settings/tokens if needed.

### The machine is very slow

Check what is using memory:

```bash
free -h
htop
```

If Firefox is using a lot of memory, close unnecessary tabs. If nothing obvious, reboot. On 8GB machines this should almost never happen.

### A package fails to install

```bash
sudo apt update
sudo apt --fix-broken install
```

Then try the install again. If it still fails, check internet connectivity first.