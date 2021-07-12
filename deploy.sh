#!/bin/bash

## BEFORE RUNNING THIS SCRIPT, MAKE SURE TO HAVE RAN THE "install.sh" SCRIPT!
## RUN THIS SCRIPT FROM TTY2!

## DEPLOY DOTFILES
cd $DOTDIR
cp -rv .config/ ~/
cp -rv .local/ ~/
cp -rv .zprofile ~/
sudo cp -rv etc/* /etc/
sudo cp -rv usr/* /usr/

## INSTALL VIMPLUG
sh -c 'curl -fLo "${XDG_DATA_HOME:-$HOME/.local/share}"/nvim/site/autoload/plug.vim --create-dirs \
       https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim'

## CLONE MANTIS THEME
cd /tmp && git clone https://github.com/mantissa-/mantis-theme.git && cd mantis-theme && sudo cp -rv Mantis\ Night/ /usr/share/themes/ && cd

## CLONE WALLPAPERS REPO
mkdir -pv ~/Pictures && cd ~/Pictures && git clone https://github.com/demo2k20/Wallpapers.git && cd

## CLONE PERSONAL DMENU BUILD
mkdir -pv ~/.local/share && cd ~/.local/share && git clone https://github.com/demo2k20/dmenu.git && cd dmenu && make && sudo make clean install && cd

## CLEANUP
sudo ln -sfT dash /usr/bin/sh
sudo chsh -s /bin/zsh root
sudo chsh -s /bin/zsh $USER
sudo ln -sf /home/$USER/.config/zsh/.zshrc /root/.zshrc
crontab ~/.config/crontab.save.dinh
sudo crontab ~/.config/root-crontab.save.dinh
sudo chmod 644 /usr/share/fonts/WindowsFonts/*
chmod +x -R ~/.local/bin/
sudo cp -rv /etc/systemd/system/disablenvidia.service /lib/systemd/system/
sudo chmod 644 /etc/systemd/system/disablenvidia.service
sudo cp -rv /etc/systemd/system/systemd-fsck-root.service /usr/lib/systemd/system/
sudo chmod 644 /etc/systemd/system/systemd-fsck-root.service
sudo cp -rv /etc/systemd/system/systemd-fsck@.service /usr/lib/systemd/system/
sudo chmod 644 /etc/systemd/system/systemd-fsck@.service
sudo systemctl enable disablenvidia
sudo systemctl enable cronie
sudo systemctl enable getty@tty1
sudo systemctl enable bluetooth
# sudo systemctl enable sshd
sudo systemctl enable tlp
sudo systemctl enable fstrim.timer
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
mkdir -pv ~/{Documents,Downloads,Music,Pictures,Videos}
mkdir -pv ~/.local/{mpd,gnupg}
mkdir -pv ~/.config/{notmuch,mpop}
chmod -R 700 ~/.local/share/gnupg/
xdg-user-dirs-update
sudo fc-cache --force
source ~/.zprofile
$SHELL
rm -rfv ~/.bashrc
rm -rfv ~/.bash_profile
rm -rfv ~/.bash_history
rm -rfv ~/.bash_logout
rm -rfv ~/.bash_login
rm -rfv ~/.Xauthority
rm -rfv ~/.pki/
rm -rfv ~/.icons/
rm -rfv ~/.ssh/
clear
tput setaf 2 && printf "Successfully finished deploying dotfiles. Reboot for the changes to take effect.\n"
