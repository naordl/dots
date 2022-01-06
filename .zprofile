# ~/.zprofile

# Default programs
export EDITOR="nvim"
export VISUAL="nvim"
export TERMINAL='"st" -g 125x25'
export BROWSER="brave"
export READER="zathura"
export FILE="ranger"
export PAGER="less"

# Add $HOME/.local/bin to $PATH
PATH=$PATH$( find -L $HOME/.local/bin -type d -printf ":%p" )

# Environment variables
export LC_COLLATE="C"
export XDG_CONFIG_HOME="$HOME/.config"
export XDG_CONFIG_DIRS="/etc/xdg"
export XDG_DATA_HOME="$HOME/.local/share"
export XDG_CACHE_HOME="$HOME/.cache"
export GTK2_RC_FILES="${XDG_CONFIG_HOME:-$HOME/.config}/gtk-2.0/gtkrc-2.0"
export LESSHISTFILE="-"
export WGETRC="${XDG_CONFIG_HOME:-$HOME/.config}/wget/wgetrc"
export XAUTHORITY="$XDG_CONFIG_HOME"/x11/xauthority
export ICEAUTHORITY="$XDG_CACHE_HOME"/ICEauthority
export XINITRC="$XDG_CONFIG_HOME"/x11/xinitrc
export XSERVERRC="$XDG_CONFIG_HOME"/x11/xserverrc
export GIT_CONFIG="$XDG_CONFIG_HOME"/git/config
export ZDOTDIR="${XDG_CONFIG_HOME:-$HOME/.config}/zsh"
export NOTMUCH_CONFIG="$XDG_CONFIG_HOME"/notmuch/notmuchrc
export NMBGIT="$XDG_DATA_HOME"/notmuch/nmbug
export MBSYNCRC="${XDG_CONFIG_HOME:-$HOME/.config}/mbsync/config"
export GNUPGHOME="$XDG_DATA_HOME"/gnupg
export PASSWORD_STORE_DIR="$XDG_DATA_HOME"/pass
export _JAVA_OPTIONS=-Djava.util.prefs.userRoot="$XDG_CONFIG_HOME"/java
export _JAVA_AWT_WM_NONREPARENTING=1
export SSB_HOME="$XDG_DATA_HOME"/zoom

# Start graphical server on tty1 on login
if [[ -z $DISPLAY ]] && [[ $(tty) = /dev/tty1 ]]; then exec startx "$XDG_CONFIG_HOME/x11/xinitrc" -- "$XDG_CONFIG_HOME/x11/xserverrc" vt1 &> /dev/null; fi
