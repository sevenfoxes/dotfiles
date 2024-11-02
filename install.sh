#!/bin/bash

echo "installing binaries..."
binaries=(
  zsh
  tmux
  git-gui
)

sudo apt install ${binaries[@]}

echo "Copying Dotfiles..."
for i in $(ls -A $PWD/dotfiles/); do
  echo $PWD/dotfiles/$i
  if [ "$i" != ".git" ]; then
    ln -sf "$PWD/dotfiles/$i" ~/
  fi
done

echo "installing antigen..."
curl -L git.io/antigen > antigen.zsh

# hack for broken docker plugin
mkdir ~/.antigen/bundles/robbyrussell/oh-my-zsh/cache/completions

echo "switching to zsh..."
chsh -s $(which zsh)
