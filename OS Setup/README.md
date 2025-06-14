# OS Setup

This repo currently documents the setup of the following distributions:

* Arch Linux
* Alpine Linux - TODO
* Debian (base) - TODO
* Kali Linux - TODO
* Void Linux - TODO

There are various GUI heavy distributions that will not be documented here as the process is very simple:

* Ubuntu
* Fedora
* Zorin
* (you get the idea)

This repo will not look at RHEL or any derivatives as it is not widely used outside of corporate systems and has also sparked controvosy recently.

## Bootable USBs

Typically modern vendors do not provide an option to ship machines with a Linux distro pre-installed. This means that you will need to be able to both create a bootable USB and also boot from it.

### Getting a Boot ISO

This is dependent on the disto but is typically downloaded fron the distro's website.

### Creating a Bootable USB

There are several tools out there that are GUIs to create bootable USBs, my favourite of these is Balena Etcher. However, the simplest way to do it is using `dd`:

Find the path **by id** of the USB disk: `ls -l /dev/disk/by-id/usb-*`

```
sudo dd if=/path/to/iso of=/path/to/disk-by-id bs=1M status=progress
```

### Booting from the USB

This depends on your computer. Most systems will lock this feature by default which is annoying. There will be a key to press on start up e.g. F2 that will open the BIOS settings for your machine, in these settings you will be able to enable booting from an external drive.

Once this has been done you can reboot and tap another key e.g. F9 which will show a list of bootable drives and you should see your bootable USB listed.

This is probably the biggest barrier for getting non technical users to start using Linux distros.

### Updating your keboard layout

If like me you are on a Mac(GB) keyboard you may find that where you are used to the control (CMD) key is now a super key. To switch CMD and CTRL you can edit the file at:

```
/usr/share/X11/xkb/symbols/pc
```

and switch around the super and control keys (literally just change their names).

Save this and then run:

```sh
sudo rf -rf /var/lib/xkb/*
```

Reboot your system and your keys will be swapped.
