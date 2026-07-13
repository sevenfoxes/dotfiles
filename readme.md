# Dotfiles v2
## VER: Ubuntu WSL One step install + Windows psmux

Install and run one of these fonts and set it as the default in windows terminal. Fira is recommended.
[nerdFont downloads](https://www.nerdfonts.com/font-downloads)

### OPTIONAL: set colors in shell with ghostwheel-classic.ts
### OPTIONAL: install x window server: `https://sourceforge.net/projects/vcxsrv/`

start x-server: windows run > `C:\Program Files\VcXsrv\xlaunch.exe -run config.xlaunch` to start without configuration

# Install


`sudo apt upgrade`

`sudo apt update`

> [reload session]

`cd ~ && git clone https://github.com/sevenfoxes/dotfiles`

`code ./dotfiles`

> edit `dotfiles/.gitconfig` with your username and email. optionally add/delete any config files you don't want to overwrite

`cd ~ && ./dotfiles/install.sh`

## Windows: psmux

psmux is a native Windows tmux alternative that reads `~/.psmux.conf`.

1. Install psmux via winget: `winget install marlocarlo.psmux`
2. Install a Nerd Font (Fira recommended, see link above) and set it as the default in Windows Terminal
3. Copy or symlink `dotfiles/.psmux.conf` to `C:\Users\<you>\.psmux.conf`
   - From Git Bash: `cp ~/dotfiles/dotfiles/.psmux.conf ~/.psmux.conf`
   - Or the install.sh loop symlinks it automatically when run from WSL
4. Run `psmux` — keybindings mirror `.tmux.conf` (prefix is `Ctrl+Space`)

Notes:
- `.psmux.conf` is a plugin-free version of `.tmux.conf` (no TPM/resurrect/continuum)
- `prefix + r` reloads the config in-session
- The `TMUX` env var is set inside psmux panes, so tmux-aware tools work normally

