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

unalias -a
alias cl="clear"
alias e="exit"
alias v="nvim"
alias vgd="nvim \`git status --porcelain | awk {'print \$2'}\`"
alias vgdm="nvim \`git ls-files -m | awk {'print \$1'}\`"
alias vz="nvim ~/.zshrc"
alias vs="cd ~/repos/nvim-setup && nvim"
alias dk="docker"
alias dkl="docker container list -a"
alias wdkl="watch docker container list -a"
alias dka="docker start"
alias dko="docker stop"
alias dkrem="docker remove"
alias dkc="docker compose"
alias dkf="docker compose logs -f"
alias dkr="docker compose down && docker compose up -d"
alias dku="docker compose up -d"
alias dkd="docker compose down"
alias dkp="docker compose pull"
alias dks="docker ps -q | xargs -r docker stop && docker ps -aq | xargs -r docker rm"
alias dkk="docker ps -q | xargs -r docker kill && docker ps -aq | xargs -r docker rm"
alias tx="tmux"
alias txa="tmux attach"
alias gs="git status"
alias ga="git add"
alias gal="git add ."
alias gb="git branch"
alias gba="git branch -ar"
alias gbd="git branch -d"
alias gbD="git branch -D"
alias gd="git diff"
alias gdc="git diff --cached"
alias go="git checkout"
alias gov="git checkout develop"
alias gom="git checkout master"
alias gob="git checkout -b"
alias gc="git commit --verbose"
alias gm="git merge"
alias gp="git pull"
alias gl="git log"
alias glg="git log --graph"
alias glog="git log --oneline --graph"
alias gr="git restore"

eval $(thefuck --alias y)
