# Wayland DEs

When using Wayland DEs there are some common programs that should be installed that make up basic services for your desktop environment.

### Installing Basic Packages

The following items are needed from the standard repo:

* qt5-wayland
* qt6-wayland
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
* wl-clipboard
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
* wdisplays
* xdg-desktop-portal-wlr
* xdg-desktop-portal
* xorg-xwayland
* avahi
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

### Create User Directories

You can create the standard user directories by running:

```
xdg-user-dirs-update
```