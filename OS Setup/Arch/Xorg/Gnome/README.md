# Gnome

Setting up Gnome with Xorg on Arch is actually incredibly simple. Once you've installed the base system follow these steps:

```bash
pacman -S xorg xorg-server gnome
systemctl enable gdm.service
```

Then restart your system and voila! You have Gnome up and running. It would be useful to install some terminal client and browser too before restarting so that you can tinker as you need.

If you want all the extra applications that Gnome has like an email client then install the `gnome-extra` package.

If you want a nice app store experience that pulls directly from the pacman repos and the AUR then consider installing Pamac:

```bash
yay -S pamac-aur
```