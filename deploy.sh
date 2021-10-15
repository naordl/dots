#!/bin/bash

## BEFORE RUNNING THIS SCRIPT, MAKE SURE TO HAVE RAN THE "install.sh" SCRIPT!
## RUN THIS SCRIPT FROM TTY2!

## CREATE IMPORTANT USER DIRECTORIES
mkdir -pv $HOME/{'Documents','Downloads','Music','Pictures','Videos','Repos','.local','.config'}
mkdir -pv $HOME/.local/share/{gnupg,mpd}
chmod -R 700 $HOME/.local/share/gnupg/
mkdir -pv $HOME/.config/{notmuch,mpop}
xdg-user-dirs-update

## DEPLOY DOTFILES
DOTDIR="$HOME/Repos/dots"
cp -rv $DOTDIR/.config/* $HOME/.config/
cp -rv $DOTDIR/.local/* $HOME/.local/
cp -rv $DOTDIR/.zprofile $HOME/
sudo cp -rv $DOTDIR/etc/* /etc/

## INSTALL VIMPLUG
sh -c 'curl -fLo "${XDG_DATA_HOME:-$HOME/.local/share}"/nvim/site/autoload/plug.vim --create-dirs \
       https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim'

## CLONE DEVOUR
git clone https://github.com/salman-abedin/devour.git $HOME/Repos/devour
cd $HOME/Repos/devour && sudo make clean install && cd

## CLONE WALLPAPERS
git clone https://github.com/demo2k20/wallpapers.git $HOME/Repos/wallpapers
ln -sr $HOME/Repos/wallpapers $HOME/Pictures/Wallpapers

## CLONE THEMES
git clone https://github.com/demo2k20/themes.git $HOME/Repos/themes
sudo ln -sr $HOME/Repos/themes/* /usr/share/themes

## CLONE WINDOWS FONTS
git clone https://github.com/demo2k20/windowsfonts.git $HOME/Repos/windowsfonts
sudo ln -sr $HOME/Repos/windowsfonts /usr/share/fonts/windowsfonts
sudo chmod 644 /usr/share/fonts/windowsfonts/*
sudo fc-cache --force

## CLONE PERSONAL DMENU BUILD
git clone https://github.com/demo2k20/dmenu.git $HOME/Repos/dmenu
cd $HOME/Repos/dmenu && sudo make clean install && cd

## CLEANUP
sudo ln -sfT dash /usr/bin/sh
sudo chsh -s /bin/zsh root
sudo chsh -s /bin/zsh $USER
sudo ln -sf /home/$USER/.config/zsh/.zshrc /root/.zshrc
crontab $HOME/.config/crontab.save.dinh
sudo crontab $HOME/.config/root-crontab.save.dinh
chmod +x -R $HOME/.local/bin/
sudo cp -rv /etc/systemd/system/disablenvidia.service /lib/systemd/system/
sudo chmod 644 /etc/systemd/system/disablenvidia.service
sudo cp -rv /etc/systemd/system/systemd-fsck-root.service /usr/lib/systemd/system/
sudo chmod 644 /etc/systemd/system/systemd-fsck-root.service
sudo cp -rv /etc/systemd/system/systemd-fsck@.service /usr/lib/systemd/system/
sudo chmod 644 /etc/systemd/system/systemd-fsck@.service
sudo systemctl enable disablenvidia # definitely breaks vms that don't use nvidia
sudo systemctl enable cronie
sudo systemctl enable getty@tty1
sudo systemctl enable bluetooth # probably breaks vms that don't use bluetooth
# sudo systemctl enable sshd
sudo systemctl enable tlp # probably breaks vms that don't use batteries
sudo systemctl enable fstrim.timer # probably breaks vms
sudo systemctl enable reflector.service
# systemctl enable --user syncthing # not using it anymore
sudo grub-mkconfig -o /boot/grub/grub.cfg
sudo mkinitcpio -P
sudo pacman -Rdd dmenu --noconfirm
sudo updatedb
sudo reflector --verbose --latest 5 --sort rate --save /etc/pacman.d/mirrorlist
paru -Syu --noconfirm
paru -Scc --noconfirm
paru -Rns $(paru -Qtdq) --noconfirm
paru -Qdttq | paru -Rns - --noconfirm
source ~/.zprofile
$SHELL
rm -rfv $HOME/.bashrc
rm -rfv $HOME/.bash_profile
rm -rfv $HOME/.bash_history
rm -rfv $HOME/.bash_logout
rm -rfv $HOME/.bash_login
rm -rfv $HOME/.Xauthority
rm -rfv $HOME/.pki/
rm -rfv $HOME/.icons/
rm -rfv $HOME/.ssh/
clear
tput setaf 2; printf "Successfully finished deploying dotfiles. Reboot for the changes to take effect.\n"; tput sgr0
