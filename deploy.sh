#!/bin/bash

## THIS SCRIPT REQUIRES THE "base-devel" PACKAGE TO BE INSTALLED
## RUN THIS SCRIPT FROM TTY2!

## SET DOTFILES DIR
export DOTDIR="$HOME/.local/dots"

## INSTALL PARU
sudo pacman -S --noconfirm --needed git; cd /tmp; git clone https://aur.archlinux.org/paru-bin.git; cd paru-bin; makepkg -si

## ESSENTIALS
xorg="xorg-server xorg-xinit"
gpu="xf86-video-intel"
wifi="broadcom-wl"
audio="pulseaudio pulseaudio-alsa"
touchpad="libinput"
batterysaver="tlp"
bluetooth="bluez bluez-utils bcm43142a0-firmware" # AUR PACKAGE
# raidcard="aic94xx-firmware" # AUR PACKAGE
# westerndigital="wd719x-firmware" # AUR PACKAGE
backlight="acpilight"
fonts="ttf-dejavu nerd-fonts-dejavu-complete"

ESSENTIALS="
    $xorg
    $gpu
    $wifi
    $audio
    $touchpad
    $batterysaver
    $backlight
    $bluetooth
    $raidcard
    $westerndigital
    $fonts
    "

## WM
i3="i3-gaps i3blocks sxhkd"

WM="
    $i3
    "

## AESTETHICS
iconfonts="ttf-font-awesome"
# icontheme="papirus-icon-theme" # AUR PACKAGE
gtktheme="lxappearance" # GTK THEME - GITHUB REPO - MANTIS NIGHT

AESTETHICS="
    $iconfonts
    $icontheme
    $gtktheme
    "

## SOFTWARE
shell="zsh"
terminal="alacritty"
# launcher="dmenu" # CLONE DMENU BUILD
notifications="dunst"
browser="brave-bin"
compositor="picom"
taskmanager="htop"
# networkmanager="networkmanager-dmenu-git" # IT'S IN MY .local/bin DIRECTORY ALREADY
audiomixer="pulsemixer"
filemanager="ranger ueberzug dragon-drag-and-drop"
mediaplayer="mpv"
musicplayer="mpd ncmpcpp mpc"
imageviewer="sxiv"
webcammanager="guvcview"
displaysettings="xorg-xrandr arandr"
nightlight="redshift-minimal"
printscreen="maim"
ssh="openssh" # systemctl enable sshd
pdfviewer="zathura zathura-pdf-poppler"
unclutter="unclutter"
locate="mlocate" # sudo updatedb
manuals="man-db man-pages"
documents="libreoffice hunspell-en_us hunspell-hu texlive-core pandoc"
sync="syncthing"

SOFTWARE="
    $shell
    $terminal
    $launcher
    $notifications
    $browser
    $compositor
    $taskmanager
    $networkmanager
    $audiomixer
    $filemanager
    $mediaplayer
    $imageviewer
    $webcammanager
    $displaysettings
    $nightlight
    $printscreen
    $ssh
    $pdfviewer
    $unclutter
    $locate
    $manuals
    $documents
    "

## MY SCRIPT DEPENDENCIES
DEPENDENCIES="
    xss-lock
    nm-connection-editor
    xclip
    exa
    playerctl
    acpi
    imagemagick
    xwallpaper
    wmctrl
    python-pip
    rar
    unzip
    zip
    rsync
    reflector
    i3lock
    libnotify
    youtube-dl
    xdg-user-dirs
    xorg-xrdb
    dash
    dashbinsh
    checkbashisms
    acpi_call
    fzf
    cronie
    ntfs-3g
    bc
    xorg-xinput
    dosfstools
    mtools
    "

## SETUP FOR THE INSTALL COMMAND
install="paru -Syu --noconfirm --needed
    $ESSENTIALS
    $WM
    $AESTETHICS
    $SOFTWARE
    $DEPENDENCIES
    "
## RUN THE INSTALL COMMAND
$install

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
cd /tmp/; git clone https://github.com/mantissa-/mantis-theme.git; cd mantis-theme/; sudo cp -rv Mantis\ Night/ /usr/share/themes/; cd

## CLONE WALLPAPERS REPO
mkdir -pv ~/Pictures; cd ~/pic/; git clone https://github.com/demo2k20/Wallpapers.git; cd

## CLONE PERSONAL DMENU BUILD
mkdir -pv ~/.local/src; cd ~/.local/src; git clone https://github.com/demo2k20/dmenu.git; cd dmenu/; make; sudo make clean install; cd

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
#sudo systemctl enable sshd
sudo systemctl enable tlp
sudo systemctl enable fstrim.timer
sudo systemctl enable reflector.service
systemctl enable --user syncthing
sudo grub-mkconfig -o /boot/grub/grub.cfg
sudo mkinitcpio -P
sudo updatedb
sudo pacman -Rdd dmenu --noconfirm
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
echo "Successfully finished deploying dotfiles. Reboot for the changes to take effect."
