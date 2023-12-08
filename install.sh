#ssh-keygen -t ed25519 -C "konstantin@semerker.de"
sudo apt update
sudo apt install -y wget

# nvim
sudo wget -o /opt/nvim-linux64.tar.gz https://github.com/neovim/neovim/releases/latest/download/nvim-linux64.tar.gz
tar -zxf /opt/nvim-linux64.tar.gz
ln -s /opt/nvim-linux64/bin/nvim /usr/local/bin/nvim

mkdir -p "$HOME/.config/nvim"
rm $HOME/.config/nvim/*.lua 2>/dev/null

for f in ".config/nvim"/*.lua
do
    ln -s "$cwd/$f" "$HOME/$f"
done

# git
sudo apt install -y git
git config --global core.editor "nvim"

# tmux and zsh
sudo apt install -y tmux
sudo apt install -y zsh
chsh -s $(which zsh)
sudo apt install -y curl
sh -c "$(curl -fsSL https://raw.githubusercontent.com/ohmyzsh/ohmyzsh/master/tools/install.sh)"

rm $HOME/.tmux.conf
ln -s ./.tmux.conf "$HOME/.tmux.conf"

# Other CLI
sudo apt install -y ripgrep
sudo apt install -y xsel
sudo apt install -y rename

# Nodejs
curl -fsSL https://deb.nodesource.com/setup_20.x | bash - &&\
sudo apt install -y nodejs

npm install -g typescript-language-server typescript
npm install vls -g

# go
sudo apt install -y golang
go install github.com/go-delve/delve/cmd/dlv@latest

# Python
sudo apt install -y python3-dev
sudo apt install -y python3-pip
sudo apt install -y python3-venv
sudo apt install -y python3-debugpy
sudo apt install -y python3-pytest

# C/C++
sudo apt install -y clangd
sudo apt install -y llvm
sudo apt install -y llvm-lldb

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

sudo apt install -y default-jdk

# upgrade all packages
sudo apt upgrade

echo "Please update .zshrc manually."
