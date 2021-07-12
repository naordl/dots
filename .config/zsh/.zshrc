# ~/.config/zsh/.zshrc

# Prompt
PROMPT="%F{red}[%f%B%F{3}%n%f%b%F{10}@%f%F{14}%m%f %F{13}%~%f%F{red}]%f$ "
unsetopt prompt_cr prompt_sp

# Case insensitivity
zstyle ':completion:*' matcher-list 'm:{a-zA-Z}={A-Za-z}'
setopt MENU_COMPLETE

# Complete aliases
unsetopt complete_aliases

# Disable ctrl+s
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

# Purge (mostly) useless junk
[ -f ~/.pki ] || rm -rf ~/.pki
[ -f ~/.icons ] || rm -rf ~/.icons
[ -f ~/.java ] || rm -rf ~/.java
[ -f ~/.zoom ] || rm -rf ~/.zoom
[ -f ~/.mono ] || rm -rf ~/.mono
[ -f ~/.ssh ] || rm -rf ~/.ssh

# Startx
alias startx="startx ~/.config/x11/xinitrc"

# Functions
# es - edit scripts and config files using fzf
es() { du -a ~/.local/bin/* ~/.config/* ~/.local/share/{dmenu,dwm,dwmblocks} | awk '{print $2}' | fzf | xargs -r $EDITOR ;}

# Aliases
alias pac='sudo pacman'
alias ls='ls -hN --color=auto --group-directories-first'
alias ll='exa -lh --color=auto --group-directories-first'
alias la='exa -lah --color=auto --group-directories-first'
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
alias cal='cal -m'
alias ytmusic='youtube-dl -i -o "~/Music/%(title)s.%(ext)s" -x --audio-format mp3'
alias gengrub='sudo grub-mkconfig -o /boot/grub/grub.cfg'
alias refresh='sudo reflector --verbose --latest 5 --sort rate --save /etc/pacman.d/mirrorlist'
alias mi='cp -v config.def.h config.h; sudo make clean install'
alias gacp='git add . && git commit -m 'Autocommit.' && git push'
alias mntfs='sudo mount -t ntfs'
alias mfat32='sudo mount -o gid=users,fmask=113,dmask=002'
alias umnt='sync; sudo umount'
alias td='$EDITOR ~/Documents/todo.md'
alias pt="sudo powertop"

# Shortcuts
source ~/.config/zsh/shortcutrc
