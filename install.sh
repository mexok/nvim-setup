#ssh-keygen -t ed25519 -C "konstantin@semerker.de"
apt update
apt install git
git config --global core.editor "nvim"
apt install tmux
apt install zsh
chsh -s $(which zsh)
apt install curl
sh -c "$(curl -fsSL https://raw.githubusercontent.com/ohmyzsh/ohmyzsh/master/tools/install.sh)"

git clone --depth 1 https://github.com/wbthomason/packer.nvim\
 ~/.local/share/nvim/site/pack/packer/start/packer.nvim
apt install ripgrep
apt install xsel
apt install rename

# Nodejs
curl -fsSL https://deb.nodesource.com/setup_20.x | bash - &&\
apt install -y nodejs

npm install -g typescript-language-server typescript
npm install vls -g

# go
apt install -y golang
go install github.com/go-delve/delve/cmd/dlv@latest

# Python
apt install -y python3-dev
apt install -y python3-pip
apt install -y python3-venv
apt install -y python3-debugpy
apt install -y python3-pytest

# C/C++
apt install -y clangd
apt install -y llvm
apt install -y llvm-lldb

# Docker
# see: https://docs.docker.com/engine/install/debian/
sudo groupadd docker
sudo usermod -aG docker $USER
# for refresh - or relog
newgrp docker
apt install docker-compose-plugin

# Terraform
sudo apt install gnupg software-properties-common

wget -O- https://apt.releases.hashicorp.com/gpg | \
gpg --dearmor | \
sudo tee /usr/share/keyrings/hashicorp-archive-keyring.gpg

echo "deb [signed-by=/usr/share/keyrings/hashicorp-archive-keyring.gpg] \
https://apt.releases.hashicorp.com $(lsb_release -cs) main" | \
sudo tee /etc/apt/sources.list.d/hashicorp.list

sudo apt update
sudo apt install terraform

touch ~/.zshrc
terraform -install-autocomplete

# Azure CLI
sudo apt update
sudo apt install ca-certificates curl apt-transport-https lsb-release gnupg
curl -sLS https://packages.microsoft.com/keys/microsoft.asc |
    gpg --dearmor |
    sudo tee /etc/apt/keyrings/microsoft.gpg > /dev/null
sudo chmod go+r /etc/apt/keyrings/microsoft.gpg

AZ_DIST=$(lsb_release -cs)
echo "deb [arch=`dpkg --print-architecture` signed-by=/etc/apt/keyrings/microsoft.gpg] https://packages.microsoft.com/repos/azure-cli/ $AZ_DIST main" |
    sudo tee /etc/apt/sources.list.d/azure-cli.list

sudo apt update
sudo apt install azure-cli

# upgrade all packages
sudo apt upgrade
