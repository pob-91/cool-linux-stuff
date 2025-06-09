# Arch Linux

This section will document installation of the Arch Linux base system. It will not go into installation of any desktop environments or graphical elements.

There are lots of ways to setup an Arch installation when it comes to partitioning, formatting e.t.c. This repo provides 2 wasys:

* [Simple](./SIMPLE.md)
* [Advanced](./ADVANCED.md)

Check out each file to see what will be installed and set up before you choose a direction.

Prior to installing you will need to [download an arch iso](https://archlinux.org/download/) and create a bootable usb (see README in OS Setup).

## Common Actions

There are some common actions that you will perform when installing Arch.

### Connect to WIFI from the ISO environment

If you are installing on a machine with a wired connection you do not need to follow this step.

Use `iwctl` to connect to wifi. The commands are:

```
iwctl # enters the iwd environment
station wlan0 scan # scans for networks
station wlan0 get-networks # lists out the networks nearby
station wlan0 connect "NETWORK_NAME" # connects to a network
```

### Partitioning disk with gdisk

Find your disks with `fdisk -l`, it could be something like `/dev/sda` or `/dev/nvme0n1`. Make sure that you perform the next steps on the right disk as it will overwrite any data.

Partition the disk with `gdisk` by running the command `gdisk /dev/DISK`. This will enter the `gdisk` environment and the following is a list of commands to use.
```
# create the boot partition
n # create new partition
# partition no 1
# default first sector
# last sector +300M
# hex code ef00

# create the swap partition
n # create new partition
# partition no 2
# default first sector
# last sector +4G
# hex code 8200

# create the root partition
n # create new partition
# partition no 3
# default first sector
# default last sector which will fill up all remaining space
# hex code default (Linux filesystem)

w # write the changes to the disk 
# confirm that you want to proceed with destructive action
```

### Setting Timezone in arch-chroot

You need to tell the new installation where you are. This is broken down into larger regions and then subregions, e.g. I am in `Europe/London`.

To list all major regions run: `ls /usr/share/zoneinfo`.

Then to list all subregions in a major region run `ls /usr/share/zoneinfo/Europe` replacing `Europe` with your region.

Once you have the path to your local timezone set it by running:
```
ln -sf /usr/share/zoneinfo/Europe/London /etc/localtime
```

Again replacing the regions with the ones relevant to you.

### Setting Locales in arch-chroot

This tells the system which date formats, e.t.c to use based on regional preference. For these examples I am using `vim` but any console based text editor like `nano` is fine.

Open `/etc/locale.gen` and find your locale. With vim you can do press / and then type a phrase to match and then hit Enter when you've found it. As I am based in the UK I will uncomment the line `en_GB.UTF-8 UTF-8`

If you want to play games or install things like Steam you also want to enable the American locales `en_US.UTF-8 UTF-8`

When done you generate these locales by running `locale-gen`.

Then to tell the system which locale to load at boot time run:
```
echo "LANG=en_GB.UTF-8" >> /etc/locale.conf
```

Replacing the value with your chosen locale.

### Create a hostname

The name of your machine needs to be saved like so:
```
echo "machine-name" >> /etc/hostname
```

Where machine name is the name of the computer like `latop` or `work`.

### Setup hosts file

You need to setup your hosts file to enble local address resolutions e.g. localhost. You can do this with vim or by echoing the following to the file:

```
127.0.0.1   localhost
::1         localhost
127.0.1.1   hostname.localdomain    hostname
```

Replace `hostname` with the name from the above section.

### Setup users

This will set a password for the root user and also create a new user that has access to root actions via `sudo`. A couple of things to note:

* For simplicity and security some people prefer `doas` to `sudo`
* When creating a user, for higher security do not use your name.
* Consider locking the root user (see below), for security.

```
passwd # assuming currently logged in as root this will prompt to change the root password
useradd -m user # add a user called user
usermod -aG wheel user # add user to the wheel group
passwd user # set a password for the new user
```

Setup sudo

```
pacman -S sudo
EDITOR=vim visudo (can change vim to nano here)
```

Edit the sudoers file with the above command and uncomment the line: `%wheel ALL(ALL:ALL) ALL`

Optionally lock the root user: `passwd -l root`. **NOTE**: Do this when logged into a user account not the root account.

### Connecting to the internet with Network Manager

Both guides suggest installing and enabling network manager as part of the setup. Once you have logged into a network with Network Manager it will remember it and if you are in range again it will connect as you would expect from a computer.

Network Manager ships with `mntui` which is s console tool to connect to networks. In the terminal run `nmtui` and follow the instructions to activate a connection.

### Seting up other package managers

Arch by default only ships with `pacman` as a package manager which taps into the official arch repositories. This is fine for a lot of stuff however, you will likely want software that is in the Arch User Repository and even the Chaotic Arch User Repository.

Note that this can pose a security concern. Most users are fine using these other repositories, however if you are working on a secure system then consider installing software that is not in the default repos from source.

To set up `yay` which is an installer of software from the AUR (others are available):

```
git clone https://aur.archlinux.org/yay.git
cd yay
makepkg -si
cd ..
rm -rf ./yay
```

You can use `yay` like pacman e.g. `yay -S package_name`.

To set up the chaortic AUR first [go here](https://aur.chaotic.cx/) and follow the instructions there.

### Using different kernels

This guide sets up your system with the standard mainline `linux` kernel, however, there are other options that can be used if required. A good example is `linux-zen` which is a streamlined kernel that sacrifices power for better performance. If you want top performance for gaming or AV other other operations this could be a good option.

In order to switch, first install the kernel of your choice e.g.: 

```
sudo pacman -S linux-zen linux-zen-headers
```

Then make sure that the grub config is set up as you want it (see note above) and run:

```
sudo grub-mkconfig -o /boot/grub/grub.cfg
```

When you next reboot you will see the grub menu with all installed kernels as options, you may need to go into advanced options to select up the new kernel the first time around.

**NOTE**: If you have an nvidia GPU and are using linux-zen, especially on single GPU systems, you will need to configure your drivers and `mkinitcpio.conf` properly otherwise no displays may be found.

This is quite an involved process (although not too complex) and the best thing to do is [follow the instructions here](https://wiki.archlinux.org/title/NVIDIA). You will need the `nvidia-dkms` package with custom kernels like zen. Self compiled kernels are different again. Unless you particularly hate closed-source, I would recommend using the propriatery NVIDIA drivers.

### Optimising the pacman mirrorlist

You can optimise the pacman mirror list and speed up installations using `reflector`:

```
reflector -c "United Kingdom" --latest 20 --protocol https --sort rate --save /etc/pacman.d/mirrorlist
```

Just change "United Kingdom" to whatever region you are in to get the fastest mirrors for there.