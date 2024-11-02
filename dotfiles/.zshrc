########################
# Node
########################
export NVM_DIR="$HOME/.nvm"
[ -s "$NVM_DIR/nvm.sh" ] && \. "$NVM_DIR/nvm.sh"
[ -s "$NVM_DIR/bash_completion" ] && \. "$NVM_DIR/bash_completion"

########################
# Antigen
########################
source ~/antigen.zsh
source ~/.theme

antigen use oh-my-zsh
antigen bundle StackExchange/blackbox
antigen bundle brew
antigen bundle command-not-found
antigen bundle common-aliases
antigen bundle docker
antigen bundle docker-compose
antigen bundle git
antigen bundle golang
antigen bundle npm
antigen bundle nvm
antigen bundle lukechilds/zsh-nvm
antigen bundle python
antigen bundle tmux
antigen bundle laggardkernel/zsh-thefuck
antigen theme bhilburn/powerlevel9k powerlevel9k
antigen apply
