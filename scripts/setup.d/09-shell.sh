# ============================================================
#  SHELL: bashrc block, aliases, dojo helpers
#  Module of ekohacks-dojo-setup.sh, sourced in filename order.
# ============================================================

# Sourced, not executed: shared state lives in the orchestrator.
if [ "${BASH_SOURCE[0]}" = "$0" ]; then
  echo "This is a module of ekohacks-dojo-setup.sh. Run that instead." >&2
  exit 1
fi

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
