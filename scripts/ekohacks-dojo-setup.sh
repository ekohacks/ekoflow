#!/usr/bin/env bash
# ============================================================
#  EKOHACKS DOJO MACHINE SETUP
#  Base: Debian 13 "Trixie" Minimal (net install)
#  Targets: HP EliteBook 840r G4 (i5-8250U, 8GB RAM)
#           MacBook Pro Retina Mid 2012 (i7-3615QM, 8GB RAM)
#  Hardware differences (wifi driver, HiDPI panel) are detected
#  automatically, so the same script provisions both fleets.
#  Purpose: Transform bare Debian into a dojo ready machine
#
#  Usage (after Debian 13 minimal install):
#    chmod +x ekohacks-dojo-setup.sh
#    ./ekohacks-dojo-setup.sh
#
#  Structure:
#    This file is the orchestrator. The steps live in setup.d/ as
#    numbered modules, sourced here in filename order so they share
#    hardware detection, one log and one error policy. They are
#    chapters of one provision, not standalone programs.
#
#    Tools that only some machines should have live in optional/ as
#    standalone scripts, run by hand after provisioning.
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

SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
REPO_DIR="$(cd "$SCRIPT_DIR/.." && pwd)"
SETUP_D="$SCRIPT_DIR/setup.d"

EKOHACKS_DIR="$HOME/.ekohacks"
NVIM_CONFIG="$HOME/.config/nvim"
I3_CONFIG="$HOME/.config/i3"
ALACRITTY_CONFIG="$HOME/.config/alacritty"
TMUX_CONF="$HOME/.tmux.conf"
NODE_VERSION="22"
LOG_FILE="$HOME/ekohacks-setup.log"

# Log everything
exec > >(tee -a "$LOG_FILE") 2>&1

# Modules share this shell: variables set by an early module (APPLE,
# HIDPI) are read by later ones, and the set -euo pipefail above
# guards the whole run. The step count is derived from the directory,
# so adding a module never means renumbering banners.
modules=("$SETUP_D"/*.sh)
total="${#modules[@]}"
step=0

for module in "${modules[@]}"; do
  step=$((step + 1))
  name="$(basename "$module" .sh)"
  name="${name#[0-9][0-9]-}"
  echo "──────────────────────────────────────────────"
  echo "[$step/$total] ${name}..."
  echo "──────────────────────────────────────────────"
  # shellcheck source=/dev/null
  source "$module"
  echo "[$step/$total] ${name}: done."
done

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
if [ "$APPLE" -eq 1 ]; then
  echo "  MacBook note: the wifi driver is installed, so after the reboot"
  echo "  wifi is native and the tether or adapter is no longer needed."
  echo ""
fi
echo "  Full log saved to: $LOG_FILE"
echo ""
