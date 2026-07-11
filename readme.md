# Dotfiles

Cross-shell setup using **starship** (prompt) + **ghostty/winghostty** (terminal).
Works in zsh, bash, and PowerShell.

## Prerequisites

Install a [Nerd Font](https://www.nerdfonts.com/font-downloads) and set it as your terminal font. FiraCode is recommended (the install scripts grab it automatically on Linux).

## Linux / macOS

```bash
cd ~ && git clone https://github.com/sevenfoxes/dotfiles
# Edit dotfiles/.gitconfig with your name and email
cd dotfiles && ./install.sh
```

Installs: ghostty, starship, zsh, nvm, Node LTS, Claude Code, FiraCode Nerd Font.

## Windows

```powershell
git clone https://github.com/sevenfoxes/dotfiles
# Edit dotfiles/.gitconfig with your name and email
cd dotfiles && .\install.ps1  # run as administrator
```

Installs: winghostty, starship, nvm for windows, git, Node LTS, Claude Code.

> **TODO (test Monday):** The winghostty config path is assumed to be `%APPDATA%\ghostty\config`
> but this hasn't been verified yet. Run `winghostty --config-path` on first launch to confirm,
> then update the symlink in `install.ps1` if the path is different.

## Keybindings (ghostty / winghostty)

Leader key: `ctrl+space`

| Chord | Action |
|---|---|
| `ctrl+space > \|` | split right |
| `ctrl+space > -` | split down |
| `ctrl+space > h/j/k/l` | navigate splits |
| `ctrl+space > z` | zoom pane |
| `ctrl+space > c` | new tab |
| `ctrl+space > n / p` | next / prev tab |
| `ctrl+space > 1-9` | jump to tab |
| `ctrl+space > r` | reload config |
| `ctrl+space > ctrl+space` | pass ctrl+space through |

## PowerShell

Starship is wired up by `install.ps1`. If you need to add it manually:

```powershell
Add-Content $PROFILE "`nInvoke-Expression (&starship init powershell)"
```
