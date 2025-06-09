# Sway On Arch Linux

This file will go through installing the Sway Window Manager on Arch Linux. For more info about it [see here](https://swaywm.org/).

Sway is a wayland based WM and so is slightly simpler to set up than an Xorg based one, however, it requires a very different list of things to make it work. With some overlaps.

### Installing Sway

First make sure the common Wayland programs are installed (see the README in the Wayland folder, you can also use the script here to install them).

Install the following files from the arch repos:

* sway
* swaybg
* swayidle
* waybar
* wofi
* dunst
* grim
* slurp
* swappy
* wf-recorder

Install the following files from the AUR:

* swaylock-effects-git
* wlsunset
* lux
* ulauncher

Make sure to copy over the config files before you start sway. Sway can be started by running the `sway` command.

### Booting Sway

As above sway can be booted manually by using the `sway` command.

You can also:

* Set up a system deamon that starts sway on boot.
* Add sway to the `.bash_profile` like so:
```
if [ -z "${WAYLAND_DISPLAY}" ] && [ "${XDG_VTNR}" -eq 1 ]; then
  exec sway
fi
```
* Start it from a display manager. Quite a few display managers do not support wayland yet however there are some that work. [See greeters](../../Greeters/README.md).
