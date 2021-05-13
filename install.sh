#!/bin/bash

## THIS SCRIPT REQUIRES the "base-devel" PACKAGE TO BE INSTALLED.
## RUN THIS SCRIPT FROM TTY2!

## SET DOTFILES DIR
export DOTDIR="$HOME/.local/dots"

## Install the Paru AUR helper
sudo pacman -S --noconfirm --needed git; cd /tmp; git clone https://aur.archlinux.org/paru-bin.git; cd paru-bin; makepkg -si

## ESSENTIALS
xorg="xorg-server xorg-xinit"
gpu="xf86-video-intel"
wifi="broadcom-wl"
audio="pulseaudio pulseaudio-alsa"
touchpad="libinput" # Insert the libinput file from github repo to /etc/X11/xorg.conf.d/40-libinput.conf
batterysaver="tlp"
bluetooth="bluez bluez-utils blueman bcm43142a0-firmware" # AUR PACKAGE # sudo systemctl enable bluetooth.service
# raidcard="aic94xx-firmware" # AUR PACKAGE
# westerndigital="wd719x-firmware" # AUR PACKAGE
backlight="acpilight"
fonts="ttf-dejavu"

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
# i3
i3="i3-gaps i3blocks sxhkd" # AUR PACKAGE

# bspwm
bspwm="bspwm sxhkd bsp-layout xorg-xsetroot polybar" # AUR PACKAGE

# DWM
# mkdir -p ~/.local/share/; cd ~/.local/share; git clone https://github.com/demo2k20/dwm.git; git clone https://github.com/demo2k20/dwmblocks.git; git clone https://github.com/demo2k20/dmenu.git; cd ~/.local/share/dwm/; sudo make clean install; cd ../dwmblocks/; sudo make clean install; cd ../dmenu; sudo make clean install; sleep 1

WM="
	$i3
	$bspwm
	"

## AESTETHICS
iconfonts="ttf-font-awesome"
icontheme="papirus-icon-theme" # AUR PACKAGE
gtktheme="breeze lxappearance" # GITHUB REPO MANTIS NIGHT

AESTETHICS="
	$iconfonts
	$icontheme
	$gtktheme
	"

## SOFTWARE
shell="zsh"
terminal="alacritty"
# launcher="" # CLONE PERSONAL DMENU BUILD
notifications="dunst"
browser="brave-bin"
compositor="picom"
taskmanager="htop"
networkmanager="networkmanager-dmenu-git"
audiomixer="pulsemixer"
filemanager="ranger ueberzug"
mediaplayer="mpv"
musicplayer="mpd ncmpcpp mpdris2 mpc"
imageviewer="sxiv"
displaysettings="xorg-xrandr arandr"
nightlight="redshift-minimal"
printscreen="maim"
ssh="openssh" # systemctl enable sshd
pdfviewer="zathura zathura-pdf-poppler"
unclutter="unclutter"
locate="mlocate" # sudo updatedb
manuals="man-db man-pages"

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
	$displaysettings
	$nightlight
	$printscreen
	$ssh
	$pdfviewer
	$unclutter
	$locate
	$manuals
	"

## MY SCRIPT DEPENDENCIES
DEPENDENCIES="
	xss-lock
	nm-connection-editor
	xdotool
	xclip
	exa
	playerctl
	acpi
	alsa-utils
	pamixer
	imagemagick
	xwallpaper
	wmctrl
	python-pip
	rar
	unzip
	zip
	rsync
	i3lock
	libnotify
	youtube-dl
	xdg-user-dirs
	xorg-xrdb
	reflector
	dash
	dashbinsh
	checkbashisms
	acpi_call
	fzf
	cronie
	ntfs-3g
	bc
	xorg-xinput
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
cp -rv .hushlogin ~/.hushlogin
sudo cp -rv etc/* /etc/
sudo cp -rv usr/* /usr/
sudo cp -rv root/* /root/

## INSTALL VIMPLUG
sh -c 'curl -fLo "${XDG_DATA_HOME:-$HOME/.local/share}"/nvim/site/autoload/plug.vim --create-dirs \
       https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim'

## CLONE MANTIS THEME
cd /tmp/; git clone https://github.com/mantissa-/mantis-theme.git; cd mantis-theme/; sudo cp -rv Mantis/ Mantis\ Dusk/ Mantis\ Night/ /usr/share/themes/

## CLONE WALLPAPERS REPO
mkdir -pv ~/pic; cd ~/pic/; git clone https://github.com/DiscoBiscuit99/wallpapers.git

## CLONE PERSONAL DMENU BUILD
cd ~/.local/; git clone https://github.com/demo2k20/dmenu.git; cd dmenu/; make; sudo make clean install

## CLEANUP
cd
sudo ln -sfT dash /usr/bin/sh
sudo chsh -s /bin/zsh root
sudo chsh -s /bin/zsh $USER
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
sudo grub-mkconfig -o /boot/grub/grub.cfg
sudo mkinitcpio -P
sudo updatedb
#sudo pacman -Rns i3-wm --noconfirm
sudo pacman -Rdd dmenu --noconfirm
sudo reflector --verbose --latest 5 --sort rate --save /etc/pacman.d/mirrorlist
paru -Syu --noconfirm
paru -Scc --noconfirm
paru -Rns $(paru -Qtdq) --noconfirm
paru -Qdttq | paru -Rns - --noconfirm
mkdir -pv ~/{doc,dow,mus,pic,vid}
mkdir -pv ~/.local/{mpd,gnupg}
mkdir -pv ~/.config/{notmuch,mpop}
xdg-user-dirs-update
sudo fc-cache --force
source ~/.zprofile
$SHELL
rm -rfv ~/.cache/*
rm -rfv ~/.bashrc
rm -rfv ~/.bash_profile
rm -rfv ~/.bash_history
rm -rfv ~/.bash_logout
rm -rfv ~/.bash_login
rm -rfv ~/.pki/
rm -rfv ~/.icons/
rm -rfv ~/.Xauthority
clear
echo "Successfully finished deploying dotfiles. Reboot for the changes to take effect."
