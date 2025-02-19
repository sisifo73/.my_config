#!/bin/bash

set -e  # Exit on any error

# Install Neovim and necessary dependencies
sudo pacman -S --noconfirm neovim nodejs npm

# Install LSP servers and Treesitter dependencies
sudo pacman -S --noconfirm python-lsp-server bash-language-server clang

# Clone Lazy.nvim plugin manager
mkdir -p ~/.config/nvim
if [ ! -d "$HOME/.config/nvim" ]; then
    git clone https://github.com/sisifo73/.my_config.git ~/my_config
    cp -r ~/my_config/nvim ~/.config/
fi

git clone --depth 1 https://github.com/folke/lazy.nvim \
    ~/.local/share/nvim/site/pack/lazy/start/lazy.nvim

# Install Neovim plugins
nvim --headless "+Lazy sync" +qall

# Install Treesitter parsers if used
nvim --headless "+TSInstall all" +qall

# Set Neovim as default editor
echo 'export EDITOR=nvim' >> ~/.bashrc
source ~/.bashrc

# Done
echo "Neovim setup complete."

