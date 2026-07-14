########################
# tmux
########################
if [[ -o interactive ]] && [[ -t 0 ]] && [[ -z "$TMUX" ]] \
  && [[ -z "$LEAN_CTX_AGENT$CLAUDECODE$CODEBUDDY$CODEX_CLI_SESSION$GEMINI_SESSION" ]]; then
  exec tmux new-session -A -s main
fi


########################
# Antigen
########################
source ~/antigen.zsh

antigen bundle brew
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
antigen apply

########################
# NVM
########################
export NVM_DIR="$HOME/.nvm"
[ -s "$NVM_DIR/nvm.sh" ] && source "$NVM_DIR/nvm.sh"
[ -s "$NVM_DIR/bash_completion" ] && source "$NVM_DIR/bash_completion"

########################
# ZSH
########################
autoload -Uz compinit && compinit

HISTSIZE=10000
SAVEHIST=10000
setopt HIST_IGNORE_DUPS HIST_IGNORE_SPACE SHARE_HISTORY

# System plugins (installed via package manager)
[[ -f /usr/share/zsh-autosuggestions/zsh-autosuggestions.zsh ]] && \
  source /usr/share/zsh-autosuggestions/zsh-autosuggestions.zsh
[[ -f /usr/share/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh ]] && \
  source /usr/share/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh

########################
# PATH
########################
export PATH="$HOME/.local/bin:$PATH"
eval "$(/home/linuxbrew/.linuxbrew/bin/brew shellenv zsh)"

########################
# Starship
########################
eval "$(starship init zsh)"
# lean-ctx shell hook — begin
if [ -f "/home/neshams/.config/lean-ctx/shell-hook.zsh" ]; then
. "/home/neshams/.config/lean-ctx/shell-hook.zsh"
fi
# lean-ctx shell hook — end

# >>> lean-ctx agent aliases >>>
alias claude='LEAN_CTX_AGENT=1 BASH_ENV="$HOME/.bashenv" claude'
alias codebuddy='LEAN_CTX_AGENT=1 BASH_ENV="$HOME/.bashenv" codebuddy'
alias codex='LEAN_CTX_AGENT=1 BASH_ENV="$HOME/.bashenv" codex'
alias gemini='LEAN_CTX_AGENT=1 BASH_ENV="$HOME/.bashenv" gemini'
# <<< lean-ctx agent aliases <<<

# >>> lean-ctx proxy env >>>
# ANTHROPIC_BASE_URL omitted: Claude Pro/Max subscription authenticates against api.anthropic.com directly (set ANTHROPIC_API_KEY to route Claude through the proxy)
export OPENAI_BASE_URL="http://127.0.0.1:4444/v1"
export GEMINI_API_BASE_URL="http://127.0.0.1:4444"
# <<< lean-ctx proxy env <<<

