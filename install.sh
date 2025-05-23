#ssh-keygen -t ed25519 -C "konstantin@semerker.de"

sudo apt update
sudo apt install -y wget

# git + repo
sudo apt install -y git
sudo apt install -y git-flow
git config --global user.name "mexok"
git config --global user.email "konstantin@semerker.de"
git config --global help.autocorrect prompt

mkdir ~/internal
cd ~/internal
git clone git@github.com:mexok/nvim-setup.git
cd nvim-setup

# nvim
sudo wget -O /opt/nvim-linux64.tar.gz https://github.com/neovim/neovim/releases/download/v0.11.0/nvim-linux-x86_64.tar.gz
sudo tar -zxf /opt/nvim-linux64.tar.gz -C /opt
sudo ln -s /opt/nvim-linux64/bin/nvim /usr/local/bin/nvim

mkdir -p "$HOME/.config/nvim/ftplugin"
mkdir -p "$HOME/.config/nvim-search"
rm $HOME/.config/nvim/*.lua 2>/dev/null

for f in ".config/nvim"/*.lua
do
    ln -s "$PWD/$f" "$HOME/$f"
done
ln -s "$PWD/.config/nvim/ftplugin/java.lua" "$HOME/.config/nvim/ftplugin/java.lua"

ln -s "$PWD/.config/nvim-search/init.lua" "$HOME/.config/nvim-search/init.lua"

git config --global core.editor "nvim"

# tmux and zsh
sudo apt install -y tmux
sudo apt install -y zsh
chsh -s $(which zsh)
sudo apt install -y curl
sh -c "$(curl -fsSL https://raw.githubusercontent.com/ohmyzsh/ohmyzsh/master/tools/install.sh)"
git clone https://github.com/zsh-users/zsh-autosuggestions ${ZSH_CUSTOM:-~/.oh-my-zsh/custom}/plugins/zsh-autosuggestions
git clone https://github.com/zsh-users/zsh-syntax-highlighting.git ${ZSH_CUSTOM:-~/.oh-my-zsh/custom}/plugins/zsh-syntax-highlighting

rm $HOME/.tmux.conf
ln -s ~/internal/nvim-setup/.tmux.conf "$HOME/.tmux.conf"

# zellij
# Install manually
mkdir -p "$HOME/.config/zellij/layouts"
ln -s ~/internal/nvim-setup/config.kdl "$HOME/.config/zellij/config.kdl"
ln -s ~/internal/nvim-setup/mylayout.kdl "$HOME/.config/zellij/layouts/mylayout.kdl"
ln -s ~/internal/nvim-setup/mylayout.swap.kdl "$HOME/.config/zellij/layouts/mylayout.swap.kdl"

# ghostty
# Manual install from: https://github.com/mkasberg/ghostty-ubuntu
mkdir -p "$HOME/.config/ghostty"
ln -s ~/internal/nvim-setup/config-ghostty "$HOME/.config/ghostty/config"

# zsh
ln -s ~/internal/nvim-setup/.zshrc.setup "$HOME/.zshrc.setup"

# Other CLI
sudo apt install -y ripgrep
sudo apt install -y xsel
sudo apt install -y rename
sudo apt install -y thefuck
sudo apt install -y libnotify-bin
sudo apt install -y xclip
sudo apt remove -y ghostscript

# Nodejs
sudo apt install -y ca-certificates curl gnupg
sudo mkdir -p /etc/apt/keyrings
curl -fsSL https://deb.nodesource.com/gpgkey/nodesource-repo.gpg.key | sudo gpg --dearmor -o /etc/apt/keyrings/nodesource.gpg
echo "deb [signed-by=/etc/apt/keyrings/nodesource.gpg] https://deb.nodesource.com/node_20.x nodistro main" | sudo tee /etc/apt/sources.list.d/nodesource.list
sudo apt update
sudo apt install -y nodejs

# Typescript
sudo npm install -g typescript-language-server typescript
sudo npm install vls -g

# Golang
# Install manually
go install github.com/go-delve/delve/cmd/dlv@latest
go install golang.org/x/tools/gopls@latest

# Python
sudo apt install -y python3-dev
sudo apt install -y python3-pip
sudo apt install -y python3-venv
sudo apt install -y python3-debugpy
sudo apt install -y python3-pytest

# C/C++
sudo apt install -y clangd
sudo apt install -y llvm

# Docker
# see: https://docs.docker.com/engine/install/debian/
sudo groupadd docker
sudo usermod -aG docker $USER
# for refresh - or relog
newgrp docker
sudo apt install -y docker-compose-plugin

# Terraform
sudo apt install gnupg software-properties-common

wget -O- https://apt.releases.hashicorp.com/gpg | \
gpg --dearmor | \
sudo tee /usr/share/keyrings/hashicorp-archive-keyring.gpg

echo "deb [signed-by=/usr/share/keyrings/hashicorp-archive-keyring.gpg] \
https://apt.releases.hashicorp.com $(lsb_release -cs) main" | \
sudo tee /etc/apt/sources.list.d/hashicorp.list

sudo apt update
sudo apt install -y terraform

touch ~/.zshrc
terraform -install-autocomplete

# Azure CLI
sudo apt update
sudo apt install -y ca-certificates curl apt-transport-https lsb-release gnupg
curl -sLS https://packages.microsoft.com/keys/microsoft.asc |
    gpg --dearmor |
    sudo tee /etc/apt/keyrings/microsoft.gpg > /dev/null
sudo chmod go+r /etc/apt/keyrings/microsoft.gpg

AZ_DIST=$(lsb_release -cs)
echo "deb [arch=`dpkg --print-architecture` signed-by=/etc/apt/keyrings/microsoft.gpg] https://packages.microsoft.com/repos/azure-cli/ $AZ_DIST main" |
    sudo tee /etc/apt/sources.list.d/azure-cli.list

sudo apt update
sudo apt install -y azure-cli

# Kubernetes CLI
sudo apt update
sudo apt install -y apt-transport-https ca-certificates curl

curl -fsSL https://pkgs.k8s.io/core:/stable:/v1.28/deb/Release.key | sudo gpg --dearmor -o /etc/apt/keyrings/kubernetes-apt-keyring.gpg

echo 'deb [signed-by=/etc/apt/keyrings/kubernetes-apt-keyring.gpg] https://pkgs.k8s.io/core:/stable:/v1.28/deb/ /' | sudo tee /etc/apt/sources.list.d/kubernetes.list

sudo apt update
sudo apt install -y kubectl

# Install HELM
curl https://baltocdn.com/helm/signing.asc | gpg --dearmor | sudo tee /usr/share/keyrings/helm.gpg > /dev/null
sudo apt install -y apt-transport-https
echo "deb [arch=$(dpkg --print-architecture) signed-by=/usr/share/keyrings/helm.gpg] https://baltocdn.com/helm/stable/debian/ all main" | sudo tee /etc/apt/sources.list.d/helm-stable-debian.list
sudo apt update
sudo apt install -y helm

# Install java for pyspark
# Install manually

# upgrade all packages
sudo apt upgrade

echo "Please update .zshrc manually."
