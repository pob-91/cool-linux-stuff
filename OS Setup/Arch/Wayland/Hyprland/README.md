# Hyprland

Hyprland is basically a swanky, bleeding edge, Sway. It has lots of animations, curves and shadows that make it more attractive on the eye. Where sway is functional and relatively reliable, Hyprland is beautiful and perhaps less reliable.

You can [check it out here](https://hyprland.org).

### Installation

First make sure the common Wayland programs are installed (see the README in the Wayland folder, you can also use the script here to install them).

Installation is super easy, simply run `pacman -S hyprland alacritty vi firefox`

Typically these guides use `alacritty` as the default terminal emulator however, that requires that the hyprland config file in this folder be used otherwise it will look for `kitty`.

It is also good to have a browser on hand, above we have used firefox. You can always uninstall this later but this is easy access from the default Arch repositories.

### Booting

Like Sway (and others) hyprland is started by simply running the `Hyprland` command. You can automate this by adding the following to a `.bash_profile` file:

```
if [ -z "${WAYLAND_DISPLAY}" ] && [ "${XDG_VTNR}" -eq 1 ]; then
  exec sway
fi
```

NOTE: if you use a greeter (e.g. greetd with ReGreet (recommended)), then this may start Hyprland for you and you will have to remove this from `.bash_profile`.

### Extra Bits

This installation relies on some extra bits to make Hyprland work nice and pretty :). You can use the install script in this folder to install them or take a look and pick and choose.
