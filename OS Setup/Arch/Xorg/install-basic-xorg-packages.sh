#!/bin/bash

echo 
echo "Installing basic Xorg packages"
echo 
echo

sudo pacman -S pipewire wireplumber alsa-utils pipewire-alsa pipewire-pulse pipewire-jack pavucontrol polkit-kde-agent polkit network-manager-applet blueman playerctl linux-headers xdg-user-dirs xdg-utils bluez bluez-utils bash-completion reflector acpi acpi_call acpid libsecret pass gnome-keyring ttf-font-awesome gvfs nfs-utils xdg-desktop-portal avahi nss-mdns cups arandr xorg xorg-xinit nitrogen picom

yay -S ttf-paratype

echo
echo
echo "Enabling background services"
echo
echo

sudo systemctl enable bluetooth.service
sudo systemctl enable cups.service
sudo systemctl enable reflector.timer
sudo systemctl enable fstrim.timer
sudo systemctl enable acpid
sudo systemctl enable avahi-daemon.service

echo
echo
echo "Creating user directories"
echo
echo

xdg-user-dirs-update

echo
echo
echo "Optimising the mirrorlist for the United Kingdom"
echo
echo

sudo reflector -c "United Kingdom" --latest 20 --sort rate --protocol https --save /etc/pacman.d/mirrorlist

echo
echo
echo "DONE!"
echo
echo

