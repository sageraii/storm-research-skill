#!/usr/bin/env bash
# Install the storm-research skill into Claude Code.
#   ./install.sh            -> personal scope (~/.claude/skills), available in all projects
#   ./install.sh project    -> project scope (./.claude/skills), this repo only
set -euo pipefail

SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]:-$0}")" && pwd)"
SRC="$SCRIPT_DIR/storm-research"

if [ ! -d "$SRC" ]; then
  echo "error: skill folder not found at $SRC" >&2
  exit 1
fi

SCOPE="${1:-personal}"
case "$SCOPE" in
  personal|--personal|"") DEST="$HOME/.claude/skills" ;;
  project|--project)      DEST="$(pwd)/.claude/skills" ;;
  -h|--help)
    echo "Usage: ./install.sh [personal|project]"; exit 0 ;;
  *)
    echo "Usage: ./install.sh [personal|project]" >&2; exit 1 ;;
esac

mkdir -p "$DEST"

if [ -e "$DEST/storm-research" ]; then
  BACKUP="$DEST/storm-research.bak.$(date +%Y%m%d%H%M%S)"
  echo "Existing install found -> backing up to: $BACKUP"
  mv "$DEST/storm-research" "$BACKUP"
fi

cp -R "$SRC" "$DEST/"
echo "Installed: $DEST/storm-research"
echo "Restart Claude Code (or reload skills), then invoke:  /storm-research"
