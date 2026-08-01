# ============================================================
#  ALACRITTY: terminal config and colour scheme
#  Module of ekohacks-dojo-setup.sh, sourced in filename order.
# ============================================================

# Sourced, not executed: shared state lives in the orchestrator.
if [ "${BASH_SOURCE[0]}" = "$0" ]; then
  echo "This is a module of ekohacks-dojo-setup.sh. Run that instead." >&2
  exit 1
fi

mkdir -p "$ALACRITTY_CONFIG"

cat > "$ALACRITTY_CONFIG/alacritty.toml" << 'ALACRITTY_EOF'
# ============================================================
#  EKOHACKS ALACRITTY CONFIG
#  Sized for 14" 1920x1080 (EliteBook 840r G4)
#  Retina panels scale automatically through Xft.dpi
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
