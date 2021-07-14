#!/bin/bash

## THIS SCRIPT REQUIRES THE "base-devel" PACKAGE TO BE INSTALLED!

## INSTALL PARU
sudo pacman -S --noconfirm --needed git && cd /tmp && git clone https://aur.archlinux.org/paru-bin.git && cd paru-bin && makepkg -si

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
icontheme="papirus-icon-theme"
gtktheme="lxappearance" # GTK THEME - GITHUB REPO - MANTIS NIGHT - AUR PACKAGE

AESTETHICS="
    $iconfonts
    $icontheme
    $gtktheme
    "

## SOFTWARE
shell="zsh"
terminal="alacritty"
# dropdownterminal="tdrop-git" # DOESN'T BUILD FROM AUR
# launcher="dmenu" # CLONE DMENU BUILD
notifications="libnotify dunst"
browser="brave-bin"
compositor="picom"
taskmanager="htop"
# networkmanager="networkmanager-dmenu-git" # IT'S IN ~/.local/bin DIRECTORY ALREADY
audiomixer="pulsemixer"
filemanager="ranger ueberzug dragon-drag-and-drop"
mediaplayer="mpv"
musicplayer="mpd ncmpcpp mpc"
imageviewer="sxiv"
imageeditor="gimp"
webcammanager="guvcview"
displaysettings="xorg-xrandr arandr"
nightlight="redshift-minimal"
printscreen="maim"
ssh="openssh" # systemctl enable sshd
pdfviewer="zathura zathura-pdf-poppler"
unclutter="unclutter"
locate="mlocate" # sudo updatedb
manuals="man-db man-pages"
documents="libreoffice hunspell-en_us hunspell-hu hunspell-ro texlive-core pandoc"
ocr="tesseract tesseract-data-eng tesseract-data-hun tesseract-data-ron"
sync="syncthing"
fstools="dosfstools mtools simple-mtpfs"

SOFTWARE="
    $shell
    $terminal
    $dropdownterminal
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
    $imageeditor
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
    $ocr
    $sync
    $fstools
    "

## MY SCRIPT DEPENDENCIES
DEPENDENCIES="
    xss-lock
    xorg-xset
    xdotool
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
    youtube-dl
    pamixer
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
    "

## SETUP FOR THE INSTALL COMMAND
install="paru -Syu --needed
    $ESSENTIALS
    $WM
    $AESTETHICS
    $SOFTWARE
    $DEPENDENCIES
    "
## RUN THE INSTALL COMMAND
$install
