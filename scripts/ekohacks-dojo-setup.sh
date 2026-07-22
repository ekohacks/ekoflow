#!/usr/bin/env bash
# ============================================================
#  EKOHACKS DOJO MACHINE SETUP
#  Base: Debian 13 "Trixie" Minimal (net install)
#  Target: HP EliteBook 840r G4 (i5-8250U, 8GB RAM)
#  Purpose: Transform bare Debian into a dojo ready machine
#
#  Usage (after Debian 13 minimal install):
#    chmod +x ekohacks-dojo-setup.sh
#    ./ekohacks-dojo-setup.sh
#
#  What this does:
#    - Installs i3 window manager (keyboard driven, no mouse)
#    - Installs and configures Neovim (bespoke Ekohacks config)
#    - Installs tmux with TDD split layout
#    - Installs Node.js 22 and vitest
#    - Configures git with TDD workflow aliases
#    - Installs XP pairing tools (shared tmux over ssh, tmate, rotation chime)
#    - Sets up Alacritty terminal with Ekohacks colour scheme
#    - Creates shell aliases for daily dojo work
#
#  Estimated time: 10 to 15 minutes on a decent connection
#  Estimated idle RAM after setup: ~200MB (no browser open)
# ============================================================

set -euo pipefail

# ------------------------------------------------------------
# PREFLIGHT CHECKS
# ------------------------------------------------------------

if [ "$(id -u)" -eq 0 ]; then
  echo "ERROR: Do not run this script as root."
  echo "Run it as your normal user. It will ask for sudo when needed."
  exit 1
fi

if ! grep -qi "debian" /etc/os-release 2>/dev/null; then
  echo "WARNING: This script is designed for Debian 13 Trixie."
  echo "You do not appear to be running Debian."
  read -rp "Continue anyway? (y/n) " answer
  [[ "$answer" != "y" ]] && exit 1
fi

EKOHACKS_DIR="$HOME/.ekohacks"
NVIM_CONFIG="$HOME/.config/nvim"
I3_CONFIG="$HOME/.config/i3"
ALACRITTY_CONFIG="$HOME/.config/alacritty"
TMUX_CONF="$HOME/.tmux.conf"
NODE_VERSION="22"
LOG_FILE="$HOME/ekohacks-setup.log"

# Log everything
exec > >(tee -a "$LOG_FILE") 2>&1

echo ""
echo "  ╔═══════════════════════════════════════════╗"
echo "  ║         EKOHACKS DOJO SETUP               ║"
echo "  ║   Debian 13 Trixie Edition                ║"
echo "  ║                                           ║"
echo "  ║   Train with weights on.                  ║"
echo "  ║   No mouse. No AI. No excuses.            ║"
echo "  ╚═══════════════════════════════════════════╝"
echo ""
echo "  Log file: $LOG_FILE"
echo ""

# ------------------------------------------------------------
# 1. SYSTEM PACKAGES
# ------------------------------------------------------------
echo "──────────────────────────────────────────────"
echo "[1/9] Installing system packages..."
echo "──────────────────────────────────────────────"

sudo apt update && sudo apt upgrade -y

# Core system
sudo apt install -y \
  build-essential \
  curl \
  wget \
  git \
  unzip \
  xclip \
  htop \
  tree \
  bash-completion

# i3 window manager and X11
sudo apt install -y \
  xorg \
  xinit \
  i3 \
  i3status \
  i3lock \
  dmenu

# Allow any user to start X (fixes "only console users" error on Debian 13)
sudo sed -i 's/allowed_users=console/allowed_users=anybody/' /etc/X11/Xwrapper.config 2>/dev/null || true

# Terminal and editor
sudo apt install -y \
  alacritty \
  tmux \
  neovim

# Search tools (used by Neovim and shell)
sudo apt install -y \
  ripgrep \
  fd-find \
  fzf

# Fonts
sudo apt install -y \
  fonts-firacode \
  fonts-noto

# Network and hardware (EliteBook 840r G4 specific)
# network-manager-gnome provides nm-applet, autostarted by i3
sudo apt install -y \
  network-manager \
  network-manager-gnome \
  firmware-iwlwifi \
  pulseaudio \
  pavucontrol \
  brightnessctl

# Browser
sudo apt install -y \
  firefox-esr

# Ops tools (document conversion, file management, email)
sudo apt install -y \
  pandoc \
  texlive-latex-base \
  texlive-fonts-recommended \
  texlive-latex-recommended \
  texlive-xetex \
  ranger \
  neomutt \
  w3m \
  calcurse \
  sc-im \
  pass \
  entr

