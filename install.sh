#!/bin/bash

# Set linux distro
linux_distro=$(cat /etc/os-release | awk -F'=' '$1=="ID" {print $2}')
home_dir="/home/$SUDO_USER"

# Set package manager
if [[ "$linux_distro" == "ubuntu" ]]; then
	pkg="apt"
elif [[ "$linux_distro" == "fedora" ]]; then
	pkg="dnf"
fi

# Setting up directories
echo "Creating Workspaces and Playgrounds directories..."

if [[ ! -d "$home_dir/Workspaces" ]]; then
	mkdir -p "$home_dir/Workspaces"
fi

if [[ ! -d "$home_dir/Playgrounds" ]]; then
	mkdir -p "$home_dir/Playgrounds"
fi

echo "Directories created!"

# Install packages
echo "Installing packages..."

$pkg update -y
$pkg copr enable -y dejan/lazygit scottames/ghostty

declare -a packages=(
	coreutils
	git
	curl
	wget
	stow
	unzip
	lazygit
	ghostty
	zsh
	vim
	neovim
	tmux
	fzf
	fd-find
	ripgrep
	bat
	git-delta
	xclip
	glow
	systat
	acpi
	fastfetch
	dnf5-plugins
	htop
	btop
	redis
	gcc
	gcc-c++
)

for package in ${packages[@]}; do
	$pkg install -y $package
done

echo "Packages installed!"

# Set Neovim as the default editor
echo "Setting up Neovim as the default editor..."

export EDITOR=nvim

# Installing NVM and Node.js
"Installing NVM..."
curl -o- https://raw.githubusercontent.com/nvm-sh/nvm/v0.39.3/install.sh | bash -s -- --yes

"Installing Node.js..."
nvm install 20
nvm install 22
nvm install 24

echo "NVM and Node.js installed!"

# Setting up git
echo "Setting up .gitconfig..."

git config --global user.email "habibalfrb@gmail.com"
git config --global user.name "Bibbeep"
git config --global core.pager delta
git config --global core.editor nvim
git config --global interactive.diffFilter 'delta --color-only'
git config --global delta.navigate true
git config --global delta.line-numbers true
git config --global merge.conflictStyle zdiff3

echo ".gitconfig setup completed!"

# Set zsh as the default shell
echo "Setting zsh as the default shell..."

chsh -s $(which zsh)
chsh $SUDO_USER

echo "zsh setup completed!"

# Install oh-my-zsh
echo "Installing oh-my-zsh..."

sh -c "$(curl -fsSL https://raw.githubusercontent.com/ohmyzsh/ohmyzsh/master/tools/install.sh)" "" --unattended

echo "oh-my-zsh installed!"

# Install zsh plugins (zsh-autosuggestions, zsh-syntax-highlighting)
echo "Installing zsh plugins..."

git clone https://github.com/zsh-users/zsh-autosuggestions ${ZSH_CUSTOM:-$home_dir/.oh-my-zsh/custom}/plugins/zsh-autosuggestions
git clone https://github.com/zsh-users/zsh-syntax-highlighting.git ${ZSH_CUSTOM:-$home_dir/.oh-my-zsh/custom}/plugins/zsh-syntax-highlighting

echo "zsh plugins installed!"

# Install powerlevel10k
echo "Installing powerlevel10k..."

git clone --depth=1 https://github.com/romkatv/powerlevel10k.git "${ZSH_CUSTOM:-$home_dir/.oh-my-zsh/custom}/themes/powerlevel10k"

echo "powerlevel10k installed!"

# Install TPM
echo "Installing TPM..."

git clone https://github.com/tmux-plugins/tpm $home_dir/.tmux/plugins/tpm

echo "TPM installed!"

# Install Starship
echo "Installing Starship..."

curl -sS https://starship.rs/install.sh | sh -s -- --yes

echo "Starship installed!"

# Install yq
echo "Installing yq..."

wget https://github.com/mikefarah/yq/releases/latest/download/yq_linux_amd64 -O /usr/local/bin/yq
chmod +x /usr/local/bin/yq

