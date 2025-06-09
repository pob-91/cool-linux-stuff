# i3

This file will go through the steps to install the i3 window manager. You can [read more about it here](https://i3wm.org/).

i3 requires Xorg to run. [Sway](../../Wayland/Sway/README.md) is the i3 replacement for Wayland and the config files are (almost) identical which makes it very nice to switch between the two if you need Xorg to user certain apps.

### Installing basic packages

The following items are needed from the standard repo:

* pipewire
* wireplumber
* alsa-utils
* pipewire-alsa
* pipewire-pulse
* pipewire-jack
* pavucontrol
* polkit-kde-agent
* polkit
* network-manager-applet
* blueman
* playerctl
* linux-headers
* xdg-user-dirs
* xdg-utils
* bluez
* bluez-utils
* bash-completion
* reflector
* acpi
* acpi_call
* acpid
* libscret
* pass
* gnome-keyring
* ttf-font-awesome
* gvfs
* nfs-utils
* arandr
* xdg-desktop-portal
* avahi
* dex
* nss-mdns
* cups # for printing
* tlp # for laptop battery management

And from the AUR:

* ttf-paratype

Now we are going to enable some background services to make life easier:

```bash
systemctl enable bluetooth.service
systemctl enable cups.service # if installed
systemctl enable tlp # if installed
systemctl enable reflector.timer
systemctl enable fstrim.timer
systemctl enable acpid
systemctl enable avahi-daemon.service
```

### Modify the Super Key

If you are (like me) using an Apple keyboard and want to remap some of the keys, an effective way of doing this is by modifying the `/usr/share/X11/xkb/symbols/pc` file and you can change the names of the keys around.

You will need to run `rm -rf /var/lib/xkb/*` and reboot the system once done.

You can also / alternatively use the `../.Xmodmap` file. It goes at the user home `~/.Xmodmap`.

### Create User Directories

You can create the standard user directories by running:

```bash
xdg-user-dirs-update
```

### Installing i3

Install the following files from the arch repos:

* xorg
* xorg-xinit
* nitrogen
* picom
* dunst
* scrot
* polybar
* rofi
* redshift
* numlockx
* i3
* i3lock
* ffmpeg

Install the following files from the AUR:

* lux
* ulauncher
* xbanish

Setup rofi, run the scripts in `../rofi-setup`

Make sure to copy over the config files before you start i3. i3 can be started by running the `startx` command as long as the `./.xinitrc` has been moved to `~/.xinitrc`.

### Booting i3

As above sway can be booted manually by using the `i3` command.

You can also:

* Set up a system deamon that starts i3 on boot.
* Add i3 to the `.bash_profile` like so:
```bash
#
# ~/.bash_profile
#

[[ -f ~/.bashrc ]] && . ~/.bashrc

if [[ -z $DISPLAY ]] && [[ $(tty) = /dev/tty1 ]]; then
	exec startx
fi
```
* Start it from a display manager. Most display managers support Xorg, my favourite is [lighdm with the slick-greeter](../../Greeters/README.md).