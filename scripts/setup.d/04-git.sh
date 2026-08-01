# ============================================================
#  GIT: defaults, aliases, TDD commit helpers
#  Module of ekohacks-dojo-setup.sh, sourced in filename order.
# ============================================================

# Sourced, not executed: shared state lives in the orchestrator.
if [ "${BASH_SOURCE[0]}" = "$0" ]; then
  echo "This is a module of ekohacks-dojo-setup.sh. Run that instead." >&2
  exit 1
fi

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
