# ~/.aliasrc

# archive extractor
# dependencies: unrar unzip
# usage: ex <file>
ex ()
{
  if [ -f $1 ] ; then
    case $1 in
      *.tar.bz2)   tar xjf $1   ;;
      *.tar.gz)    tar xzf $1   ;;
      *.bz2)       bunzip2 $1   ;;
      *.rar)       unrar x $1     ;;
      *.gz)        gunzip $1    ;;
      *.tar)       tar xf $1    ;;
      *.tbz2)      tar xjf $1   ;;
      *.tgz)       tar xzf $1   ;;
      *.zip)       unzip $1     ;;
      *.Z)         uncompress $1;;
      *.7z)        7z x $1      ;;
      *)           echo "'$1' cannot be extracted via ex()" ;;
    esac
  else
    echo "'$1' is not a valid file"
  fi
}

# shortcuts
alias kat='bat'
alias ls='exa -lah --color=auto --group-directories-first'
alias grep='grep --color=auto'
alias diff='diff --color=auto'
alias cp='cp -r'
alias mv='mv -v'
alias rm='rm -r'
alias pac='sudo pacman'
alias mkd='mkdir -pv'
alias g='git'
alias r='ranger'
alias sr='sudo ranger'
alias vim='nvim'
alias v='nvim'
alias sv='sudo nvim'
alias cal='cal -m'
alias ytmusic='youtube-dl -i -o "~/Music/%(title)s.%(ext)s" -x --audio-format mp3'
alias gengrub="sudo grub-mkconfig -o /boot/grub/grub.cfg"
