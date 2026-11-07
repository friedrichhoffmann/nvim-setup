#!/usr/bin/env bash
set -euo pipefail

rm -rf "$HOME/.local/opt/nvim"
rm -f "$HOME/.local/bin/nvim"
rm -rf "$HOME/.local/config/nvim"

echo "Removed Neovim nightly and its config."

