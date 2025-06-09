# KDE

KDE and its desktop environment is perhaps the most complete for Linux. Fortunately installing it on Arch Linux is relatively simple:

```bash
pacman -S plasma sddm sddm-kcm
systemctl enable sddm.service
```

Plasma comes with an app store that uses Flatpak under the hood. This is fine, although pacman / yay packages are typically much faster to load and run. It may be worth installing your favourite programs first before rebooting.

If you want a nice app store experience that pulls directly from the pacman repos and the AUR then consider installing Pamac:

```bash
yay -S pamac-aur
```