#!/bin/bash

printf "Back up dotfiles? (y/N) "
read choice

case "$choice" in
    y)
      DOTDIR="$HOME/.local/src/dots"

      tput setaf 2; printf "Backing up ssh keys...\n"; tput sgr0
      cp -rv $HOME/.ssh $HOME/Backups/PERSONAL/ssh

      tput setaf 2; printf "Backing up crontab...\n"; tput sgr0
      crontab -l > $DOTDIR/.config/crontab.save.dinh
      sudo crontab -l > $DOTDIR/.config/root-crontab.save.dinh
      tput setaf 2; printf "Success!\n"; tput sgr0

      tput setaf 2; printf "Backing up /etc/ stuff...\n"; tput sgr0
      cp -rv /etc/modprobe.d/nouveau.conf $DOTDIR/etc/modprobe.d/
      cp -rv /etc/sysctl.d/{dirty.conf,laptop.conf} $DOTDIR/etc/sysctl.d/
      cp -rv /etc/systemd/system/disablenvidia.service $DOTDIR/etc/systemd/system/
      cp -rv /etc/systemd/logind.conf $DOTDIR/etc/systemd/
      cp -rv /etc/udev/rules.d $DOTDIR/etc/udev/
      cp -rv /etc/X11/xorg.conf.d $DOTDIR/etc/X11/
      cp -rv /etc/pulse/default.pa $DOTDIR/etc/pulse/
      cp -rv /etc/xdg/reflector/reflector.conf $DOTDIR/etc/xdg/reflector/

      tput setaf 2; printf "Backup successful! You may now commit the changes.\n"; tput sgr0
      ;;

    *)
      tput setaf 1; printf "Exiting...\n"; tput sgr0
      exit
      ;;
esac
