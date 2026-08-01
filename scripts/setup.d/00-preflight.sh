# ============================================================
#  PREFLIGHT: sanity checks, hardware detection, network
#  Module of ekohacks-dojo-setup.sh, sourced in filename order.
# ============================================================

# Sourced, not executed: shared state lives in the orchestrator.
if [ "${BASH_SOURCE[0]}" = "$0" ]; then
  echo "This is a module of ekohacks-dojo-setup.sh. Run that instead." >&2
  exit 1
fi

if [ "$(id -u)" -eq 0 ]; then
  echo "ERROR: Do not run this script as root."
  echo "Run it as your normal user. It will ask for sudo when needed."
  exit 1
fi

if ! grep -qi "debian" /etc/os-release 2>/dev/null; then
  echo "WARNING: This script is designed for Debian 13 Trixie."
  echo "You do not appear to be running Debian."
  read -rp "Continue anyway? (y/n) " answer
  [[ "$answer" != "y" ]] && exit 1
fi
# ------------------------------------------------------------
# HARDWARE DETECTION (EliteBook vs MacBook)
# ------------------------------------------------------------

VENDOR="$(cat /sys/class/dmi/id/sys_vendor 2>/dev/null || echo unknown)"
APPLE=0
case "$VENDOR" in
  Apple*) APPLE=1 ;;
esac

# An internal panel 2560 or wider needs HiDPI scaling (Retina and friends)
HIDPI=0
for modes in /sys/class/drm/card*-eDP-*/modes /sys/class/drm/card*-LVDS-*/modes; do
  [ -r "$modes" ] || continue
  native=""
  read -r native < "$modes" || true
  width="${native%%x*}"
  case "$width" in
    ''|*[!0-9]*) continue ;;
  esac
  if [ "$width" -ge 2560 ]; then
    HIDPI=1
  fi
  break
done

echo ""
echo "  ╔═══════════════════════════════════════════╗"
echo "  ║         EKOHACKS DOJO SETUP               ║"
echo "  ║   Debian 13 Trixie Edition                ║"
echo "  ║                                           ║"
echo "  ║   Train with weights on.                  ║"
echo "  ║   No mouse. No AI. No excuses.            ║"
echo "  ╚═══════════════════════════════════════════╝"
echo ""
echo "  Log file: $LOG_FILE"
echo ""
if [ "$APPLE" -eq 1 ]; then
  echo "  Hardware: Apple detected (Broadcom wifi driver will be used)"
else
  echo "  Hardware: standard profile (Intel wifi firmware)"
fi
if [ "$HIDPI" -eq 1 ]; then
  echo "  Display:  HiDPI panel detected (Retina scaling will be applied)"
fi
echo ""

# ------------------------------------------------------------
# NETWORK CHECK (everything below needs the Debian mirrors)
# ------------------------------------------------------------

network_ok() {
  ping -c 1 -W 5 deb.debian.org >/dev/null 2>&1 && return 0
  timeout 5 bash -c 'exec 3<>/dev/tcp/deb.debian.org/80' >/dev/null 2>&1 && return 0
  return 1
}

if ! network_ok; then
  echo "ERROR: Cannot reach the Debian mirrors, so nothing can be installed."
  echo ""
  if [ "$APPLE" -eq 1 ]; then
    echo "  This MacBook's wifi only starts working after setup completes,"
    echo "  because the Broadcom driver has to be downloaded first."
    echo ""
    echo "  Connect the machine another way, then rerun this script:"
    echo "    - USB tethering from a phone (plug it in, enable tethering), or"
    echo "    - a USB or Thunderbolt ethernet adapter"
  else
    echo "  Check the network connection, then rerun this script."
  fi
  echo ""
  exit 1
fi
