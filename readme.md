# Dotfiles

Cross-shell setup using **starship** (prompt) + **tmux** (terminal multiplexer).
Works in zsh, bash, and PowerShell.

## Prerequisites

Install a [Nerd Font](https://www.nerdfonts.com/font-downloads) and set it as your terminal font. FiraCode is recommended (the install scripts grab it automatically on Linux).

## Linux / macOS

```bash
cd ~ && git clone https://github.com/sevenfoxes/dotfiles
# Edit dotfiles/.gitconfig with your name and email
cd dotfiles && ./install.sh
```

Installs: starship, zsh, nvm, Node LTS, Claude Code, FiraCode Nerd Font.

## Windows

```powershell
git clone https://github.com/sevenfoxes/dotfiles
# Edit dotfiles/.gitconfig with your name and email
cd dotfiles && .\install.ps1  # run as administrator
```

Installs: starship, nvm for windows, git, Node LTS, Claude Code.

## PowerShell

Starship is wired up by `install.ps1`. If you need to add it manually:

```powershell
Add-Content $PROFILE "`nInvoke-Expression (&starship init powershell)"
```
