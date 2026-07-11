########################
# NVM
########################
export NVM_DIR="$HOME/.nvm"
[ -s "$NVM_DIR/nvm.sh" ] && source "$NVM_DIR/nvm.sh"
[ -s "$NVM_DIR/bash_completion" ] && source "$NVM_DIR/bash_completion"

########################
# PATH
########################
export PATH="$HOME/.local/bin:$PATH"

########################
# Starship
########################
eval "$(starship init bash)"
