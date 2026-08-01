# ============================================================
#  TMUX: prefix, vim keys, TDD layout
#  Module of ekohacks-dojo-setup.sh, sourced in filename order.
# ============================================================

# Sourced, not executed: shared state lives in the orchestrator.
if [ "${BASH_SOURCE[0]}" = "$0" ]; then
  echo "This is a module of ekohacks-dojo-setup.sh. Run that instead." >&2
  exit 1
fi

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
