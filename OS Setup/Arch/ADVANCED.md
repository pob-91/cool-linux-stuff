# Arch Linux Simple Installation

This setup is going to be relatively similar to the simple setup but with the following key differences:

* Using btrfs instead of ext4 [see here for key differences](https://www.geeksforgeeks.org/difference-between-ext4-vs-btrfs-filesystems-in-linux/).
* Setting up entire root disk encryption
* Setting up swap disk encryption
* More security focus with tools like `apparmor`

If you are a more security and performance oriented user then this is the the one to follow.

**NOTE:** A lot of this is taken from an excellent [YouTube video here](https://www.youtube.com/watch?v=co5V2YmFVEE).

So let's get going! Steps:

* Boot from Arch ISO boot USB

* Ensure connected to a network - see arch README.md

* Sync the clock 

`timedatectl set-ntp true`

* Partition the root disk - see arch README.md

* Format boot and swap paritions we have just created.

To see the new paths to the partitions we have created run `fdisk -l` again. The paths will be something like `/dev/sda1`, `/dev/sda2` e.t.c where the number refers to the partition from the above commands.

Format boot and swap partitions: 
```
mkfs.fat -F32 /dev/DISK1
mkswap /dev/DISK2
swapon /dev/DISK2 # we will encrypt this later
```

* Encrypt the root parition

```
cryptsetup luksFormat /dev/DISK3 # this will ask you for an encryption password
```

This action can take a couple of seconds depending on disk size and CPU.

Remember that if you lose your password then this disk is lost so use one that you are not going to forget!

In order to work on the parition we need to open it:

```
cryptsetup luksOpen /dev/DISK3 NAME # this will ask for the password and take a few seconds to run
```

The `NAME` here is the alias or name of the device so you can read and write data to it. Normally you would use the disk path `/dev/DISK3` but with encryption you need to write via an aliase at `/dev/mapper/NAME`. An example name is `cryptroot` or just `root`.

* Format the root parition

```
mkfs.btrfs /dev/mapper/NAME
```

* Mount the partitions and setup btrfs volumes

Unlike `ext4` `btrfs` has support for subvolumes e.t.c.

**NOTE**: If you are installing arch onto an SSD then with the mount options for `btrfs` add the `discard=async` option too.

```
mount /dev/mapper/NAME /mnt
cd /mnt
btrfs subvolume create @ # creates the root volume at /
btrfs subvolume create @home # creates the home volume at /home
cd
umount /mnt
mount -o noatime,compress=zstd,subvol=@ /dev/mapper/NAME /mnt # mount the root subvol to /mnt
mkdir /mnt/home
mount -o noatime,compress=zstd,subvol=@home /dev/mapper/NAME /mnt/home # mount the home subvol to /mnt/home
mkdir /mnt/boot
mount /dev/DISK1 /mnt/boot # mounts the boot partition to the boot directory 
```

You can check all this worked by using `lsblk`.

* Install Arch base system

```
pacstrap /mnt base linux linux-firmware amd-ucode/intel-ucode vim git networkmanager base-devel btrfs-progs
```

**NOTE:** You will need to choose either amd-ucode or intel-ucode depending on your CPU.

* Generate the file system table

```
genfstab -U /mnt >> /mnt/etc/fstab
```

* Enter the new installation, enabling us to install tools and configure things as a root user

```
arch-chroot /mnt
```

* Setup your timezone - see arch README.md

* Sync the system clock

```
hwclock --systohc
```

* Setup locales - see arch README.md

* Setup hostname - see arch README.md

* Setup hosts file - see arch README.md

* Setup users - see arch REDAME.md

* Edit the mkinitcpio file

We need to setup some modules and hooks and regenerate the boot image to be able to use encryption properly from boot.

Edit `/etc/mkinitcpio.conf`

`btrfs` should be added to modules: `MODULES=(btrfs)`

Add `encrypt` to the HOOKS just before the `filesystems hook`.

Run:
```
mkinitcpio -p linux # if you are using a different kernel replace linux with the name of that one
```

* Setup grub

Install the following packages: `grub grub-btrfs efibootmgr dosfstools os-prober mtools`. 

`os-prober` allows grub to search for other bootable disks and add them to the grub menu, this is useful if you want to dual boot your system and is not needed if you do not want to do this. Edit the grub default config file at `/etc/default/grub` and uncomment the line `GRUB_DISABLE_OS_PROBER=false`, if you want to enable `os-prober`.

We also need to add some kernel parameters around encryption to the grub config. We need to add the UUID of the encypted disk to tell grub which disk should be unlocked at boot time. To get the UUID run `blkid` and find the ID of the `/dev/DISK3`. ***NOT /dev/mapper/NAME***. If you cannot copy and paste yet or even have a mouse(!) then you can run `blkid | grep DISK3 >> /etc/default/grub` to append the uuid to the bottom of the grub config file and then you can use nano or vim to move it around.

Now edit `/etc/default/grub` and add to the `GRUB_CMDLINE_LINUX_DEFAULT` arg:

```
GRUB_CMDLINE_LINUX_DEFAULT="loglevel=3 quiet cryptdevice=UUID=#UUID:#NAME root=/dev/mapper/#NAME"
```

Replace `#UUID` with the UUID from `blkid` and replace `#NAME` with the mapper name you set up above for encypting the partition.

Run:
```
grub-install --target=x86_64-efi --efi-directory=/boot --bootloader-id=GRUB
grub-mkconfig -o /boot/grub/grub.cfg
```

***IMPORTANT***: On certain systems (e.g. MSI motherboards) the boot file is not recognisable unless it is specifically installed at: `/EFI/boot/bootx64.efi`
normally grub installs at a different path / name and then registers the boot file so that it is picked up later.

If you are on a system that needs this default path then add the `--removable` flag which will ensure that the boot file is installed
in the default place.


* Setup network manager 

`systemctl enable NetworkManager`

* Exit the chroot

`exit`

* Unmount

`umount -l /mnt`

* Reboot

`reboot`

* Setup swap encryption

If you have logged in as the user you set up then you may find it useful to become root for this next part by running `su`.

We are going to set up the swap partition to be encrypted by a random password generated by `/dev/urandom`. The partition will be opened and mounted to the mapper path like the root one for use when active, however, when shut down, all the data there will be encypted. This will then be overwritten and re encrypted when we boot up again.

```
swapoff /dev/DISK2
# this formats 1M of the swap partition to give it a label that can be reused
mkfs.ext2 -L LABEL_NAME /dev/DISK2 1M # replace LABEL_NAME with an appropriate name
```

Edit the `/etc/crypttab` file, uncomment the `swap` line and set it to:

```
swap    LABEL=LABEL_NAME    /dev/urandom    swap,offset=2048,cipher=aes-xts-plain64,size=512
```

Now edit the `/etc/fstab` file and on the swap line remove UUID and replace it with the mapper root `/dev/mapper/swap`:

```
# /dev/DISK2
/dev/mapper/swap    none    swap    defaults    0 0 
```

You can check that all this worked by running `mount -a`. If there are no errors printed then all is good.

Now you should be able to reboot the machine and the swap parition will be mounted automatically un the encrypted mapper path.

* App armor

To install apparmor run 

```
pacman -S apparmor
systemctl enable apparmor.service
```

You need to add `ammarmor` to the `lsm` kernel paramter. To see the existing value run `cat /sys/kernel/security/lsm`. The new value will probably look something like: `lsm=landlock,lockdown,yama,integrity,apparmor,bpf`.

You can add this by adding to the end of the `GRUB_CMDLINE_LINUX_DEFAULT` in `/etc/default/grub` like we did above. Remember not to remove any other parts already in there.

* Firewall

If you want a firewall set up you can run `pacman -S firewalld` and run `systemctl enable firewalld.service`. You can then control rules using the `firewall-cmd` command line utility. The `firewall-config` program is a GUI for this.

* You are now good to go!