# ~/.aliasrc

# archive extractor
# dependencies: rar, zip, unzip, p7zip, bzip2, gzip
# usage: ex <file>
ex () {
if [ -f $1 ] ; then
case $1 in
*.tar.bz2) tar xvjf $1 ;;
*.tar.gz) tar xvzf $1 ;;
*.bz2) bunzip2 $1 ;;
*.rar) rar x $1 ;;
*.gz) gunzip $1 ;;
*.tar) tar xvf $1 ;;
*.tbz2) tar xvjf $1 ;;
*.tgz) tar xvzf $1 ;;
*.zip) unzip $1 ;;
*.Z) uncompress $1 ;;
*.7z) 7z x $1 ;;
*) echo "Don't know how to extract '$1'..." ;;
esac
else
echo "'$1' is not a valid file!"
fi
}

# shortcuts
alias ls='exa -lah --color=auto --group-directories-first'
alias grep='grep --color=auto'
alias diff='diff --color=auto'
alias cp='cp -r'
alias mv='mv'
alias rm='rm -r'
alias pac='sudo pacman'
alias mkd='mkdir -p'
alias r='ranger'
alias sr='sudo ranger'
alias vim='nvim'
alias v='nvim'
alias sv='sudo nvim'
alias cal='cal -m'
alias ytmusic='youtube-dl -i -o "~/Music/%(title)s.%(ext)s" -x --audio-format mp3'
alias gengrub="sudo grub-mkconfig -o /boot/grub/grub.cfg"
alias mi="cp -v config.def.h config.h; sudo make clean install"
alias mntfs="sudo mount -t ntfs"
