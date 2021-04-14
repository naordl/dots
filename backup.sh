#!/bin/bash

echo "Are you sure you want to merge your dotfiles? (yes/no)"
read choice

case "$choice" in
	yes)
	  echo "Backing up dotfiles..."
	  echo "Backing up bash configuration..."
	  cp -rv ~/.bashrc ~/.bash_profile ~/.bash_aliases ~/.dotfiles/
	  echo "Backing up crontab..."
	  crontab -l > ~/.config/crontab.save.dinh; cp -rv ~/.config/crontab.save.dinh ~/.dotfiles/.config/
	  echo "Backing up config files..."
	  cp -rv ~/.config/{alacritty,bspwm,dunst,git,gtk-2.0,gtk-3.0,i3,networkmanager-dmenu,nvim,picom,polybar,qutebrowser,ranger,sxhkd,vis,X11,user-dirs.dirs,user-dirs.locale,wall.png} ~/.dotfiles/.config/
	  echo "Backing up scripts..."
	  cp -rv ~/.local/bin ~/.dotfiles/.local/
	  echo "Backing up pandoc templates..."
	  cp -rv ~/.local/pandoc ~/.dotfiles/.local/
	  tput setaf 2; echo "Backup successful! You may now commit the changes."
	  ;;
	no)
	  echo "Exiting..."
	  exit
	  ;;
	*)
	  echo "Not a valid choice, exiting..."
	  exit
	  ;;
esac
