# ============================================================
#  DOJO SCRIPTS: dojo-init, converters, pairing tools in ~/.local/bin
#  Module of ekohacks-dojo-setup.sh, sourced in filename order.
# ============================================================

# Sourced, not executed: shared state lives in the orchestrator.
if [ "${BASH_SOURCE[0]}" = "$0" ]; then
  echo "This is a module of ekohacks-dojo-setup.sh. Run that instead." >&2
  exit 1
fi

DOJO_BIN="$HOME/.local/bin"
mkdir -p "$DOJO_BIN"

# Copy dojo-init from the repo (if running from the cloned repo).
# REPO_DIR is set by the orchestrator: bin/ lives at the repo root,
# not next to the setup scripts.
if [ -f "$REPO_DIR/bin/dojo-init" ]; then
  cp "$REPO_DIR/bin/dojo-init" "$DOJO_BIN/dojo-init"
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
