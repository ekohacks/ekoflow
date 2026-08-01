# ============================================================
#  STARTX: Xresources for HiDPI and xinitrc
#  Module of ekohacks-dojo-setup.sh, sourced in filename order.
# ============================================================

# Sourced, not executed: shared state lives in the orchestrator.
if [ "${BASH_SOURCE[0]}" = "$0" ]; then
  echo "This is a module of ekohacks-dojo-setup.sh. Run that instead." >&2
  exit 1
fi

# HiDPI panels (MacBook Retina) get fontconfig scaling through Xft.dpi,
# which i3, Alacritty and dmenu all honour, so font sizes stay unchanged
if [ "$HIDPI" -eq 1 ]; then
  cat > "$HOME/.Xresources" << 'XRES_EOF'
Xft.dpi: 180
XRES_EOF
fi

cat > "$HOME/.xinitrc" << 'XINITRC_EOF'
[ -f "$HOME/.Xresources" ] && xrdb -merge "$HOME/.Xresources"
exec i3
XINITRC_EOF
