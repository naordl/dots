#
# .zprofile
#

# Set default programs
export EDITOR="nvim"
export VISUAL="nvim"
export TERMINAL="alacritty"
export BROWSER="qutebrowser"
export ALTBROWSER="brave"
export READER="zathura"
export FILE="ranger"

# Add ~/.local/bin/ to $PATH
PATH=$PATH$( find $HOME/.local/bin/ -type d -printf ":%p" )

# Environment variables
export XDG_CONFIG_HOME="$HOME/.config"
export XDG_CONFIG_DIRS="/etc/xdg"
export XDG_DATA_HOME="$HOME/.local/share"
export XDG_CACHE_HOME="$HOME/.cache"
export GTK2_RC_FILES="${XDG_CONFIG_HOME:-$HOME/.config}/gtk-2.0/gtkrc-2.0"
export LESSHISTFILE="-"
export WGETRC="${XDG_CONFIG_HOME:-$HOME/.config}/wget/wgetrc"
#export XAUTHORITY="$XDG_RUNTIME_DIR"/Xauthority
export XAUTHORITY="$XDG_CONFIG_HOME"/X11/Xauthority
export XINITRC="$XDG_CONFIG_HOME"/X11/xinitrc
export GIT_CONFIG="$XDG_CONFIG_HOME"/git/config
export ZDOTDIR="${XDG_CONFIG_HOME:-$HOME/.config}/zsh"

# Start graphical server on tty1 on login
if [[ -z $DISPLAY ]] && [[ $(tty) = /dev/tty1 ]]; then exec startx ~/.config/X11/xinitrc &> /dev/null; fi
