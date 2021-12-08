#!/bin/bash

# Variables
DOTDIR="$HOME/.local/src/dots"
SOURCEDIR="$HOME/.local/src"

# Deploy dotfiles function
deploy_dotfiles() { \
    ln -sfrv $DOTDIR/.config/* $HOME/.config/
    ln -sfrv $DOTDIR/.local/* $HOME/.local/
    ln -sfv $DOTDIR/.zprofile $HOME/.zprofile
    sudo cp -rv $DOTDIR/etc/* /etc/
}

# If the dotfiles repository is placed in $SOURCEDIR, then deploy dotfiles
# Else exit and print error message
if [ ! -z "$DOTDIR" ]; then
    deploy_dotfiles
else
    printf "The dotfiles directory is not in the correct place...\n"
    printf "Please place the repository in $SOURCEDIR\n"
    printf "Exiting...\n"
    exit 1
fi

# Create user directories
mkdir -pv $HOME/{'dox','mus','pix','vids','.local','.config'}
xdg-user-dirs-update

# Clone more repos
clone_wallpapers() { \
    git clone https://github.com/demo2k20/wallpapers.git $SOURCEDIR/wallpapers
    ln -srv $SOURCEDIR/wallpapers $HOME/pix/Wallpapers
}

clone_themes() { \
    git clone https://github.com/demo2k20/themes.git $SOURCEDIR/themes
    sudo ln -srv $SOURCEDIR/themes/* /usr/share/themes
}

clone_windowsfonts() { \
    git clone https://github.com/demo2k20/windowsfonts.git $SOURCEDIR/windowsfonts
    sudo ln -srv $SOURCEDIR/windowsfonts /usr/share/fonts/windowsfonts
    sudo chmod 644 /usr/share/fonts/windowsfonts/*
    sudo fc-cache --force
}

clone_dmenu() { \
    git clone https://github.com/demo2k20/dmenu.git $SOURCEDIR/dmenu
    cd $SOURCEDIR/dmenu && sudo make clean install && cd
}

# If the $SOURCEDIR directory exists, then clone more dotfiles (unless they already exist)
# Else exit and print error message
if [ ! -z $SOURCEDIR ]; then
    [ -z $SOURCEDIR/wallpapers ] && clone_wallpapers
    [ -z $SOURCEDIR/themes ] && clone_themes
    [ -z $SOURCEDIR/windowsfonts ] && clone_windowsfonts
    [ -z $SOURCEDIR/dmenu ] && clone_dmenu
else
    printf "The source directory does not exist...\n"
    printf "Please create the folder $SOURCEDIR\n"
    printf "Exiting...\n"
    exit 1
fi

# Done
tput setaf 2; printf "Successfully finished deploying dotfiles. Reboot for the changes to fully take effect.\n"; tput sgr0
tput setaf 2; printf "The 'configure' script changes the shell, starts systemd services etc.\n"; tput sgr0
tput setaf 2; printf "Consider running it if this is a fresh installation.\n"; tput sgr0
