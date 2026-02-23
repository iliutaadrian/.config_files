#!/bin/bash

ln -s ~/config/.tmux.conf ~/.tmux.conf
ln -s ~/config/starship.toml ~/.config/starship.toml
ln -s ~/config/.zshrc ~/.zshrc
ln -s ~/config/.inputrc ~/.inputrc
ln -s ~/config/zapmarks.json ~/.config/zapmarks.json

ln -s ~/config/nvim ~/.config/nvim
ln -s ~/config/lvim ~/.config/lvim
ln -s ~/config/aerospace ~/.config/aerospace

echo "Symlink creation complete!"
