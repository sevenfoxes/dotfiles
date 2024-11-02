# Dotfiles v2
## VER: Ubuntu WSL One step install

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

