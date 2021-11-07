#!/bin/bash

## INSTALL BASE-DEVEL GROUP (IF IT IS NOT INSTALLED ALREADY)
sudo pacman -S --needed base-devel

## INSTALL PARU
sudo pacman -S --noconfirm --needed git && git clone https://aur.archlinux.org/paru-bin.git /tmp/paru-bin && cd /tmp/paru-bin && makepkg -si && cd

## ESSENTIALS
xorg="xorg-server xorg-xinit"
gpu="xf86-video-intel"
wifi="broadcom-wl"
audio="pulseaudio pulseaudio-alsa"
touchpad="libinput"
webcam="linux-headers v4l2loopback-dkms" # FIXES WEBCAM RANDOMLY NOT WORKING
batterysaver="tlp powertop"
bluetooth="bluez bluez-utils bcm43142a0-firmware" # AUR
backlight="acpilight"
fonts="ttf-dejavu terminus-font"

ESSENTIALS="
    $xorg
    $gpu
    $wifi
    $audio
    $touchpad
    $webcam
    $batterysaver
    $bluetooth
    $backlight
    $fonts
    "

## WM
i3="i3-gaps i3blocks sxhkd"

WM="
    $i3
    "

## AESTETHICS
iconfonts="ttf-font-awesome"
emojifonts="ttf-joypixels"
icontheme="papirus-icon-theme"
gtktheme="arc-gtk-theme lxappearance" # CLONE THEMES FROM GITHUB

AESTETHICS="
    $iconfonts
    $emojifonts
    $icontheme
    $gtktheme
    "

## SOFTWARE
shell="zsh dash dashbinsh" # AUR
terminal="alacritty"
# dropdownterminal="tdrop-git" # DOES NOT BUILD FROM AUR
# launcher="dmenu" # CLONE DMENU BUILD
notifications="libnotify dunst"
browser="brave-bin" # AUR
calculator="bc"
calendar="calcurse"
compositor="xcompmgr"
taskmanager="htop"
audiomixer="pulsemixer"
filemanager="ranger ueberzug dragon-drag-and-drop" # AUR
mediaplayer="mpv"
musicplayer="mpd ncmpcpp mpc"
imageviewer="sxiv"
imageeditor="gimp"
# webcammanager="guvcview" # SWITCHED TO MPV INSTEAD
displaysettings="xorg-xrandr arandr"
nightlight="redshift-minimal" # AUR
printscreen="maim"
ssh="openssh"
pdfviewer="zathura zathura-pdf-poppler"
unclutter="unclutter"
locate="mlocate"
manuals="man-db man-pages"
documents="libreoffice hunspell-en_us hunspell-hu hunspell-ro texlive-core pandoc sc-im" # AUR
ocr="tesseract tesseract-data-eng tesseract-data-hun tesseract-data-ron" # AUR
# sync="syncthing" # NOT AS USEFUL AS I THOUGHT
fstools="dosfstools mtools simple-mtpfs ntfs-3g" # AUR

SOFTWARE="
    $shell
    $terminal
    $dropdownterminal
    $launcher
    $notifications
    $browser
    $calculator
    $calendar
    $compositor
    $taskmanager
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
    lm_sensors
    xss-lock
    xorg-xset
    xdotool
    xclip
    exa
    playerctl
    imagemagick
    xwallpaper
    wmctrl
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
    acpi_call
    fzf
    cronie
    xorg-xinput
    "

## SET UP THE INSTALL COMMAND
install="paru -Syu --needed
    $ESSENTIALS
    $WM
    $AESTETHICS
    $SOFTWARE
    $DEPENDENCIES
    "

## RUN THE INSTALL COMMAND
$install
