#!/usr/bin/env bash
# ============================================================
#  OPTIONAL: CLAUDE CODE
#  For ops and instructor machines only. The training floor
#  stays AI free, so this is never part of the base install.
#
#  Standalone by design: run it by hand, weeks after
#  provisioning if you like. It checks what it needs itself
#  and is safe to run twice.
#
#  Usage:
#    ./install-claude-code.sh
# ============================================================

set -euo pipefail

if [ "$(id -u)" -eq 0 ]; then
  echo "ERROR: Do not run this script as root."
  echo "Run it as your normal user."
  exit 1
fi

if command -v claude >/dev/null 2>&1 || [ -x "$HOME/.local/bin/claude" ]; then
  echo "Claude Code is already installed. Nothing to do."
  exit 0
fi

if ! command -v curl >/dev/null 2>&1; then
  echo "ERROR: curl is required. Run the base dojo setup first."
  exit 1
fi

# Native installer: a self updating binary in ~/.local/bin. Kept away
# from the nvm managed Node so a Node upgrade never breaks it.
curl -fsSL https://claude.ai/install.sh | bash

# The base setup already puts ~/.local/bin on PATH; cover a machine
# that skipped it
if ! grep -q 'HOME/.local/bin' "$HOME/.bashrc" 2>/dev/null; then
  echo 'export PATH="$HOME/.local/bin:$PATH"' >> "$HOME/.bashrc"
fi

echo ""
echo "Claude Code installed. It needs a login the first time it runs:"
echo "  claude"
echo "Sign in with the Ekohacks Claude account when prompted."
echo ""
