#!/bin/bash

echo 
echo "Installing basic Wayland packages"
echo 
echo

sudo pacman -S qt5-wayland qt6-wayland pipewire wireplumber alsa-utils pipewire-alsa pipewire-pulse pipewire-jack pavucontrol polkit-kde-agent polkit network-manager-applet blueman playerctl wl-clipboard linux-headers xdg-user-dirs xdg-utils bluez bluez-utils bash-completion reflector acpi acpi_call acpid libsecret pass gnome-keyring woff2-font-awesome otf-font-awesome gvfs nfs-utils xdg-desktop-portal-wlr xdg-desktop-portal xorg-xwayland avahi nss-mdns cups wmname noto-fonts noto-fonts-cjk noto-fonts-emoji noto-fonts-extra

yay -S ttf-paratype wdisplays

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
