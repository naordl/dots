#!/bin/bash

## BEFORE RUNNING THIS SCRIPT, MAKE SURE TO HAVE RAN THE "install.sh" SCRIPT!
## RUN THIS SCRIPT FROM TTY2!

## CREATE IMPORTANT USER DIRECTORIES
mkdir -pv $HOME/{'Documents','Downloads','Music','Pictures','Videos','Repos','.local','.config'}
mkdir -pv $HOME/.local/share/{gnupg,mpd}
chmod -R 700 $HOME/.local/share/gnupg/
xdg-user-dirs-update

## DEPLOY DOTFILES
DOTDIR="$HOME/Repos/dots"
cp -rv $DOTDIR/.config/* $HOME/.config/
cp -rv $DOTDIR/.local/* $HOME/.local/
cp -rv $DOTDIR/.zprofile $HOME/
sudo cp -rv $DOTDIR/etc/* /etc/

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
# Shell
sudo ln -sfT dash /usr/bin/sh
sudo chsh -s /bin/zsh root
sudo chsh -s /bin/zsh $USER
sudo ln -sf /home/$USER/.config/zsh/.zshrc /root/.zshrc
# Crontab
crontab $HOME/.config/crontab.save.dinh
sudo crontab $HOME/.config/root-crontab.save.dinh
# Copy the onboard nvidia graphics card disabler service
sudo cp -rv /etc/systemd/system/disablenvidia.service /lib/systemd/system/
sudo chmod 644 /etc/systemd/system/disablenvidia.service
# Enable some systemd services
sudo systemctl enable disablenvidia # Definitely breaks vms that don't use nvidia
sudo systemctl enable cronie
sudo systemctl enable getty@tty1
sudo systemctl enable bluetooth # Probably breaks vms that don't use bluetooth
# sudo systemctl enable sshd # Useless on main machine
sudo systemctl enable tlp # Probably breaks vms that don't use batteries
sudo systemctl enable fstrim.timer # Probably breaks vms
sudo systemctl enable reflector.service
# systemctl enable --user syncthing # Not using it anymore
# Rebuild grub and run mkinitcpio on all the installed kernels
sudo grub-mkconfig -o /boot/grub/grub.cfg
sudo mkinitcpio -P
# Purge junk
rm -rfv $HOME/.bashrc
rm -rfv $HOME/.bash_profile
rm -rfv $HOME/.bash_history
rm -rfv $HOME/.bash_logout
rm -rfv $HOME/.bash_login
rm -rfv $HOME/.pki/
rm -rfv $HOME/.icons/
rm -rfv $HOME/.ssh/
rm -rfv $HOME/.Xauthority

# Done
tput setaf 2; printf "Successfully finished deploying dotfiles. Reboot for the changes to take effect.\n"; tput sgr0
