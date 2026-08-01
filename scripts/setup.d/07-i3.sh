# ============================================================
#  I3: window manager and status bar config
#  Module of ekohacks-dojo-setup.sh, sourced in filename order.
# ============================================================

# Sourced, not executed: shared state lives in the orchestrator.
if [ "${BASH_SOURCE[0]}" = "$0" ]; then
  echo "This is a module of ekohacks-dojo-setup.sh. Run that instead." >&2
  exit 1
fi

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

# Brightness keys (EliteBook and MacBook both expose XF86 keys)
bindsym XF86MonBrightnessUp exec brightnessctl set +10%
bindsym XF86MonBrightnessDown exec brightnessctl set 10%-

# Volume keys
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
# Fresh installs sometimes boot with audio muted; unmute speakers and mic
exec --no-startup-id pactl set-sink-mute @DEFAULT_SINK@ 0
exec --no-startup-id pactl set-source-mute @DEFAULT_SOURCE@ 0
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
