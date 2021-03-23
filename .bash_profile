#
# ~/.bash_profile
#

[[ -f ~/.bashrc ]] && . ~/.bashrc

# Set default programs
export EDITOR="nvim"
export TERMINAL="alacritty"
export BROWSER="qutebrowser"
export READER="zathura"
export FILE="lf"

# Add ~/.scripts to $PATH
PATH=$PATH$( find $HOME/.scripts/ -type d -printf ":%p" )

# Environment variables
export XDG_CONFIG_HOME="$HOME/.config"
export XDG_CONFIG_DIRS="/etc/xdg"
export XDG_DATA_HOME="$HOME/.local/share"
export XDG_CACHE_HOME="$HOME/.cache"
export GTK2_RC_FILES="${XDG_CONFIG_HOME:-$HOME/.config}/gtk-2.0/gtkrc-2.0"
export LESSHISTFILE="-"
export WGETRC="${XDG_CONFIG_HOME:-$HOME/.config}/wget/wgetrc"
export XAUTHORITY="$XDG_RUNTIME_DIR"/Xauthority
export XINITRC="$XDG_CONFIG_HOME"/X11/xinitrc
export GIT_CONFIG="$XDG_CONFIG_HOME"/git/config

# Pfetch environment variables
export PF_INFO="ascii os host kernel wm uptime pkgs memory"
export PF_ASCII="artix"
export PF_COL1="4"
export PF_COL2="8"
export PF_COL3="3"

# Start graphical server on tty1 on login
if [[ -z $DISPLAY ]] && [[ $(tty) = /dev/tty1 ]]; then exec startx; fi
