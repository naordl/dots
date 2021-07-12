#!/bin/bash

## BEFORE RUNNING THIS SCRIPT, MAKE SURE TO HAVE RAN THE "install.sh" SCRIPT!
## RUN THIS SCRIPT FROM TTY2!

## SET DOTFILES DIR
DOTDIR="$HOME/.local/dots"

cd $DOTDIR
cp -rv $DOTDIR/.config/* $HOME/.config/
cp -rv $DOTDIR/.local/* $HOME/.local/
cp -rv $DOTDIR/.zprofile $HOME/
sudo cp -rv $DOTDIR/etc/* /etc/

## INSTALL VIMPLUG
sh -c 'curl -fLo "${XDG_DATA_HOME:-$HOME/.local/share}"/nvim/site/autoload/plug.vim --create-dirs \
       https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim'

## CLONE MANTIS THEME
cd /tmp && git clone https://github.com/mantissa-/mantis-theme.git && cd /tmp/mantis-theme && sudo cp -rv Mantis\ Night/ /usr/share/themes/ && cd

## CLONE WALLPAPERS REPO
mkdir -pv $HOME/Pictures && cd $HOME/Pictures && git clone https://github.com/demo2k20/Wallpapers.git && cd

## CLONE WINDOWS FONTS
mkdir -pv $HOME/.local && cd $HOME/.local && git clone https://github.com/demo2k20/winfonts.git && cd $HOME/.local/winfonts && sudo cp -rv $HOME/.local/winfonts/usr/* /usr/

## CLONE PERSONAL DMENU BUILD
mkdir -pv $HOME/.local/share && cd $HOME/.local/share && git clone https://github.com/demo2k20/dmenu.git && cd $HOME/.local/share/dmenu && make && sudo make clean install && cd

## CLEANUP
sudo ln -sfT dash /usr/bin/sh
sudo chsh -s /bin/zsh root
sudo chsh -s /bin/zsh $USER
sudo ln -sf /home/$USER/.config/zsh/.zshrc /root/.zshrc
crontab $HOME/.config/crontab.save.dinh
sudo crontab $HOME/.config/root-crontab.save.dinh
sudo chmod 644 /usr/share/fonts/WindowsFonts/*
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
systemctl enable --user syncthing
sudo grub-mkconfig -o /boot/grub/grub.cfg
sudo mkinitcpio -P
sudo pacman -Rdd dmenu --noconfirm
sudo updatedb
sudo reflector --verbose --latest 5 --sort rate --save /etc/pacman.d/mirrorlist
paru -Syu --noconfirm
paru -Scc --noconfirm
paru -Rns $(paru -Qtdq) --noconfirm
paru -Qdttq | paru -Rns - --noconfirm
mkdir -pv $HOME/{Documents,Downloads,Music,Pictures,Videos}
mkdir -pv $HOME/.local/{mpd,gnupg}
mkdir -pv $HOME/.config/{notmuch,mpop}
chmod -R 700 $HOME/.local/share/gnupg/
xdg-user-dirs-update
sudo fc-cache --force
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
tput setaf 2 && printf "Successfully finished deploying dotfiles. Reboot for the changes to take effect.\n"
