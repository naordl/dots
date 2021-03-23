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
# DWM =
mkdir -p ~/.local/share/; cd ~/.local/share; git clone https://github.com/demo2k20/dwm.git; git clone https://github.com/demo2k20/dwmblocks.git; git clone https://github.com/demo2k20/dmenu.git; cd ~/.local/share/dwm/; sudo make clean install; cd ../dwmblocks/; sudo make clean install; cd ../dmenu; sudo make clean install; sleep 1

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
launcher="dmenu"
notifications="dunst"
browser="qutebrowser"
compositor="picom"
taskmanager="htop"
networkmanager="networkmanager-dmenu-git"
audiomixer="pulsemixer"
filemanager="ranger python-ueberzug-git" # AUR PACKAGE
mediaplayer="mpv"
displaysettings="arandr"
nightlight="redshift"
printscreen="maim"
ssh="openssh" # systemctl enable sshd
pdfviewer="zathura zathura-pdf-poppler"
unclutter="unclutter"
locate="mlocate" # sudo updatedb
sysinfo="pfetch"

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
	xdg-user-dirs
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
sleep 1

# INSTALL DOTFILES
cd ~/.dotfiles; sleep 1
cp -r .config/ ~/; sleep 1
cp -r .local/ ~/; sleep 1
cp .bash_aliases .bash_profile .bashrc ~/; sleep 1
sudo cp -r etc/* /etc/; sleep 1
sudo cp -r root/ /; sleep 1

# INSTALL MANTIS THEME
cd /tmp; git clone https://github.com/mantissa-/mantis-theme.git; cd mantis-theme; sudo cp -r Mantis/ Mantis\ Dusk/ Mantis\ Night/ /usr/share/themes; cd ..; sleep 1

# CLONE WALLPAPERS REPO
mkdir -p ~/pictures; git clone https://github.com/DiscoBiscuit99/wallpapers.git; sleep 1

# AFTERMATH CLEANUP
chmod +x -R ~/.local/bin; sleep 1
chmod +x -R ~/.config/i3/i3blocks; sleep 1
sudo cp /etc/systemd/system/disablenvidia.service /lib/systemd/system/; sleep 1
sudo chmod 644 /etc/systemd/system/disablenvidia.service; sleep 1
sudo systemctl enable disablenvidia; sleep 1
systemctl enable --user redshift; sleep 1
sudo systemctl enable bluetooth; sleep 1
sudo systemctl enable sshd; sleep 1
sudo systemctl enable tlp; sleep 1
sudo grub-mkconfig -o /boot/grub/grub.cfg; sleep 1
sudo updatedb; sleep 1
paru -Syu --noconfirm; sleep 1
bash; sleep 1
rm -f ~/.bash_history; sleep 1
rm -f ~/.bash_logout; sleep 1
rm -f ~/.pki/; sleep 1
rm -f ~/.icons/; sleep 1
rm -f ~/.Xauthority; sleep 1

cd; sleep 1
xdg-user-dirs-update; sleep 1
clear; sleep 1
pfetch; sleep 1
echo " Dotfiles installation finished. Reboot for changes to take effect."