# XP pairing tools (shared tmux over ssh, remote pairing, rotation chime)
sudo apt install -y \
  openssh-server \
  tmate \
  sound-theme-freedesktop

# ssh lets a pair partner join a shared tmux session on this machine
sudo systemctl enable --now ssh

echo "[1/9] Done."

# ------------------------------------------------------------
# 2. POWER MANAGEMENT (EliteBook battery life)
# ------------------------------------------------------------
echo "──────────────────────────────────────────────"
echo "[2/9] Setting up power management..."
echo "──────────────────────────────────────────────"

sudo apt install -y \
  tlp \
  tlp-rdw

sudo systemctl enable tlp
sudo systemctl start tlp

echo "[2/9] Done."

# ------------------------------------------------------------
# 3. NODE.JS VIA NVM
# ------------------------------------------------------------
echo "──────────────────────────────────────────────"
echo "[3/9] Installing Node.js ${NODE_VERSION} via nvm..."
echo "──────────────────────────────────────────────"

export NVM_DIR="$HOME/.nvm"

if [ ! -d "$NVM_DIR" ]; then
  curl -o- https://raw.githubusercontent.com/nvm-sh/nvm/v0.40.4/install.sh | bash
fi

# nvm is not safe under set -u, so relax it while nvm runs
set +u
# shellcheck source=/dev/null
[ -s "$NVM_DIR/nvm.sh" ] && \. "$NVM_DIR/nvm.sh"

nvm install "$NODE_VERSION"
nvm alias default "$NODE_VERSION"
set -u

# Only what the dojo needs
npm install -g vitest typescript tsx

echo "[3/9] Done."

# ------------------------------------------------------------
# 4. GIT CONFIG
# ------------------------------------------------------------
echo "──────────────────────────────────────────────"
echo "[4/9] Configuring git..."
echo "──────────────────────────────────────────────"

git config --global init.defaultBranch main
git config --global core.editor nvim
git config --global pull.rebase true
git config --global push.autoSetupRemote true

# Aliases
git config --global alias.st status
git config --global alias.co checkout
git config --global alias.br branch
git config --global alias.ci "commit -v"
git config --global alias.lg "log --oneline --graph --all --decorate"
git config --global alias.last "log -1 --stat"

# TDD specific aliases (refuse an empty message, credit a pair partner when DOJO_PAIR is set)
git config --global alias.green '!f() { if [ -z "${1:-}" ]; then echo "usage: git green <message>"; exit 1; fi; git add -A && if [ -n "${DOJO_PAIR:-}" ]; then git commit -m "green: $1" -m "Co-authored-by: $DOJO_PAIR"; else git commit -m "green: $1"; fi; }; f'
git config --global alias.refactor '!f() { if [ -z "${1:-}" ]; then echo "usage: git refactor <message>"; exit 1; fi; git add -A && if [ -n "${DOJO_PAIR:-}" ]; then git commit -m "refactor: $1" -m "Co-authored-by: $DOJO_PAIR"; else git commit -m "refactor: $1"; fi; }; f'
git config --global alias.red '!f() { if [ -z "${1:-}" ]; then echo "usage: git red <message>"; exit 1; fi; git add -A && if [ -n "${DOJO_PAIR:-}" ]; then git commit -m "red: $1" -m "Co-authored-by: $DOJO_PAIR"; else git commit -m "red: $1"; fi; }; f'

# Check if user has set their name
if [ -z "$(git config --global user.name 2>/dev/null)" ]; then
  echo ""
  echo "  Git needs your name and email."
  read -rp "  Your full name: " git_name
  read -rp "  Your email: " git_email
  git config --global user.name "$git_name"
  git config --global user.email "$git_email"
fi

echo "[4/9] Done."

# ------------------------------------------------------------
# 5. NEOVIM CONFIG (BESPOKE EKOHACKS)
# ------------------------------------------------------------
echo "──────────────────────────────────────────────"
echo "[5/9] Setting up Neovim..."
echo "──────────────────────────────────────────────"

mkdir -p "$NVIM_CONFIG"
mkdir -p "$HOME/.vim/undodir"

