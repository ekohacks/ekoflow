# ============================================================
#  SYSTEM PACKAGES: apt sources, i3, terminal, ops and pairing tools
#  Module of ekohacks-dojo-setup.sh, sourced in filename order.
# ============================================================

# Sourced, not executed: shared state lives in the orchestrator.
if [ "${BASH_SOURCE[0]}" = "$0" ]; then
  echo "This is a module of ekohacks-dojo-setup.sh. Run that instead." >&2
  exit 1
fi

# MacBooks need the proprietary Broadcom wl driver, which lives in the
# non-free component that a minimal install does not enable
if [ "$APPLE" -eq 1 ]; then
  if [ -f /etc/apt/sources.list.d/debian.sources ]; then
    sudo sed -i 's/^Components: .*/Components: main contrib non-free non-free-firmware/' /etc/apt/sources.list.d/debian.sources
  elif [ -f /etc/apt/sources.list ]; then
    sudo sed -i '/^deb /s/ main.*/ main contrib non-free non-free-firmware/' /etc/apt/sources.list
  fi
fi

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

# Network and hardware
# network-manager-gnome provides nm-applet, autostarted by i3
sudo apt install -y \
  network-manager \
  network-manager-gnome \
  pulseaudio \
  pavucontrol \
  brightnessctl

# Wifi driver depends on the machine
if [ "$APPLE" -eq 1 ]; then
  # Broadcom BCM4331 (MacBook Pro Retina Mid 2012) needs the wl driver,
  # built through dkms against the running kernel
  sudo apt install -y linux-headers-amd64 broadcom-sta-dkms
  echo ""
  echo "  Broadcom wifi driver built and installed."
  echo "  Wifi on this MacBook works from the next reboot onwards."
  echo ""
else
  # Intel wifi (EliteBook 840r G4)
  sudo apt install -y firmware-iwlwifi
fi

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

