# ~/.config/zsh/.zshrc

# prompt
PROMPT="%F{red}[%f%B%F{3}%n%f%b%F{10}@%f%F{14}%m%f %F{13}%~%f%F{red}]%f$ "
unsetopt prompt_cr prompt_sp

# case insensitivity
zstyle ':completion:*' matcher-list 'm:{a-zA-Z}={A-Za-z}'
setopt MENU_COMPLETE

# enable autocd
setopt autocd

# disable ctrl+s
stty stop undef

# history
HISTSIZE=10000
SAVEHIST=10000
HISTFILE=~/.cache/zsh_history

# ctrl + backspace kill previous word
bindkey '^H' backward-kill-word

# autocompletion
autoload -Uz compinit
zmodload zsh/complist
compinit
zstyle ':completion:*' menu select
setopt COMPLETE_ALIASES
zstyle ':completion::complete:*' gain-privileges 1
_comp_options+=(globdots)

# vi mode
bindkey -v
export KEYTIMEOUT=1

# use vim keys in tab complete menu
bindkey -M menuselect 'h' vi-backward-char
bindkey -M menuselect 'k' vi-up-line-or-history
bindkey -M menuselect 'l' vi-forward-char
bindkey -M menuselect 'j' vi-down-line-or-history
bindkey -v '^?' backward-delete-char

# change cursor shape for different vi modes
function zle-keymap-select () {
    case $KEYMAP in
        vicmd) echo -ne '\e[1 q';;      # block
        viins|main) echo -ne '\e[5 q';; # beam
    esac
}
zle -N zle-keymap-select
zle-line-init() {
    zle -K viins # initiate `vi insert` as keymap (can be removed if `bindkey -V` has been set elsewhere)
    echo -ne "\e[5 q"
}
zle -N zle-line-init
echo -ne '\e[5 q' # use beam shape cursor on startup
preexec() { echo -ne '\e[5 q' ;} # use beam shape cursor for each new prompt

# purge the useless god forsaken ~/.pki file (and others)
[ -f ~/.pki ] || rm -rf ~/.pki
[ -f ~/.icons ] || rm -rf ~/.icons

# startx
alias startx="startx ~.config/X11/xinitrc"

# fzf scripts
# edit scripts and config files
es() { du -a ~/.local/bin/* ~/.config/* | awk '{print $2}' | fzf | xargs -r $EDITOR ;}

# aliases
alias ..='cd ..'
alias ...='cd ../..'
alias ls='ls --color=auto --group-directories-first -A'
alias ll='exa -lah --color=auto --group-directories-first'
alias grep='grep --color=auto'
alias diff='diff --color=auto'
alias cp='cp -r'
alias rm='rm -r'
alias pac='sudo pacman'
alias mkd='mkdir -p'
alias smkd='sudo mkdir -p'
alias r='ranger'
alias sr='sudo ranger'
alias vim='nvim'
alias v='nvim'
alias sv='sudo nvim'
alias cal='cal -m'
alias ytmusic='youtube-dl -i -o "~/mus/%(title)s.%(ext)s" -x --audio-format mp3'
alias gengrub="sudo grub-mkconfig -o /boot/grub/grub.cfg"
alias mi="cp -v config.def.h config.h; sudo make clean install"
alias mntfs="sudo mount -t ntfs"
alias d="cd ~/.local/dots"
alias n="ncmpcpp"

# cd and ls at the same time
chpwd() ls
