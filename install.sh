#!/bin/bash

# Set linux distro
linux_distro=$(cat /etc/os-release | awk -F'=' '$1=="ID" {print $2}')

# Set package manager
if [[ "$linux_distro" == "ubuntu" ]]; then
    pkg="apt"
elif [[ "$linux_distro" == "fedora" ]]; then
    pkg="dnf"
fi

# Update
$pkg update -y

# GNU coreutirls, git, curl, wget
$pkg install -y coreutils git curl wget

# Install Nerd Fonts
echo "Installing Nerd Fonts"
git clone --depth 1 https://github.com/ryanoasis/nerd-fonts.git
./nerd-fonts/install.sh

# Install zsh, vim, neovim, tmux
$pkg install -y zsh vim neovim tmux

# Setting up dotfiles
if [ ! -d "$HOME/dotfiles" ]; then
    git clone https://github.com/Bibbeep/dotfiles.git $HOME/dotfiles
fi

cd $HOME/dotfiles || exit

echo "Stowing dotfiles..."
stow -t ~ tmux vim nvim

echo "Dotfiles setup completed!"
