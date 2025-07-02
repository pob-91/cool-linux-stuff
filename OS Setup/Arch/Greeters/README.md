# Greeters

This file will go over some common greeters that you can use.

## Ly

Ly is a good go to console greeter.

Install: `yay -s ly`

Setup:
```
systemcyl enable ly
```

When you reboot you will be taken to a login screen where you can choose the session type.

This one supports Wayland as well as Xorg sesions.

## QtGreet

This is a nice stylish one that uses `greetd` and and is focused soley on Wayland.

```
pacman -S greetd
yay -S greetd-qtgreet
systemctl enable greetd.service
```

Move the file `./qtgreet/config.toml` to `/etc/greetd/config.toml`

Move the file `./qtgreet/config.ini` to `/etc/qtgreet/config.ini`. **NOTE** this sets up a background image that needs to be moved to `/usr/share/qtgreet/backgrounds` to work and you need to make this file and the image be owned by the greeter user `chown greeter /usr/share/qtgreet/backgrounds/IMAGE....`

**IMPORTANT** QtGreet works with png or svg images. The jpgs in the wallpaper folder here will not work.

**If using sway** move the file `./qtgreet/sway.cfg` to `/etc/qtgreet/sway.cfg` and make sure the owner is the greeter user like above. If using a different wm then [check out the git repo](https://github.com/marcusbritanicus/QtGreet) for more info on how to set up.

## Light DM & Slick Greeter

Another nice pretty one that only works on Xorg.

```bash
pacman -S lightdm lightdm-slick-greeter
yay -S lightdm-settings
systemctl enable lightdm
```

Move the file `./lightdm/lightdm.conf` and `./lightdm/slick-greeter.conf` to `/etc/lightdm`.

You will notice in `slick-greeter.conf` there is a background image path. You will need to put this image into `/usr/share/pixmaps` and make sure it is accessible to the `lightdm` user.

## ReGreet

This one is good for Wayland and is recommended for Hyprland. It uses greetd like QtGreet.

```
pacman -S greetd
yay -S greetd-regreet
systemctl enable greetd.service
```

Then you will need to copy `./regreet/config.toml`, `./regreet/hyprland.conf` and `./regreet/regreet.toml` to `/etc/greetd/`
