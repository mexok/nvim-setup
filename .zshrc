plugins=(git zsh-syntax-highlighting zsh-autosuggestions docker docker-compose)

source $ZSH/oh-my-zsh.sh

bindkey '^[k' history-beginning-search-backward
bindkey '^[j' history-beginning-search-forward
bindkey '^[h' backward-word
bindkey '^[l' forward-word
bindkey '^[f' accept-line

export LUA_PATH=~/.config/nvim/?.lua

