# ~/.config/zsh/.zshrc

# prompt
PROMPT="%F{red}[%f%B%F{3}%n%f%b%F{10}@%f%F{14}%m%f %F{13}%~%f%F{red}]%f$ "
unsetopt prompt_cr prompt_sp

# case insensitivity
zstyle ':completion:*' matcher-list 'm:{a-zA-Z}={A-Za-z}'
setopt MENU_COMPLETE

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

# purge the useless god forsaken ~/.pki file (and others)
[ -f ~/.pki ] || rm -rf ~/.pki
[ -f ~/.icons ] || rm -rf ~/.icons
[ -f ~/.java ] || rm -rf ~/.java
[ -f ~/.zoom ] || rm -rf ~/.zoom
[ -f ~/.mono ] || rm -rf ~/.mono

# startx
alias startx="startx ~/.config/X11/xinitrc"

# fzf scripts
# es - edit scripts and config files
es() { du -a ~/.local/bin/* ~/.config/* | awk '{print $2}' | fzf | xargs -r $EDITOR ;}
# ranger_cd - cd with ranger
ranger_cd() {
    temp_file="$(mktemp -t "ranger_cd.XXXXXXXXXX")"
    ranger --choosedir="$temp_file" -- "${@:-$PWD}"
    if chosen_dir="$(cat -- "$temp_file")" && [ -n "$chosen_dir" ] && [ "$chosen_dir" != "$PWD" ]; then
        cd -- "$chosen_dir"
    fi
    rm -f -- "$temp_file"
}

# aliases
alias pac='sudo pacman'
alias ls='ls --color=auto --group-directories-first -A'
alias ll='exa -lah --color=auto --group-directories-first'
alias grep='grep --color=auto'
alias diff='diff --color=auto'
alias cp='cp -r'
alias rm='rm -r'
alias mkd='mkdir -p'
alias smkd='sudo mkdir -p'
alias r='ranger_cd'
alias sr='sudo ranger'
alias v='nvim'
alias sv='sudo nvim'
alias vi='nvim'
alias vim='nvim'
alias xx="extract $1"
alias cal='cal -m'
alias ytmusic='youtube-dl -i -o "~/mus/%(title)s.%(ext)s" -x --audio-format mp3'
alias gengrub="sudo grub-mkconfig -o /boot/grub/grub.cfg"
alias mi="cp -v config.def.h config.h; sudo make clean install"
alias gacp="git add .; git commit -m 'yes'; git push"
alias mntfs="sudo mount -t ntfs"

# shortcuts
alias gh="cd ~"
alias gc="cd ~/.config/"
alias gs="cd ~/.local/bin/"
alias gdc="cd ~/doc/"
alias gdw="cd ~/dow/"
alias gms="cd ~/mus/"
alias gpc="cd ~/pic/"
alias gvd="cd ~/vid/"
alias gdt="cd ~/.local/dots/"
alias gu="cd ~/doc/Uni"
alias gw="cd /mnt/windows/Users/Roli/Desktop"

# cd and ls simultaneously
chpwd() ls
