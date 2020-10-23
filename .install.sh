#!/bin/sh

# !!!DISCLAIMER!!!
# THIS SCRIPT REQUIRES the "base-devel" PACKAGE TO BE INSTALLED.

# Install yay AUR helper
sudo pacman -S --noconfirm --needed git; cd /tmp; git clone https://aur.archlinux.org/yay.git; cd yay; makepkg -si

# ESSENTIALS
xorg="xorg-server xorg-xinit"
gpu="xf86-video-intel"
wifi="broadcom-wl"
audio="pulseaudio pulseaudio-alsa"
touchpad="libinput" # Insert the libinput file from github repo to /etc/X11/xorg.conf.d/40-libinput.conf
batterysaver="tlp"
bluetooth="bluez bluez-utils blueman bcm43142a0-firmware" # AUR PACKAGE # sudo systemctl enable bluetooth.service
raidcard="aic94xx-firmware" # AUR PACKAGE
westerndigital="wd719x-firmware" # AUR PACKAGE
backlight="acpilight"
fonts="ttf-liberation ttf-dejavu"

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

# WM
i3="i3-gaps i3blocks i3lock autotiling-git xss-lock" # AUR PACKAGE

WM="
	$i3
	"

# AESTETHICS
iconfonts="ttf-font-awesome"
icontheme="papirus-icon-theme" # AUR PACKAGE
gtktheme="lxappearance" # GITHUB REPO MANTIS NIGHT

AESTETHICS="
	$iconfonts
	$icontheme
	$gtktheme
	"

# SOFTWARE
terminal="alacritty"
launcher="rofi"
notifications="dunst"
browser="firefox"
compositor="picom"
taskmanager="htop"
networkmanager="networkmanager-dmenu-git"
audiomixer="pulsemixer"
filemanager="ranger python-ueberzug-git" # AUR PACKAGE
mediaplayer="mpv"
displaysettings="arandr"
redshift="redshift"
printscreen="maim"
ssh="openssh" # systemctl enable sshd
pdfviewer="zathura zathura-pdf-poppler"
unclutter="unclutter"
locate="mlocate" # sudo updatedb
sysinfo="neofetch"

SOFTWARE="
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
	$displaysettings
	$redshift
	$printscreen
	$ssh
	$pdfviewer
	$unclutter
	$locate
	$sysinfo
	"

# MY SCRIPT DEPENDENCIES
DEPENDENCIES="
	nm-connection-editor	
	xdotool
	xclip
	exa
	playerctl
	acpi
	alsa-utils
	sysstat
	gvfs
	imagemagick
	feh
	unrar
	unzip
	"

# SETUP FOR THE INSTALL COMMAND
install="yay -Syu --noconfirm --needed
	$ESSENTIALS
	$WM
	$AESTETHICS
	$SOFTWARE
	$DEPENDENCIES
	"
# RUN THE INSTALL COMMAND
$install
sleep 1

# INSTALL DOTFILES
cd /tmp
git clone https://github.com/demo2k20/.dotfiles.git
sleep 1
cd .dotfiles
cp -r .config ~/.config
cp -r .scripts ~/.scripts
cp .bash_aliases .bash_profile .bashrc .xinitrc ~/
sudo cp -rf etc/* /etc/ 

# CLONE WALLPAPERS REPO
mkdir -p ~/Pictures/; cd ~/Pictures/; git clone https://github.com/DiscoBiscuit99/wallpapers.git

# AFTERMATH CLEANUP
chmod +x -R ~/.scripts
chmod +x -R ~/.config/i3/i3blocks
sudo cp /etc/systemd/system/disablenvidia.service /lib/systemd/system/
sleep 2
sudo chmod 644 /etc/systemd/system/disablenvidia.service
sudo systemctl enable disablenvidia
systemctl enable --user --now redshift
sudo systemctl enable --now bluetooth
sudo systemctl enable --now sshd
sudo systemctl enable --now tlp
sudo grub-mkconfig -o /boot/grub/grub.cfg
sudo updatedb
rm -f ~/.bash_history
yay -Syu --noconfirm
cd
clear
neofetch
echo " Dotfiles installation finished. Reboot for changes to take effect."
