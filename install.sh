#!/bin/bash
set -e

OS="$(uname -s)"
echo "Setting up config for $OS..."

mkdir -p ~/.config

# Helper: safe symlink (backs up existing dir/file, skips if already correct)
lns() {
  local src="$1" dst="$2"
  if [[ -L "$dst" && "$(readlink "$dst")" == "$src" ]]; then
    return  # already correct
  fi
  if [[ -e "$dst" && ! -L "$dst" ]]; then
    mv "$dst" "${dst}.bak.$(date +%s)"
    echo "Backed up $dst"
  fi
  ln -sf "$src" "$dst"
  echo "Linked $dst → $src"
}

# .zshrc entry point (just sources zsh/rc)
if [[ ! -f ~/config/.zshrc ]]; then
  echo 'source "$HOME/config/zsh/rc"' > ~/config/.zshrc
fi

lns ~/config/.zshrc         ~/.zshrc
lns ~/config/starship.toml  ~/.config/starship.toml
lns ~/config/nvim           ~/.config/nvim

if [[ "$OS" == "Darwin" ]]; then
  lns ~/config/aerospace ~/.config/aerospace
fi

echo "Done!"
