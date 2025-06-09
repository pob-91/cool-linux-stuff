# Gnome

Gnome now defaults to Wayland and includes a wayland compositor out the box. This means that you can get going simply by running:

```bash
pacman -S gnome
systemctl enable gdm.service
```

and then rebooting your system.

Simmilar to Gnome on Xorg you should probably install a browser and terminal emulator before rebooting. If you want the extra applications that Gnome provides then install the `gnome-extra` package.