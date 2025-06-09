# Graphics

This file will cover some common tasks to get graphics working on Arch. It will not go into how to install desktop environments.

## Window Servers & Window Managers

Some OSes and Linux distros come fully bundled up so that in a single installation you get all base OS, graphical elements, common apps (e.g. text editors) installed in one go. Examples of this are Pop! OS or Zorin OS. This is clearly not what we are going for here.

A graphical desktop environment is made up of many working parts, however, two of the most important are window servers and window managers.

### Window Servers

You can think of window servers as programs that expose a bunch of APIs that enable other programs to draw items on the screen. These are essentially graphics calls but focused on window management. 

There are 2 main ones used in Linux distros: Xorg and Wayland.

Xorg is the older window server and still has the most compatability, if you are only concerned about stability and compatability then Xorg is probably still the choice for you. However, Wayland is fast becoming the new standard and only some applications still do not support it (most notably those that have screen sharing as part of their feature set). Most distros ship with support for both but default to using Wayland unless the user changes it.

Wayland is the more performant of the two and is slightly simpler to set up and use (depending on which window manager you choose).

### Window Managers

Window managers are programs that make calls to the window server to tell it how and where to place windows on the screen. These are the parts of the desktop environment that control the look and feel of the experience. Typically most consideration will go into choosing the window manager when setting up a desktop environment from scratch.

## GPU Support

For best experience using a graphics environment, clearly setting up the GPU is a boon.

GPU support on linux is a whole thing and I will not get into details right now. Just let it be said that you are best of with an AMD GPU.

**For AMD**, first install the drivers:

```
pacman -S xf86-video-amdgpu
```

then edit the `/etc/mkinitcpio.conf` file and add the `amdgpu` to the modules array:

```
MODULES=(amdgpu)
```

remember not to remove any existing items in this array.

Then remake your linux kernel image:

```
mkinitcpio -p linux # replace linux here with any other kernel you installed
```

**For NVIDIA**, install the following:

```
pacman -S nvidia nvidia-utils nvidia-settings
```

Then as above edit the `/etc/mkinitcpio.conf` file but add  `nouveau` to the modules. Then again, as above, remake the kernel image.

**NOTE**: Nvidia setup can be more finley tuned and needs to be in order to use kernels like linux-zen. See the Kernels section in the [Arch -> README.md](../README.md) for more info on this.

## Gaming

Steam should work fine on all these systems and can be used with Proton e.t.c. like any other linux gaming setup.

For hybrid GPUs - by default the integrated GPU will be used. This is not what we want!

To make use of the discrete GPU for games we need to use the `DRI_PRIME=1` variable. In steam you can edit a game's options and set the command to be:

```
DRI_PRIME=1 %command%
```

This will start the game using the discrete GPU. [Check here for more details on using PRIME](https://wiki.archlinux.org/title/PRIME).

For Steam - if you want a game to run using OpenGL you can use the steam command:

```
PROTON_USE_WINED3D=1 %command%
```

Steam commands can be combined.

You can also look at using `wine` directly and installing helpers like `lutris`. Check out the Arch Wiki and the lutris home pages for more info on this.

### Steam

A note on how to set up Steam if you want to play games. Linux has better game support than Mac but most PC games are still made for Windows only. There are really good compatibility layers but they sometimes have issues, especially with the newer titles. Older titles should work fine.

To install steam [enable the multilib repository](https://wiki.archlinux.org/title/Official_repositories#multilib) and run `pacman -Sy`.

You must have enabled GPU support with the right divers as per the section on GPU Support above.

You need to generate the US locale. Modify `/etc/locale.gen` as per the [arch installation instructions](../README.md) and uncomment the en_US.UTF-8 locale and then re run sudo locale-gen.

Install the correct fonts: `pacman -S ttf-liberation`.

Then install Steam `pacman -S steam`. You should restart your computer and then you are good to go.

Once you have signed into steam, you want to go to the settings and enable Steam Play (proton). This is the compatibility layer so you can play Windows games on Linux. [Check here for more on Proton](https://www.protondb.com/).

## Backlight

Backlight is normally controlled via a user tool called `lux` that relies on the `/sys/class/backlight` file to be present. For some systems (e.g. desktops with external monitors) it is not present and the backlight values have to be written directly to the screen via a hardware interface.

One common method is to use `ddcutil` which requires the `i2c-dev` kernel module to be loaded:

* Ensure i2c-dev is installed: `pacman -S linux-api-headers`
* Set the i2c-dev module to be loaded with the kernel: edit `/etc/mkinitcpio.conf` and add `i2c-dev` to the modules array. If you already have some modules loaded e.g. for graphics it should look like `MODULES=(CARD i2c-dev)`
* Run `mkinitcpio -p linux` (if you are using a different kernel e.g. zen then replace linux with the name of it).
* The command to increase or decrease backlight with this method is `ddcutil setvcp 10 +- 5`. This assumes that 10 is the backlight control and 5 is the amount to increase or decrease. You can run `ddcutil capabilities` to list out all the command codes. You want the (Brightness) capability.