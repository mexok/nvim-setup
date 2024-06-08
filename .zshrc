plugins=(git zsh-syntax-highlighting zsh-autosuggestions docker docker-compose)

source $ZSH/oh-my-zsh.sh
source <(kubectl completion zsh)

bindkey '^[k' history-beginning-search-backward
bindkey '^[j' history-beginning-search-forward
bindkey '^[h' backward-word
bindkey '^[l' forward-word
bindkey '^[f' accept-line

export LUA_PATH=~/.config/nvim/?.lua
export GOPATH="$HOME/go"
export PATH="$PATH:/opt/nvim-linux64/bin:$GOPATH/bin:$HOME/.local/share/nvim/mason/bin"

alias cl="clear"
alias e="exit"
alias nvimgd="nvim \`git status --porcelain | awk {'print \$2'}\`"
alias dk="docker"
alias dkl="docker container list -a"
alias wdkl="watch docker container list -a"
alias dksta="docker start"
alias dksto="docker stop"
alias dkrem="docker remove"
alias dkc="docker compose"
alias dkr="docker compose down && docker compose up -d"
alias dku="docker compose up -d"
alias dkd="docker compose down"
alias dkp="docker compose pull"
alias dks="docker ps -q | xargs -r docker stop && docker ps -aq | xargs -r docker rm"
alias dkk="docker ps -q | xargs -r docker kill && docker ps -aq | xargs -r docker rm"
alias tx="tmux"
alias txa="tmux attach"
alias gs="git status"
alias gia="git add"
alias gib="git branch"
alias gis="git checkout"
alias gic="git commit"
alias gim="git merge"
alias gip="git pull"
alias gir="git restore"

eval $(thefuck --alias y)
