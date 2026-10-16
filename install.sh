#!/usr/bin/env bash
# Symlink wpe, wpe-gui and the desktop entry into ~/.local (re-run after moving the repo).
set -euo pipefail
here="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
bin="$HOME/.local/bin"
apps="${XDG_DATA_HOME:-$HOME/.local/share}/applications"

mkdir -p "$bin" "$apps"
ln -sfn "$here/wpe" "$bin/wpe"
ln -sfn "$here/wpe-gui" "$bin/wpe-gui"
ln -sfn "$here/wpe-gui.desktop" "$apps/wpe-gui.desktop"
echo "Installed wpe and wpe-gui into $bin"

command -v linux-wallpaperengine >/dev/null || echo "Note: linux-wallpaperengine not found (AUR: linux-wallpaperengine-git)"
case ":$PATH:" in *":$bin:"*) ;; *) echo "Note: $bin is not on your PATH" ;; esac
