#
# ~/.bashrc
#

# If not running interactively, don't do anything
[[ $- != *i* ]] && return

# Change history file directory
export HISTFILE=$HOME/.cache/bash_history

# Disable case sensitivity
bind 'set completion-ignore-case on'

# Prompt
#PS1="$(if [[ ${EUID} == 0 ]]; then echo '\[\033[01;31m\]\h'; else echo '\[\033[01;32m\]'; fi)\[\033[01;34m\] \w \$([[ \$? != 0 ]] && echo \"\[\033[01;31m\]X\[\033[01;34m\] \")$\[\033[00m\] "
export PS1="\[$(tput bold)\]\[\033[38;5;148m\]\w\[$(tput sgr0)\] \[$(tput sgr0)\]\[$(tput bold)\]\[\033[38;5;220m\]\\$\[$(tput sgr0)\] \[$(tput sgr0)\]"

# Import aliases
source ~/.bash_aliases