cat > "$NVIM_CONFIG/init.lua" << 'NVIM_EOF'
-- ============================================================
--  EKOHACKS NEOVIM CONFIG
--  Debian 13 Trixie Edition
--
--  Minimal. Intentional. No plugins until you earn them.
--
--  Key bindings cheat sheet:
--    <Space>       Leader key
--    <Space>t      Run vitest on current file
--    <Space>ta     Run all tests
--    <Space>tw     Watch tests on current file
--    <Space>e      File explorer (netrw)
--    <Space>v      Vertical split
--    <Space>s      Horizontal split
--    <Space>w      Save
--    <Space>q      Quit
--    <Space>gs     Git status
--    <Space>gd     Git diff
--    <Space>gl     Git log
--    Ctrl+h/j/k/l Navigate between splits
-- ============================================================

-- Leader key
vim.g.mapleader = " "
vim.g.maplocalleader = " "

-- ============================================================
-- CORE SETTINGS
-- ============================================================
vim.opt.number = true
vim.opt.relativenumber = true
vim.opt.tabstop = 2
vim.opt.shiftwidth = 2
vim.opt.expandtab = true
vim.opt.smartindent = true
vim.opt.wrap = false
vim.opt.swapfile = false
vim.opt.backup = false
vim.opt.undodir = os.getenv("HOME") .. "/.vim/undodir"
vim.opt.undofile = true
vim.opt.hlsearch = false
vim.opt.incsearch = true
vim.opt.termguicolors = true
vim.opt.scrolloff = 8
vim.opt.signcolumn = "yes"
vim.opt.colorcolumn = "80"
vim.opt.clipboard = "unnamedplus"
vim.opt.cursorline = true
vim.opt.ignorecase = true
vim.opt.smartcase = true
vim.opt.updatetime = 250
vim.opt.splitright = true
vim.opt.splitbelow = true

-- Status line: minimal, shows what matters
vim.opt.statusline = " %f %m %= [%{&filetype}] %l:%c  %p%% "

-- Colourscheme: built in, no plugin needed
vim.cmd("colorscheme habamax")

-- Netrw settings (file explorer)
vim.g.netrw_banner = 0
vim.g.netrw_liststyle = 3
vim.g.netrw_winsize = 25

-- ============================================================
-- KEYMAPS
-- ============================================================
local map = vim.keymap.set

-- File navigation
map("n", "<leader>e", vim.cmd.Ex, { desc = "File explorer" })

-- Window management
map("n", "<leader>v", ":vsplit<CR>", { desc = "Vertical split" })
map("n", "<leader>s", ":split<CR>", { desc = "Horizontal split" })
map("n", "<C-h>", "<C-w>h")
map("n", "<C-j>", "<C-w>j")
map("n", "<C-k>", "<C-w>k")
map("n", "<C-l>", "<C-w>l")

-- Move lines in visual mode
map("v", "J", ":m '>+1<CR>gv=gv")
map("v", "K", ":m '<-2<CR>gv=gv")

-- Keep cursor centred when scrolling
map("n", "<C-d>", "<C-d>zz")
map("n", "<C-u>", "<C-u>zz")

-- Keep search results centred
map("n", "n", "nzzzv")
map("n", "N", "Nzzzv")

-- TDD workflow: run vitest from nvim
map("n", "<leader>t", ":!npx vitest run %<CR>", { desc = "Run tests (file)" })
map("n", "<leader>ta", ":!npx vitest run<CR>", { desc = "Run all tests" })
map("n", "<leader>tw", ":!npx vitest --watch %<CR>", { desc = "Watch tests (file)" })

-- Quick save and quit
map("n", "<leader>w", ":w<CR>", { desc = "Save" })
map("n", "<leader>q", ":q<CR>", { desc = "Quit" })

-- Git shortcuts (quick glance without leaving nvim)
map("n", "<leader>gs", ":!git status<CR>", { desc = "Git status" })
map("n", "<leader>gd", ":!git diff<CR>", { desc = "Git diff" })
map("n", "<leader>gl", ":!git log --oneline -20<CR>", { desc = "Git log" })
map("n", "<leader>gc", ':!git add -A && git commit -v<CR>', { desc = "Git commit" })

-- Paste over selection without losing register
map("x", "<leader>p", '"_dP')

-- ============================================================
-- AUTOCMDS
-- ============================================================

-- Highlight yanked text briefly
vim.api.nvim_create_autocmd("TextYankPost", {
  callback = function()
    vim.highlight.on_yank({ timeout = 150 })
  end,
})

