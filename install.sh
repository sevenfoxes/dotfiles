#!/bin/bash
set -e

SCRIPT_DIR="$(cd "$(dirname "$0")" && pwd)"

IS_STEAM_DECK=false
if grep -qi "steamos" /etc/os-release 2>/dev/null; then
  IS_STEAM_DECK=true
fi

install_packages() {
  if command -v apt &>/dev/null; then
    sudo apt install -y "$@"
  elif command -v dnf &>/dev/null; then
    sudo dnf install -y --skip-unavailable "$@"
  elif command -v pacman &>/dev/null; then
    sudo pacman -S --needed --noconfirm "$@"
  else
    echo "Error: No supported package manager found (apt, dnf, or pacman)" >&2
    exit 1
  fi
}

if $IS_STEAM_DECK; then
  echo "Steam Deck detected — disabling read-only filesystem..."
  sudo steamos-readonly disable
fi

echo "Installing binaries..."
if command -v pacman &>/dev/null; then
  binaries=(
    curl
    unzip
    fontconfig
    zsh
    git
    zsh-autosuggestions
    zsh-syntax-highlighting
  )
else
  binaries=(
    curl
    unzip
    fontconfig
    zsh
    git-gui
    zsh-autosuggestions
    zsh-syntax-highlighting
  )
fi

install_packages "${binaries[@]}"

echo "Symlinking dotfiles..."
for file in "$SCRIPT_DIR"/dotfiles/.*; do
  name="$(basename "$file")"
  [[ "$name" == "." || "$name" == ".." || "$name" == ".git" ]] && continue

  if [[ "$name" == ".config" ]]; then
    # Symlink each item under .config individually to avoid clobbering ~/.config
    mkdir -p "$HOME/.config"
    for item in "$file"/*; do
      item_name="$(basename "$item")"
      echo "  .config/$item_name -> ~/.config/$item_name"
      ln -sf "$item" "$HOME/.config/$item_name"
    done
  else
    echo "  $name -> ~/$name"
    ln -sf "$file" ~/
  fi
done

echo "Installing nvm (latest)..."
if [[ ! -d "$HOME/.nvm" ]]; then
  NVM_LATEST="$(curl -fsSL https://api.github.com/repos/nvm-sh/nvm/releases/latest | grep '"tag_name"' | sed -E 's/.*"([^"]+)".*/\1/')"
  echo "  version: $NVM_LATEST"
  curl -fsSL "https://raw.githubusercontent.com/nvm-sh/nvm/${NVM_LATEST}/install.sh" | bash
else
  echo "  already installed, skipping"
fi

echo "Installing Node.js LTS..."
export NVM_DIR="$HOME/.nvm"
# shellcheck source=/dev/null
source "$NVM_DIR/nvm.sh"
if ! nvm ls default &>/dev/null || [[ "$(nvm alias default 2>/dev/null)" == *"N/A"* ]]; then
  nvm install --lts
  nvm alias default node
else
  echo "  already installed, skipping"
fi

echo "Installing Claude Code..."
if ! npm list -g @anthropic-ai/claude-code &>/dev/null; then
  npm install -g @anthropic-ai/claude-code
else
  echo "  already installed, skipping"
fi

echo "Installing starship..."
if ! command -v starship &>/dev/null; then
  curl -sS https://starship.rs/install.sh | sh -s -- --yes
else
  echo "  already installed, skipping"
fi

echo "Installing vim-plug..."
if [[ ! -f ~/.vim/autoload/plug.vim ]]; then
  curl -fsSLo ~/.vim/autoload/plug.vim --create-dirs \
    https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim
else
  echo "  already installed, skipping"
fi

echo "Installing FiraCode Mono Nerd Font..."
FONT_DIR="${HOME}/.local/share/fonts"
if ! ls "$FONT_DIR"/FiraCodeNerdFontMono* &>/dev/null; then
  mkdir -p "$FONT_DIR"
  NERD_FONTS_LATEST="$(curl -fsSL https://api.github.com/repos/ryanoasis/nerd-fonts/releases/latest | grep '"tag_name"' | sed -E 's/.*"([^"]+)".*/\1/')"
  echo "  version: $NERD_FONTS_LATEST"
  curl -fsSL "https://github.com/ryanoasis/nerd-fonts/releases/download/${NERD_FONTS_LATEST}/FiraCode.zip" -o /tmp/FiraCode.zip
  unzip -o /tmp/FiraCode.zip -d "$FONT_DIR" "FiraCodeNerdFontMono*"
  rm -f /tmp/FiraCode.zip
  fc-cache -f "$FONT_DIR"
else
  echo "  already installed, skipping"
fi

echo "Switching to zsh..."
if [[ "$SHELL" != "$(which zsh)" ]]; then
  sudo usermod --shell "$(which zsh)" "$USER"
else
  echo "  already using zsh, skipping"
fi

echo ""
echo "Done! Restart your terminal to apply all changes."
echo ""
echo "PowerShell: add this to your profile (\$PROFILE):"
echo "  Invoke-Expression (&starship init powershell)"
