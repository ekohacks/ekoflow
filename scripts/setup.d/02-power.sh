# ============================================================
#  POWER MANAGEMENT: tlp for battery life
#  Module of ekohacks-dojo-setup.sh, sourced in filename order.
# ============================================================

# Sourced, not executed: shared state lives in the orchestrator.
if [ "${BASH_SOURCE[0]}" = "$0" ]; then
  echo "This is a module of ekohacks-dojo-setup.sh. Run that instead." >&2
  exit 1
fi

sudo apt install -y \
  tlp \
  tlp-rdw

sudo systemctl enable tlp
sudo systemctl start tlp

