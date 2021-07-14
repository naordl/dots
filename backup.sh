#!/bin/bash

printf "Are you sure you want to merge and back up your dotfiles? (y/n) "
read choice

case "$choice" in
    y)
      export DOTDIR="$HOME/Repos/dots"
      echo "Backing up gpg secret key and 'pass' password store..."
      gpg --export-secret-keys Roland Nemes > ~/Backups/secret-key-backup
      gpg --export-ownertrust > ~/Backups/trustdb-backup
      rm -rf ~/Backups/pass; cp -rv ~/.local/share/pass ~/Backups/
      echo "Backing up dotfiles..."
      echo "Backing up .zprofile..."
      cp -rv ~/.zprofile $DOTDIR/
      echo "Backing up crontab..."
      crontab -l > ~/.config/crontab.save.dinh; cp -rv ~/.config/crontab.save.dinh $DOTDIR/.config/
      sudo crontab -l > ~/.config/root-crontab.save.dinh; cp -rv ~/.config/root-crontab.save.dinh $DOTDIR/.config/
      echo "Backing up config files..."
      cp -rv ~/.config/{bookmarks,shortcuts,emojis,alacritty,dunst,git,gtk-2.0,gtk-3.0,i3,tmux,neofetch,networkmanager-dmenu,nvim,mpd,ncmpcpp,picom,paru,ranger,sxhkd,x11,zsh,zathura,user-dirs.dirs,wall.png} $DOTDIR/.config/
      echo "Backing up scripts..."
      cp -rv ~/.local/bin $DOTDIR/.local/
      echo "Backing up pandoc templates..."
      cp -rv ~/.local/pandoc $DOTDIR/.local/
      echo "Backing up /etc/ stuff..."
      cp -rv /etc/default/grub $DOTDIR/etc/default/
      cp -rv /etc/modprobe.d/nouveau.conf $DOTDIR/etc/modprobe.d/
      cp -rv /etc/sysctl.d/{20-quiet-printk.conf,dirty.conf,laptop.conf} $DOTDIR/etc/sysctl.d/
      cp -rv /etc/systemd/system/{getty@tty1.service.d,getty@tty5.service.d,disablenvidia.service,systemd-fsck-root.service,systemd-fsck@.service} $DOTDIR/etc/systemd/system/
      cp -rv /etc/systemd/logind.conf $DOTDIR/etc/systemd/
      cp -rv /etc/udev/rules.d $DOTDIR/etc/udev/
      cp -rv /etc/X11/xorg.conf.d $DOTDIR/etc/X11/
      cp -rv /etc/pulse/default.pa $DOTDIR/etc/pulse/
      cp -rv /etc/{bash.bashrc,DIR_COLORS,makepkg.conf,mkinitcpio.conf,pacman.conf} $DOTDIR/etc/
      cp -rv /etc/libreoffice/sofficerc $DOTDIR/etc/libreoffice/
      cp -rv /etc/xdg/reflector/reflector.conf $DOTDIR/etc/xdg/reflector/
      tput setaf 2; echo "Backup successful! You may now commit the changes."
      ;;
    *)
      echo "Exiting..."
      exit
      ;;
esac