echo "yq installed!"

# Install Visual Studio Code
echo "Installing VSCode..."

rpm --import https://packages.microsoft.com/keys/microsoft.asc
echo -e "[code]\nname=Visual Studio Code\nbaseurl=https://packages.microsoft.com/yumrepos/vscode\nenabled=1\nautorefresh=1\ntype=rpm-md\ngpgcheck=1\ngpgkey=https://packages.microsoft.com/keys/microsoft.asc" | tee /etc/yum.repos.d/vscode.repo >/dev/null

dnf check-update -y
dnf install -y code

echo "VSCode installed!"

# Install PostgreSQL
echo "Installing PostgreSQL 17..."

dnf install -y https://download.postgresql.org/pub/repos/yum/reporpms/F-43-x86_64/pgdg-fedora-repo-latest.noarch.rpm
dnf install -y postgresql17-server
/usr/pgsql-17/bin/postgresql-17-setup initdb
systemctl enable --now postgresql-17

echo "PostgreSQL 17 Installed!"

# Enabling Redis service
echo "Enabling Redis service..."

systemctl enable --now redis

echo "Redis service enabled!"

# Install Docker Engine
echo "Installing Docker Engine..."

dnf remove -y docker docker-client docker-client-latest docker-common docker-latest docker-latest-logrotate docker-logrotate docker-selinux docker-engine-selinux docker-engine
dnf config-manager -y addrepo --from-repofile https://download.docker.com/linux/fedora/docker-ce.repo
dnf install -y docker-ce docker-ce-cli containerd.io docker-buildx-plugin docker-compose-plugin
systemctl enable --now docker

echo "Docker Engine installed!"

# Pull essential development images
echo "Pulling Docker images..."

declare -a images=(
	mongo
	redis:8-alpine
	minio/minio
	postgres:18-alpine
)

for image in ${images[@]}; do
	docker pull $image
done

echo "Docker images pulled!"

# Install GitHub CLI
echo "Installing GitHub CLI..."

dnf config-manager -y addrepo --from-repofile=https://cli.github.com/packages/rpm/gh-cli.repo
dnf install -y gh --repo gh-cli

echo "GitHub CLI Installed!"

# Install Nerd Fonts
echo "Installing Nerd Fonts..."

declare -a fonts=(
	CascadiaCode
	CascadiaMono
	FiraCode
	FiraMono
	Hack
	JetBrainsMono
	Meslo
	Ubuntu
	UbuntuMono
)

version='3.4.0'
fonts_dir="$home_dir/.local/share/fonts"

if [[ ! -d "$fonts_dir" ]]; then
	mkdir -p "$fonts_dir"
fi

for font in "${fonts[@]}"; do
	zip_file="${font}.zip"
	download_url="https://github.com/ryanoasis/nerd-fonts/releases/download/v${version}/${zip_file}"
	echo "Downloading $font"
	wget "$download_url"
	unzip -o "$zip_file" -d "$fonts_dir"
	rm "$zip_file"
done

find "$fonts_dir" -name '*Windows Compatible*' -delete
fc-cache -fv

echo "Fonts installed!"

# Setting up dotfiles
echo "Cloning dotfiles..."

if [ ! -d "$home_dir/dotfiles" ]; then
	git clone https://github.com/Bibbeep/dotfiles.git $home_dir/dotfiles
fi

cd $home_dir/dotfiles || exit

echo "Stowing dotfiles..."
stow -t $home_dir tmux vim nvim git zsh

echo "dotfiles setup completed!"

# Sourcing .tmux.conf
echo "Sourcing dotfiles..."

source $home_dir/.tmux.conf
source $home_dir/.zshrc

echo "dotfiles sourced!"

# Logout
echo "Full setup is done! Logging out now..."
sleep 1
echo "5"
sleep 1
echo "4"
sleep 1
echo "3"
sleep 1
echo "2"
sleep 1
echo "1"
echo "Logging out..."

logout
