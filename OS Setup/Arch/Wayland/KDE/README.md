# KDE

Fortunately KDE also supports Wayland as well as Xorg, although the `plasma` package will install Xorg and all its dependencies 

```bash
pacman -S plasma sddm sddm-kcm plasma-wayland-session
systemctl enable sddm.service
```

When you log in just make sure the Wayland session is selected in the drop down menu.

Plasma comes with an app store that uses Flatpak under the hood. This is fine, although pacman / yay packages are typically much faster to load and run. It may be worth installing your favourite programs first before rebooting.

If you want a nice app store experience that pulls directly from the pacman repos and the AUR then consider installing Pamac:

```bash
yay -S pamac-aur
```