# ~/.config/zsh/.zshrc

# prompt
PROMPT="%F{red}[%f%B%F{3}%n%f%b%F{10}@%f%F{14}%m%f %F{13}%~%f%F{red}]%f$ "
unsetopt prompt_cr prompt_sp

# case insensitivity
zstyle ':completion:*' matcher-list 'm:{a-zA-Z}={A-Za-z}'
setopt MENU_COMPLETE

# complete aliases
unsetopt complete_aliases

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

# purge the ~/.pki folder (and others)
[ -f ~/.pki ] || rm -rf ~/.pki
[ -f ~/.icons ] || rm -rf ~/.icons
[ -f ~/.java ] || rm -rf ~/.java
[ -f ~/.zoom ] || rm -rf ~/.zoom
[ -f ~/.mono ] || rm -rf ~/.mono
[ -f ~/.ssh ] || rm -rf ~/.ssh

# startx
alias startx="startx ~/.config/X11/xinitrc"

# functions
# es - edit scripts and config files using fzf
es() { du -a ~/.local/bin/* ~/.config/* | awk '{print $2}' | fzf | xargs -r $EDITOR ;}

# aliases
alias pac='sudo pacman'
alias ls='ls -hN --color=auto --group-directories-first'
alias ll='exa -lh --color=auto --group-directories-first'
alias grep='grep --color=auto'
alias diff='diff --color=auto'
alias cp='cp -r'
alias rm='rm -r'
alias mkd='mkdir -p'
alias smkd='sudo mkdir -p'
alias r='ranger'
alias sr='sudo ranger'
alias v='nvim'
alias sv='sudo nvim'
alias vi='nvim'
alias vim='nvim'
alias ex="extract $1"
alias cal='cal -m'
alias ytmusic='youtube-dl -i -o "~/Music/%(title)s.%(ext)s" -x --audio-format mp3'
alias gengrub="sudo grub-mkconfig -o /boot/grub/grub.cfg"
alias mi="cp -v config.def.h config.h; sudo make clean install"
alias gacp="git add .; git commit -m 'yes'; git push"
alias mntfs="sudo mount -t ntfs"
alias mfat32="sudo mount -o gid=users,fmask=113,dmask=002"
alias umnt="sync; sudo umount"
alias td="$EDITOR ~/Documents/todo.md"

# shortcuts
alias gh="cd"
alias gc="cd ~/.config/"
alias gs="cd ~/.local/bin/"
alias gdt="cd ~/.local/dots/"
alias gu="cd ~/Documents/Uni/"
alias gdc="cd ~/Documents/"
alias gdw="cd ~/Downloads/"
alias gms="cd ~/Music/"
alias gpc="cd ~/Pictures/"
alias gvd="cd ~/Videos/"
alias gmnt="cd /mnt/"
alias gw="cd /mnt/windows/Users/Roli/"
