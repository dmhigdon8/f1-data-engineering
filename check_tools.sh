#!/usr/bin/env bash
# ------------------------------------------------------------
# check_tools.sh — one-shot audit of your data-engineering toolchain
# Usage:  bash check_tools.sh
# ------------------------------------------------------------

set -u

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
echo "macOS detected: $(sw_vers -productName 2>/dev/null) $(sw_vers -productVersion 2>/dev/null)"
echo ""

row "git"         "git"          "--version"
row "python3"    "python3"       "--version"
row "pip3"       "pip3"          "--version"
row "docker"     "docker"        "--version"
row "compose"    "docker compose" "version --short"
row "psql"       "psql"          "--version"
row "aws"        "aws"           "--version"
row "dbt"        "dbt"           "--version"
row "postman"    "postman"       "-v"
row "brew"       "brew"          "--version"

echo ""
echo "Docker daemon status:"
if docker info >/dev/null 2>&1; then
  echo "  [OK] Docker daemon is running."
else
  echo "  [WARN] Docker is installed but daemon is not running (open Docker Desktop)."
fi

echo ""
echo "Done. Paste the full output back to Claude."
