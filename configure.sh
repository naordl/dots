#!/bin/bash

# Variables
DOTDIR="$HOME/.local/src/dots"

# Shell
sudo ln -sfTv dash /usr/bin/sh
sudo chsh -s /bin/zsh root
sudo chsh -s /bin/zsh $USER
sudo ln -sfv $DOTDIR/.config/zsh/.zshrc /root/.zshrc

# Crontab
crontab $DOTDIR/.config/crontab.save.dinh
sudo crontab $DOTDIR/.config/root-crontab.save.dinh

# Copy the onboard nvidia graphics card disabler service
sudo cp -rv /etc/systemd/system/disablenvidia.service /lib/systemd/system/
sudo chmod 644 /etc/systemd/system/disablenvidia.service

# Enable systemd services
sudo systemctl enable disablenvidia
sudo systemctl enable cronie
sudo systemctl enable getty@tty1
sudo systemctl enable bluetooth
#sudo systemctl enable sshd
sudo systemctl enable tlp
sudo systemctl enable fstrim.timer
sudo systemctl enable reflector.service
#systemctl enable --user syncthing

# Rebuild grub and run mkinitcpio for all kernels
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
#rm -rfv $HOME/.Xauthority
