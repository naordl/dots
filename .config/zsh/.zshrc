# ~/.config/zsh/.zshrc

# Prompt
PROMPT="%F{red}[%f%B%F{3}%n%f%b%F{10}@%f%F{14}%m%f %F{13}%~%f%F{red}]%f$ "
unsetopt prompt_cr prompt_sp

# Case insensitivity
zstyle ':completion:*' matcher-list 'm:{a-zA-Z}={A-Za-z}'
setopt MENU_COMPLETE

# Complete aliases
unsetopt complete_aliases

# Disable Ctrl+s
stty stop undef

# History
HISTSIZE=10000
SAVEHIST=10000
HISTFILE=~/.cache/zsh_history

# Ctrl + backspace kill previous word
bindkey '^H' backward-kill-word

# Autocompletion
autoload -Uz compinit
zmodload zsh/complist
compinit
zstyle ':completion:*' menu select
setopt COMPLETE_ALIASES
zstyle ':completion::complete:*' gain-privileges 1
_comp_options+=(globdots)

# Vi mode
bindkey -v
export KEYTIMEOUT=1

# Use vim keys in tab complete menu
bindkey -M menuselect 'h' vi-backward-char
bindkey -M menuselect 'k' vi-up-line-or-history
bindkey -M menuselect 'l' vi-forward-char
bindkey -M menuselect 'j' vi-down-line-or-history
bindkey -v '^?' backward-delete-char

# Change cursor shape for different vi modes
function zle-keymap-select () {
    case $KEYMAP in
        vicmd) echo -ne '\e[1 q';;      # block
        viins|main) echo -ne '\e[5 q';; # beam
    esac
}
zle -N zle-keymap-select
zle-line-init() {
    zle -K viins # Initiate `vi insert` as keymap (can be removed if `bindkey -V` has been set elsewhere)
    echo -ne "\e[5 q"
}
zle -N zle-line-init
echo -ne '\e[5 q' # Use beam shape cursor on startup
preexec() { echo -ne '\e[5 q' ;} # Use beam shape cursor for each new prompt

# Delete junk
[ -f ~/.pki ] || rm -rf ~/.pki
[ -f ~/.icons ] || rm -rf ~/.icons
[ -f ~/.java ] || rm -rf ~/.java
[ -f ~/.zoom ] || rm -rf ~/.zoom
[ -f ~/.mono ] || rm -rf ~/.mono
[ -f ~/.ssh ] || rm -rf ~/.ssh
[ -f ~/.bash_history ] || rm -rf ~/.bash_history

# Startx
alias startx='startx "$XDG_CONFIG_HOME/x11/xinitrc" -- "$XDG_CONFIG_HOME/x11/xserverrc" vt1'

# Functions
# es - edit scripts and config files using fzf
es() { du -a ~/.local/bin/* ~/.config/* ~/Repos/{dmenu,st,dwm,dwmblocks} | awk '{print $2}' | fzf --height=50% | xargs -r $EDITOR ;}

# Aliases
alias pac='sudo pacman'
alias ls='ls -hN --color=auto --group-directories-first'
alias ll='exa -lh --color=auto --group-directories-first'
alias la='exa -lah --color=auto --group-directories-first'
alias grep='grep --color=auto'
alias diff='diff --color=auto'
alias cp='cp -rv'
alias rm='rm -rv'
alias mkd='mkdir -pv'
alias v='nvim'
alias sv='sudo nvim'
alias r='ranger'
alias sr='sudo ranger'
alias cal='cal -m'
alias ytmusic='youtube-dl -i -o "~/Music/%(title)s.%(ext)s" -x --audio-format mp3'
alias ytaudio='youtube-dl -i -f bestaudio'
alias yt720p='youtube-dl -i -f 22'
alias gengrub='sudo grub-mkconfig -o /boot/grub/grub.cfg'
alias refresh='sudo reflector --verbose --latest 5 --sort rate --save /etc/pacman.d/mirrorlist'
alias gacp='git add . && git commit -m 'Autocommit.' && git push'
alias mntfs='sudo mount -t ntfs'
alias mfat32='sudo mount -o gid=users,fmask=113,dmask=002'
alias umnt='sync; sudo umount'
alias td='$EDITOR ~/Documents/todo.md'
alias pt='sudo powertop'
alias webcam='mpv  --profile=low-latency --untimed /dev/video0'
# alias webcam='mpv --profile=low-latency --untimed -v av://v4l2:/dev/video0'
alias o='open'

# Shortcuts
source ~/.config/zsh/shortcutrc

# Zsh-z
source ~/Repos/zsh-z/zsh-z.plugin.zsh