-- Remove trailing whitespace on save
vim.api.nvim_create_autocmd("BufWritePre", {
  pattern = "*",
  callback = function()
    local pos = vim.api.nvim_win_get_cursor(0)
    vim.cmd([[%s/\s\+$//e]])
    vim.api.nvim_win_set_cursor(0, pos)
  end,
})

-- Wider column for test files
vim.api.nvim_create_autocmd({ "BufRead", "BufNewFile" }, {
  pattern = { "*.test.ts", "*.test.js", "*.spec.ts", "*.spec.js" },
  callback = function()
    vim.opt_local.colorcolumn = "120"
  end,
})

-- Return to last edit position when opening a file
vim.api.nvim_create_autocmd("BufReadPost", {
  callback = function()
    local mark = vim.api.nvim_buf_get_mark(0, '"')
    local line_count = vim.api.nvim_buf_line_count(0)
    if mark[1] > 0 and mark[1] <= line_count then
      vim.api.nvim_win_set_cursor(0, mark)
    end
  end,
})
NVIM_EOF

echo "[5/9] Done."

# ------------------------------------------------------------
# 6. TMUX CONFIG
# ------------------------------------------------------------
echo "──────────────────────────────────────────────"
echo "[6/9] Setting up tmux..."
echo "──────────────────────────────────────────────"

cat > "$TMUX_CONF" << 'TMUX_EOF'
# ============================================================
#  EKOHACKS TMUX CONFIG
#
#  Key bindings cheat sheet:
#    Ctrl+a        Prefix (instead of Ctrl+b)
#    Prefix v      Split vertical
#    Prefix s      Split horizontal
#    Prefix h/j/k/l Navigate panes
#    Prefix T      TDD layout (nvim left, vitest right)
#    Prefix r      Reload this config
# ============================================================

# Remap prefix to Ctrl+a
unbind C-b
set -g prefix C-a
bind C-a send-prefix

# Split panes with v and s (vim style)
bind v split-window -h -c "#{pane_current_path}"
bind s split-window -v -c "#{pane_current_path}"

# Navigate panes with vim keys
bind h select-pane -L
bind j select-pane -D
bind k select-pane -U
bind l select-pane -R

# Resize panes
bind -r H resize-pane -L 5
bind -r J resize-pane -D 5
bind -r K resize-pane -U 5
bind -r L resize-pane -R 5

# Reload config
bind r source-file ~/.tmux.conf \; display "Config reloaded"

# Sensible defaults
set -g default-terminal "tmux-256color"
set -ag terminal-overrides ",alacritty:RGB"
set -g mouse off
set -g base-index 1
setw -g pane-base-index 1
set -g renumber-windows on
set -g history-limit 50000
set -sg escape-time 0

# Status bar: minimal
set -g status-style "bg=#1a1a1a,fg=#cccccc"
set -g status-left " #S "
set -g status-right " %H:%M "
set -g status-left-length 20

# Pane borders
set -g pane-border-style "fg=#333333"
set -g pane-active-border-style "fg=#4a9a4a"

# TDD layout shortcut
# Creates: nvim on left (60%), vitest --watch on right (40%)
bind T split-window -h -l 40% -c "#{pane_current_path}" \; \
       send-keys "npx vitest --watch" Enter \; \
       select-pane -L
TMUX_EOF

echo "[6/9] Done."

# ------------------------------------------------------------
# 7. I3 WINDOW MANAGER CONFIG
# ------------------------------------------------------------
echo "──────────────────────────────────────────────"
echo "[7/9] Setting up i3..."
echo "──────────────────────────────────────────────"

mkdir -p "$I3_CONFIG"

cat > "$I3_CONFIG/config" << 'I3_EOF'
# ============================================================
#  EKOHACKS I3 CONFIG
#  Keyboard driven. No mouse. No distractions.
#
#  Key bindings cheat sheet:
#    Super+Return     Open terminal
#    Super+d          App launcher
#    Super+Shift+q    Close window
#    Super+h/j/k/l    Focus (vim style)
#    Super+Shift+h/j/k/l  Move window
#    Super+1/2/3/4    Switch workspace
#    Super+f          Fullscreen
#    Super+r          Resize mode
#    Super+Shift+r    Restart i3
#    Super+Shift+e    Exit i3 (asks first)
#    Super+Shift+x    Lock screen
# ============================================================

set $mod Mod4

# Font
font pango:Fira Code 10

# Terminal
bindsym $mod+Return exec alacritty

# Kill window
bindsym $mod+Shift+q kill

# Application launcher
bindsym $mod+d exec dmenu_run -fn "Fira Code-10" -nb "#1a1a1a" -nf "#cccccc" -sb "#4a9a4a" -sf "#ffffff"

# Focus (vim keys)
bindsym $mod+h focus left
bindsym $mod+j focus down
bindsym $mod+k focus up
bindsym $mod+l focus right

# Move windows (vim keys)
bindsym $mod+Shift+h move left
bindsym $mod+Shift+j move down
bindsym $mod+Shift+k move up
bindsym $mod+Shift+l move right

# Split orientation
bindsym $mod+v split v
bindsym $mod+b split h

# Fullscreen
bindsym $mod+f fullscreen toggle

# Floating toggle
bindsym $mod+Shift+space floating toggle

# Workspaces (named by activity)
set $ws1 "1: code"
set $ws2 "2: test"
set $ws3 "3: git"
set $ws4 "4: web"

bindsym $mod+1 workspace $ws1
bindsym $mod+2 workspace $ws2
bindsym $mod+3 workspace $ws3
bindsym $mod+4 workspace $ws4

bindsym $mod+Shift+1 move container to workspace $ws1
bindsym $mod+Shift+2 move container to workspace $ws2
bindsym $mod+Shift+3 move container to workspace $ws3
bindsym $mod+Shift+4 move container to workspace $ws4

# Restart i3
bindsym $mod+Shift+r restart

# Exit i3 back to the console (asks first)
bindsym $mod+Shift+e exec "i3-nagbar -t warning -m 'Exit i3?' -B 'Yes, exit' 'i3-msg exit'"

# Lock screen
bindsym $mod+Shift+x exec i3lock -c 1a1a1a

# Resize mode
mode "resize" {
  bindsym h resize shrink width 5 px or 5 ppt
  bindsym j resize grow height 5 px or 5 ppt
  bindsym k resize shrink height 5 px or 5 ppt
  bindsym l resize grow width 5 px or 5 ppt
  bindsym Return mode "default"
  bindsym Escape mode "default"
}
bindsym $mod+r mode "resize"

# Brightness (EliteBook 840r G4)
bindsym XF86MonBrightnessUp exec brightnessctl set +10%
bindsym XF86MonBrightnessDown exec brightnessctl set 10%-

# Volume (EliteBook 840r G4)
bindsym XF86AudioRaiseVolume exec pactl set-sink-volume @DEFAULT_SINK@ +5%
bindsym XF86AudioLowerVolume exec pactl set-sink-volume @DEFAULT_SINK@ -5%
bindsym XF86AudioMute exec pactl set-sink-mute @DEFAULT_SINK@ toggle

# Status bar
bar {
  status_command i3status
  position top
  colors {
    background #1a1a1a
    statusline #cccccc
    focused_workspace  #4a9a4a #4a9a4a #ffffff
    inactive_workspace #1a1a1a #1a1a1a #666666
    urgent_workspace   #cc6666 #cc6666 #ffffff
  }
}

# No window titles, thin borders
default_border pixel 2
default_floating_border pixel 2

# Colours (muted green: craft, not flash)
client.focused          #4a9a4a #4a9a4a #ffffff #4a9a4a
client.unfocused        #1a1a1a #1a1a1a #666666 #1a1a1a
client.focused_inactive #333333 #333333 #ffffff #333333
client.urgent           #cc6666 #cc6666 #ffffff #cc6666

# Gaps
gaps inner 4
gaps outer 0

# Autostart
exec --no-startup-id xset s off
exec --no-startup-id xset -dpms
exec --no-startup-id nm-applet
I3_EOF

# i3status config (tailored for EliteBook hardware)
mkdir -p "$HOME/.config/i3status"
cat > "$HOME/.config/i3status/config" << 'I3STATUS_EOF'
general {
  colors = true
  color_good = "#4a9a4a"
  color_degraded = "#cccc00"
  color_bad = "#cc6666"
  interval = 5
}

order += "wireless _first_"
order += "cpu_usage"
order += "memory"
order += "disk /"
order += "battery 0"
order += "tztime local"

wireless _first_ {
  format_up = " W: %quality %essid "
  format_down = " W: down "
}

cpu_usage {
  format = " CPU %usage "
}

memory {
  format = " MEM %used/%total "
  threshold_degraded = "1G"
}

disk "/" {
  format = " DISK %avail "
}

battery 0 {
  format = " BAT %percentage %status "
  low_threshold = 20
  threshold_type = percentage
  status_chr = "CHR"
  status_bat = "DIS"
  status_full = "FULL"
}

tztime local {
  format = " %a %d %b %H:%M "
}
I3STATUS_EOF

echo "[7/9] Done."

# ------------------------------------------------------------
# 8. ALACRITTY CONFIG
# ------------------------------------------------------------
echo "──────────────────────────────────────────────"
echo "[8/9] Setting up Alacritty..."
echo "──────────────────────────────────────────────"

mkdir -p "$ALACRITTY_CONFIG"

cat > "$ALACRITTY_CONFIG/alacritty.toml" << 'ALACRITTY_EOF'
# ============================================================
#  EKOHACKS ALACRITTY CONFIG
#  Optimised for 14" 1920x1080 (EliteBook 840r G4)
# ============================================================

[font]
size = 13.0

[font.normal]
family = "Fira Code"
style = "Regular"

[font.bold]
family = "Fira Code"
style = "Bold"

[window]
padding = { x = 8, y = 8 }
opacity = 0.95
dynamic_padding = true

# Muted green theme: craft, not flash
[colors.primary]
background = "#1a1a1a"
foreground = "#cccccc"

[colors.normal]
black   = "#1a1a1a"
red     = "#cc6666"
green   = "#4a9a4a"
yellow  = "#cccc66"
blue    = "#6688aa"
magenta = "#aa6688"
cyan    = "#66aaaa"
white   = "#cccccc"

[colors.bright]
black   = "#555555"
red     = "#ee8888"
green   = "#66cc66"
yellow  = "#eeee88"
blue    = "#88aacc"
magenta = "#cc88aa"
cyan    = "#88cccc"
white   = "#eeeeee"

[cursor]
style = { shape = "Block", blinking = "Off" }

[scrolling]
history = 10000
ALACRITTY_EOF

echo "[8/9] Done."

# ------------------------------------------------------------
# 9. SHELL CONFIG
# ------------------------------------------------------------
echo "──────────────────────────────────────────────"
echo "[9/9] Setting up shell..."
echo "──────────────────────────────────────────────"

# Create ekohacks directory for any future dojo tools
mkdir -p "$EKOHACKS_DIR"

# Only append if not already present
if ! grep -q "EKOHACKS DOJO ENVIRONMENT" "$HOME/.bashrc" 2>/dev/null; then
cat >> "$HOME/.bashrc" << 'BASH_EOF'

# ============================================================
#  EKOHACKS DOJO ENVIRONMENT
# ============================================================

# Enable bash completion (tab complete for git, apt, and other commands)
if [ -f /usr/share/bash-completion/bash_completion ]; then
  . /usr/share/bash-completion/bash_completion
fi

# Prompt: clean, shows git branch and exit code
parse_git_branch() {
  git branch 2>/dev/null | sed -e '/^[^*]/d' -e 's/* \(.*\)/ (\1)/'
}
export PS1='\[\033[0;32m\]ekohacks\[\033[0m\]:\[\033[0;34m\]\w\[\033[0;33m\]$(parse_git_branch)\[\033[0m\] $ '

# Aliases: TDD workflow
alias t='npx vitest run'
alias tw='npx vitest --watch'
alias tf='npx vitest run --reporter=verbose'
alias tc='npx vitest run --coverage'

# Aliases: git shortcuts
alias gs='git status'
alias gd='git diff'
alias gds='git diff --staged'
alias gl='git log --oneline --graph --all --decorate -20'
alias ga='git add'
alias gc='git commit -v'
alias gp='git push'

# TDD commit helpers: same prefixes as the git aliases, refuse an empty message.
# When pairing-with has set a partner, commits credit both of you.
_dojo_commit() {
  local prefix="$1" msg="$2"
  if [ -n "${DOJO_PAIR:-}" ]; then
    git add -A && git commit -m "$prefix: $msg" -m "Co-authored-by: $DOJO_PAIR"
  else
    git add -A && git commit -m "$prefix: $msg"
  fi
}
green() {
  if [ -z "${1:-}" ]; then echo "usage: green 'what you made pass'"; return 1; fi
  _dojo_commit green "$1"
}
red() {
  if [ -z "${1:-}" ]; then echo "usage: red 'the test you wrote'"; return 1; fi
  _dojo_commit red "$1"
}
refactor() {
  if [ -z "${1:-}" ]; then echo "usage: refactor 'what you cleaned up'"; return 1; fi
  _dojo_commit refactor "$1"
}

# XP pairing credit: tell the shell who you are pairing with
pairing-with() {
  if [ -z "${1:-}" ]; then
    if [ -n "${DOJO_PAIR:-}" ]; then
      echo "Pairing with: $DOJO_PAIR"
    else
      echo "usage: pairing-with 'Sam Coleson <sam@example.com>'"
    fi
    return 0
  fi
  export DOJO_PAIR="$*"
  echo "Commits will credit: $DOJO_PAIR"
}

pairing-solo() {
  unset DOJO_PAIR
  echo "Back to solo commits."
}

# Aliases: navigation
alias ..='cd ..'
alias ...='cd ../..'
alias ll='ls -la --color=auto'
alias la='ls -A --color=auto'

# Aliases: safety
alias rm='rm -i'
alias mv='mv -i'
alias cp='cp -i'

# fd is installed as fdfind on Debian
alias fd='fdfind'

# Aliases: ops tools (agenda rather than cal, so the standard cal command still works)
alias r='ranger'
alias agenda='calcurse'
alias mail='neomutt'
alias sheet='sc-im'

# Document conversion (md2pdf, md2docx, md2pptx) lives in ~/.local/bin as real
# scripts rather than shell functions, so entr, ranger and neomutt can call it too

# Watch a file and rebuild on save (e.g. watchfile report.md md2pdf)
watchfile() {
  local file="$1"
  local cmd="$2"
  echo "Watching $file... (Ctrl+C to stop)"
  echo "$file" | entr -s "$cmd $file"
}

# Dojo helper: new TDD session
dojo-start() {
  echo ""
  echo "  ╔═══════════════════════════════════════╗"
  echo "  ║       EKOHACKS DOJO SESSION           ║"
  echo "  ╚═══════════════════════════════════════╝"
  echo ""
  echo "  Red -> Green -> Refactor"
  echo "  Commit every green."
  echo ""
  echo "  Workspace: $(pwd)"
  echo "  Branch:    $(git branch --show-current 2>/dev/null || echo 'not a repo')"
  echo "  Node:      $(node -v 2>/dev/null || echo 'not installed')"
  echo ""
  echo "  TDD commands:"
  echo "    t         run tests once"
  echo "    tw        watch mode"
  echo "    tf        verbose output"
  echo "    red       commit a failing test (red 'describe the behaviour')"
  echo "    green     commit passing code (green 'add player X logic')"
  echo "    refactor  commit a clean up (refactor 'extract helper')"
  echo ""
  echo "  Pairing (XP):"
  echo "    dojo-pair host          share this terminal on the LAN"
  echo "    dojo-pair join <ip>     join a partner's shared session"
  echo "    pairing-with 'Name <email>'   credit your partner on commits"
  echo "    pairing-solo            stop crediting a partner"
  echo "    dojo-rotate 10          chime every 10 minutes to swap roles"
  echo "    tmate                   pair over the internet"
  echo ""
  echo "  Tmux TDD layout:"
  echo "    tmux then Ctrl+a T"
  echo ""
}

# Show dojo info on terminal open
dojo-start
BASH_EOF
fi

# ------------------------------------------------------------
# INSTALL DOJO SCRIPTS TO PATH
# ------------------------------------------------------------

DOJO_BIN="$HOME/.local/bin"
mkdir -p "$DOJO_BIN"

# Copy dojo-init from the repo (if running from the cloned repo)
SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"

if [ -f "$SCRIPT_DIR/bin/dojo-init" ]; then
  cp "$SCRIPT_DIR/bin/dojo-init" "$DOJO_BIN/dojo-init"
  chmod +x "$DOJO_BIN/dojo-init"
  echo "Installed dojo-init to $DOJO_BIN"
else
  echo "WARNING: bin/dojo-init not found in repo. Skipping."
fi

# Document conversion helpers: installed as real scripts rather than shell
# functions so they work from entr, ranger and neomutt as well as the shell.
# xelatex (not pdflatex) so the mainfont setting actually takes effect.
cat > "$DOJO_BIN/md2pdf" << 'MD2PDF_EOF'
#!/usr/bin/env bash
set -euo pipefail
if [ $# -ne 1 ]; then
  echo "usage: md2pdf <file.md>"
  exit 1
fi
input="$1"
output="${input%.md}.pdf"
pandoc "$input" -o "$output" \
  --pdf-engine=xelatex \
  -V geometry:margin=1in \
  -V fontsize=11pt \
  -V mainfont="Noto Sans" \
  --highlight-style=tango
echo "Created: $output"
MD2PDF_EOF
chmod +x "$DOJO_BIN/md2pdf"

cat > "$DOJO_BIN/md2docx" << 'MD2DOCX_EOF'
#!/usr/bin/env bash
set -euo pipefail
if [ $# -ne 1 ]; then
  echo "usage: md2docx <file.md>"
  exit 1
fi
input="$1"
output="${input%.md}.docx"
pandoc "$input" -o "$output"
echo "Created: $output"
MD2DOCX_EOF
chmod +x "$DOJO_BIN/md2docx"

cat > "$DOJO_BIN/md2pptx" << 'MD2PPTX_EOF'
#!/usr/bin/env bash
set -euo pipefail
if [ $# -ne 1 ]; then
  echo "usage: md2pptx <file.md>"
  exit 1
fi
input="$1"
output="${input%.md}.pptx"
pandoc "$input" -t pptx -o "$output"
echo "Created: $output"
MD2PPTX_EOF
chmod +x "$DOJO_BIN/md2pptx"
echo "Installed md2pdf, md2docx, md2pptx to $DOJO_BIN"

# XP pairing: shared tmux session over the LAN
cat > "$DOJO_BIN/dojo-pair" << 'PAIR_EOF'
#!/usr/bin/env bash
# Shared tmux pairing session over the LAN
set -euo pipefail

usage() {
  echo "usage: dojo-pair host              start a shared session and show the join command"
  echo "       dojo-pair join <ip> [user]  join a partner's session over ssh"
  exit 1
}

[ $# -ge 1 ] || usage

case "$1" in
  host)
    ip="$(hostname -I 2>/dev/null | awk '{print $1}')"
    echo ""
    echo "  Shared session starting. Your partner joins with:"
    echo ""
    echo "    dojo-pair join ${ip:-<this-machine-ip>} $USER"
    echo ""
    echo "  Both of you type in the same panes. Talk while you type."
    echo ""
    exec tmux new-session -A -s pair
    ;;
  join)
    [ $# -ge 2 ] || usage
    host_ip="$2"
    remote_user="${3:-$USER}"
    exec ssh -t "$remote_user@$host_ip" "tmux new-session -A -s pair"
    ;;
  *)
    usage
    ;;
esac
PAIR_EOF
chmod +x "$DOJO_BIN/dojo-pair"

# XP pairing: rotation chime for driver and navigator swaps
cat > "$DOJO_BIN/dojo-rotate" << 'ROTATE_EOF'
#!/usr/bin/env bash
# Chime every N minutes so the pair swaps driver and navigator
set -euo pipefail

minutes="${1:-10}"
case "$minutes" in
  ''|0|*[!0-9]*)
    echo "usage: dojo-rotate [minutes]"
    echo "example: dojo-rotate 10"
    exit 1
    ;;
esac

chime="/usr/share/sounds/freedesktop/stereo/complete.oga"
echo "Rotation timer running: swap every $minutes minutes. Ctrl+C to stop."

rotation=0
while true; do
  sleep "$((minutes * 60))"
  rotation=$((rotation + 1))
  echo "$(date +%H:%M)  Rotation $rotation: swap driver and navigator."
  paplay "$chime" 2>/dev/null || printf '\a'
done
ROTATE_EOF
chmod +x "$DOJO_BIN/dojo-rotate"
echo "Installed dojo-pair and dojo-rotate to $DOJO_BIN"

# Make sure ~/.local/bin is in PATH
if ! grep -q 'HOME/.local/bin' "$HOME/.bashrc" 2>/dev/null; then
  echo 'export PATH="$HOME/.local/bin:$PATH"' >> "$HOME/.bashrc"
fi

# ------------------------------------------------------------
# STARTX CONFIG
# ------------------------------------------------------------
cat > "$HOME/.xinitrc" << 'XINITRC_EOF'
exec i3
XINITRC_EOF

# ------------------------------------------------------------
# DONE
# ------------------------------------------------------------
echo ""
echo "  ╔═══════════════════════════════════════════╗"
echo "  ║         SETUP COMPLETE                    ║"
echo "  ║                                           ║"
echo "  ║   Next steps:                             ║"
echo "  ║                                           ║"
echo "  ║   1. Reboot your machine                  ║"
echo "  ║      $ sudo reboot                        ║"
echo "  ║                                           ║"
echo "  ║   2. Log in at the text prompt             ║"
echo "  ║                                           ║"
echo "  ║   3. Start the graphical environment      ║"
echo "  ║      $ startx                             ║"
echo "  ║                                           ║"
echo "  ║   4. Open a terminal: Super + Enter       ║"
echo "  ║                                           ║"
echo "  ║   5. Create your first kata               ║"
echo "  ║      $ dojo-init my-first-kata            ║"
echo "  ║                                           ║"
echo "  ║   Remember: Red. Green. Refactor.         ║"
echo "  ╚═══════════════════════════════════════════╝"
echo ""
echo "  Full log saved to: $LOG_FILE"
echo ""