#ssh-keygen -t ed25519 -C "konstantin@semerker.de"
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
apt install rename

# Nodejs
curl -fsSL https://deb.nodesource.com/setup_20.x | bash - &&\
apt install -y nodejs

npm install -g typescript-language-server typescript

# go
apt install -y golang
go install github.com/go-delve/delve/cmd/dlv@latest

# Python
apt install -y python3-dev
apt install -y python3-pip
apt install -y python3-venv

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
