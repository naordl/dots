#!/bin/bash

printf "Merge and back up dotfiles? (y/n) "
read choice

case "$choice" in
    y)
      export DOTDIR="$HOME/Repos/dots"

      printf "Backing up gpg secret key and 'pass' password store...\n"
      gpg --export-secret-keys Roland Nemes > ~/Backups/secret-key-backup
      gpg --export-ownertrust > ~/Backups/trustdb-backup
      rm -rf ~/Backups/pass; cp -rv ~/.local/share/pass ~/Backups/

      printf "Backing up ssh keys...\n"
      cp -rv ~/.ssh ~/Backups/ssh

      printf "Backing up dotfiles...\n"

      printf "Backing up zprofile...\n"
      cp -rv ~/.zprofile $DOTDIR/

      printf "Backing up crontab...\n"
      crontab -l > ~/.config/crontab.save.dinh; cp -rv ~/.config/crontab.save.dinh $DOTDIR/.config/
      sudo crontab -l > ~/.config/root-crontab.save.dinh; cp -rv ~/.config/root-crontab.save.dinh $DOTDIR/.config/

      printf "Backing up config files...\n"
      cp -rv ~/.config/{alacritty,dunst,git,gtk-2.0,gtk-3.0,i3,neofetch,nvim,mpd,ncmpcpp,picom,paru,ranger,sxhkd,sxiv,x11,zsh,zathura,user-dirs.dirs,wall.png} $DOTDIR/.config/

      printf "Backing up ~/.local/ stuff...\n"

      printf "Backing up scripts...\n"
      cp -rv ~/.local/bin $DOTDIR/.local/

      printf "Backing up pandoc templates...\n"
      cp -rv ~/.local/pandoc $DOTDIR/.local/

      printf "Backing up vocabulary database...\n"
      cp -rv ~/.local/vocab $DOTDIR/.local/

      printf "Backing up bookmark database...\n"
      cp -rv ~/.local/bookmarks $DOTDIR/.local/

      printf "Backing up shortcut database...\n"
      cp -rv ~/.local/shortcuts $DOTDIR/.local/

      printf "Backing up emoji database...\n"
      cp -rv ~/.local/emojis $DOTDIR/.local/

      printf "Backing up /etc/ stuff...\n"
      cp -rv /etc/default/grub $DOTDIR/etc/default/
      cp -rv /etc/modprobe.d/nouveau.conf $DOTDIR/etc/modprobe.d/
      cp -rv /etc/sysctl.d/{20-quiet-printk.conf,dirty.conf,disable_watchdog.conf,laptop.conf} $DOTDIR/etc/sysctl.d/
      cp -rv /etc/systemd/system/{getty@tty1.service.d,disablenvidia.service,systemd-fsck-root.service,systemd-fsck@.service} $DOTDIR/etc/systemd/system/
      cp -rv /etc/systemd/logind.conf $DOTDIR/etc/systemd/
      cp -rv /etc/udev/rules.d $DOTDIR/etc/udev/
      cp -rv /etc/X11/xorg.conf.d $DOTDIR/etc/X11/
      cp -rv /etc/pulse/default.pa $DOTDIR/etc/pulse/
      cp -rv /etc/{bash.bashrc,DIR_COLORS,makepkg.conf,mkinitcpio.conf,pacman.conf} $DOTDIR/etc/
      cp -rv /etc/libreoffice/sofficerc $DOTDIR/etc/libreoffice/
      cp -rv /etc/xdg/reflector/reflector.conf $DOTDIR/etc/xdg/reflector/

      tput setaf 2 && printf "Backup successful! You may now commit the changes.\n"
      ;;

    *)
      printf "Exiting...\n"
      exit
      ;;
esac
