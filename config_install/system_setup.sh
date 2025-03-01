#!/bin/bash

set -e  # Exit on any error

# Update system and install essential packages
sudo pacman -Syu --noconfirm
sudo pacman -S --noconfirm base-devel git tmux curl wget unzip zip chromium firefox zsh

# Install Python and required libraries
sudo pacman -S --noconfirm python python-pip python-virtualenvwrapper
pip install --upgrade pip

# Configure virtualenvwrapper
echo 'export WORKON_HOME=$HOME/.virtualenvs' >> ~/.bashrc
echo 'export VIRTUALENVWRAPPER_PYTHON=/usr/bin/python3' >> ~/.bashrc
echo 'source /usr/bin/virtualenvwrapper.sh' >> ~/.bashrc
source ~/.bashrc

# Install and configure Zsh
echo "Installing and configuring Zsh..."
if [ ! -d "$HOME/.oh-my-zsh" ]; then
    echo "Installing Oh My Zsh..."
    sh -c "$(curl -fsSL https://raw.githubusercontent.com/ohmyzsh/ohmyzsh/master/tools/install.sh)" "" --unattended
fi

# Set Zsh as default shell
chsh -s $(which zsh)

# Create scripts in /bin
echo "Creating WhatsApp and GPT scripts in /bin..."
echo "#!/bin/bash
chromium --app=https://web.whatsapp.com --start-fullscreen --force-dark-mode >/dev/null 2>&1 &" | sudo tee /bin/whatsapp > /dev/null

echo "#!/bin/bash
chromium --app=https://chat.openai.com --start-fullscreen --force-dark-mode >/dev/null 2>&1 &" | sudo tee /bin/gpt > /dev/null

# Make scripts executable
sudo chmod +x /bin/whatsapp /bin/gpt

# Ensure services start properly
systemctl enable --now NetworkManager

# Done
echo "System setup complete. Please restart your system."

