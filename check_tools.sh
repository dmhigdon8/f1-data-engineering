#!/usr/bin/env bash
# ------------------------------------------------------------
# check_tools.sh — one-shot audit of your data-engineering toolchain
# Works on macOS and Linux (Ubuntu/Debian assumed for package-manager hints).
# Usage:  bash check_tools.sh
# ------------------------------------------------------------

set -u

OS="$(uname -s)"

row () {
  local name="$1" cmd="$2" version_flag="$3"
  if command -v "$cmd" >/dev/null 2>&1; then
    local ver
    ver=$(eval "$cmd $version_flag" 2>&1 | head -n 1)
    printf "  [OK]      %-12s %s\n" "$name" "$ver"
  else
    printf "  [MISSING] %-12s (not found on PATH)\n" "$name"
  fi
}

echo ""
echo "F1 Data Engineering — toolchain check"
echo "======================================"
if [ "$OS" = "Darwin" ]; then
  echo "OS detected: macOS $(sw_vers -productVersion 2>/dev/null)"
elif [ "$OS" = "Linux" ]; then
  if [ -r /etc/os-release ]; then
    # shellcheck disable=SC1091
    . /etc/os-release
    echo "OS detected: Linux — ${PRETTY_NAME:-unknown distro}"
  else
    echo "OS detected: Linux (distro unknown)"
  fi
else
  echo "OS detected: $OS (untested by this script)"
fi
echo ""

row "git"      "git"            "--version"
row "python3"  "python3"        "--version"
row "pip3"     "pip3"           "--version"
row "docker"   "docker"         "--version"
row "compose"  "docker compose" "version --short"
row "psql"     "psql"           "--version"
row "aws"      "aws"            "--version"
row "dbt"      "dbt"            "--version"

if [ "$OS" = "Darwin" ]; then
  row "brew"     "brew"     "--version"
  row "postman"  "postman"  "-v"
elif [ "$OS" = "Linux" ]; then
  row "curl"     "curl"     "--version"
  row "pipx"     "pipx"     "--version"
fi

echo ""
echo "Docker daemon status:"
if docker info >/dev/null 2>&1; then
  echo "  [OK] Docker daemon is running."
else
  if [ "$OS" = "Darwin" ]; then
    echo "  [WARN] Docker is installed but the daemon is not running (open Docker Desktop)."
  else
    echo "  [WARN] Docker is installed but not reachable. Try: sudo systemctl start docker"
    echo "         If you get a permission error instead, you likely need to be in the"
    echo "         docker group — see the group check below."
  fi
fi

if [ "$OS" = "Linux" ]; then
  echo ""
  echo "Docker group membership (Linux needs this to run docker without sudo):"
  if groups "$USER" 2>/dev/null | grep -qw docker; then
    echo "  [OK] $USER is in the docker group."
  else
    echo "  [WARN] $USER is NOT in the docker group."
    echo "         Fix: sudo usermod -aG docker \$USER"
    echo "         Then fully log out and back in (group changes need a new session)."
  fi
fi

echo ""
echo "Done. Paste the full output back to Claude."
