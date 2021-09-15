#!/bin/bash

## INSTALL BASE-DEVEL GROUP (IF IT ISN'T ALREADY)
sudo pacman -S --needed base-devel

## INSTALL PARU
sudo pacman -S --noconfirm --needed git && git clone https://aur.archlinux.org/paru-bin.git /tmp/paru-bin && cd /tmp/paru-bin && makepkg -si && cd

## ESSENTIALS
xorg="xorg-server xorg-xinit"
gpu="xf86-video-intel"
wifi="broadcom-wl"
audio="pulseaudio pulseaudio-alsa"
touchpad="libinput"
batterysaver="tlp"
bluetooth="bluez bluez-utils bcm43142a0-firmware" # AUR PACKAGE
backlight="acpilight"
fonts="ttf-dejavu terminus-font" # Terminus as monospace font

ESSENTIALS="
    $xorg
    $gpu
    $wifi
    $audio
    $touchpad
    $batterysaver
    $backlight
    $bluetooth
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
gtktheme="lxappearance" # MANTIS NIGHT THEME FROM MY GITHUB

AESTETHICS="
    $iconfonts
    $emojifonts
    $icontheme
    $gtktheme
    "

## SOFTWARE
shell="zsh"
# terminal="alacritty" # CLONE ST BUILD
# dropdownterminal="tdrop-git" # DOESN'T BUILD FROM AUR
# launcher="dmenu" # CLONE DMENU BUILD
notifications="libnotify dunst"
browser="brave-bin"
compositor="xcompmgr"
taskmanager="htop"
audiomixer="pulsemixer"
filemanager="ranger ueberzug dragon-drag-and-drop"
mediaplayer="mpv"
musicplayer="mpd ncmpcpp mpc"
imageviewer="sxiv"
imageeditor="gimp"
# webcammanager="guvcview" # SWITCHED TO MPV INSTEAD
displaysettings="xorg-xrandr arandr"
nightlight="redshift-minimal"
printscreen="maim"
ssh="openssh"
pdfviewer="zathura zathura-pdf-poppler"
unclutter="unclutter"
locate="mlocate" # sudo updatedb
manuals="man-db man-pages"
documents="libreoffice hunspell-en_us hunspell-hu hunspell-ro texlive-core pandoc"
ocr="tesseract tesseract-data-eng tesseract-data-hun tesseract-data-ron"
# sync="syncthing" # NOT AS USEFUL AS I THOUGHT
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
