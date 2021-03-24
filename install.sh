#!/bin/sh

# THIS SCRIPT REQUIRES the "base-devel" PACKAGE TO BE INSTALLED.

# Install the Paru AUR helper
sudo pacman -S --noconfirm --needed git; cd /tmp; git clone https://aur.archlinux.org/paru-bin.git; cd paru-bin; makepkg -si

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
# i3 =
i3="i3-gaps i3blocks autotiling-git" # AUR PACKAGE

# bspwm =
bspwm="bspwm bsp-layout xorg-xsetroot polybar" # AUR PACKAGE

# DWM =
#mkdir -p ~/.local/share/; cd ~/.local/share; git clone https://github.com/demo2k20/dwm.git; git clone https://github.com/demo2k20/dwmblocks.git; git clone https://github.com/demo2k20/dmenu.git; cd ~/.local/share/dwm/; sudo make clean install; cd ../dwmblocks/; sudo make clean install; cd ../dmenu; sudo make clean install; sleep 1

WM="
	$i3
	$bspwm
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
launcher="dmenu"
notifications="dunst"
browser="qutebrowser"
compositor="picom"
taskmanager="htop"
networkmanager="networkmanager-dmenu-git"
audiomixer="pulsemixer"
filemanager="ranger python-ueberzug-git" # AUR PACKAGE
mediaplayer="mpv"
displaysettings="xorg-xrandr arandr"
nightlight="redshift"
printscreen="maim"
ssh="openssh" # systemctl enable sshd
pdfviewer="zathura zathura-pdf-poppler"
unclutter="unclutter"
locate="mlocate" # sudo updatedb
sysinfo="pfetch"
manuals="man-db man-pages"

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
	$nightlight
	$printscreen
	$ssh
	$pdfviewer
	$unclutter
	$locate
	$sysinfo
	$manuals
	"

# MY SCRIPT DEPENDENCIES
DEPENDENCIES="
	xss-lock
	nm-connection-editor	
	xdotool
	xclip
	exa
	playerctl
	acpi
	pamixer
	alsa-utils
	sysstat
	gvfs
	imagemagick
	xwallpaper
	rar
	unzip
	zip
	p7zip
	bzip2
	gzip
	rsync
	wmctrl
	i3lock
	libnotify
	youtube-dl
	xdg-user-dir
	xorg-xrdb
	reflector
	"

# SETUP FOR THE INSTALL COMMAND
install="paru -Syu --noconfirm --needed
	$ESSENTIALS
	$WM
	$AESTETHICS
	$SOFTWARE
	$DEPENDENCIES
	"
# RUN THE INSTALL COMMAND
$install

# DEPLOY DOTFILES
cd ~/.dotfiles/
cp -rv .config/ ~/
cp -rv .local/ ~/
cp -rv .bash_aliases .bash_profile .bashrc ~/
sudo cp -rv etc/* /etc/
sudo cp -rv root/ /

# INSTALL MANTIS THEME
cd /tmp; git clone https://github.com/mantissa-/mantis-theme.git; cd mantis-theme; sudo cp -rv Mantis/ Mantis\ Dusk/ Mantis\ Night/ /usr/share/themes/

# CLONE WALLPAPERS REPO
mkdir -pv ~/pictures; cd ~/pictures/; git clone https://github.com/DiscoBiscuit99/wallpapers.git

# CLEANUP
cd
chmod +x -R ~/.local/bin/
chmod +x -R ~/.config/i3/i3blocks/
sudo cp /etc/systemd/system/disablenvidia.service /lib/systemd/system/
sudo chmod 644 /etc/systemd/system/disablenvidia.service
sudo systemctl enable disablenvidia
sudo systemctl enable bluetooth
sudo systemctl enable sshd
sudo systemctl enable tlp
systemctl enable --user redshift
sudo grub-mkconfig -o /boot/grub/grub.cfg
sudo updatedb
sudo pacman -Rns i3-wm --noconfirm
paru -Syu --noconfirm
paru -Scc --noconfirm
paru -Rns $(paru -Qtdq) --noconfirm
sudo reflector --verbose --latest 5 --sort rate --save /etc/pacman.d/mirrorlist
xdg-user-dirs-update
source ~/.bash_profile
$SHELL
rm -rfv ~/.cache/*
rm -rfv ~/.bash_history
rm -rfv ~/.bash_logout
rm -rfv ~/.pki/
rm -rfv ~/.icons/
rm -rfv ~/.Xauthority
clear
pfetch
echo "Successfully finished deploying dotfiles. Reboot for the changes to take effect."
