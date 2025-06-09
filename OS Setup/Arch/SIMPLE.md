# Arch Linux Simple Installation

This install guide is going to set up a basic Arch Linux environment. It will install it on 1 disk with a 300Mb boot partition, 4G swap partition and one root partition that will take up the remaining space.

We are going to use the ext4 filesystem which is very popular for Linux users.

We are also going to assume that you are on an EFI system and that all these commands are run as the root user.

So let's get going! Steps:

* Boot from Arch ISO boot USB

* Ensure connected to a network - see arch README.md

* Sync the clock 

`timedatectl set-ntp true`

* Partition the root disk - see arch README.md

* Format partitions we have just created.

To see the new paths to the partitions we have created run `fdisk -l` again. The paths will be something like `/dev/sda1`, `/dev/sda2` e.t.c where the number refers to the partition from the above commands.

Format boot, swap and root partitions: 
```
mkfs.fat -F32 /dev/DISK1
mkswap /dev/DISK2
mkfs.ext4 /dev/DISK3
```

* Turn on the swap partition

`swapon /dev/DISK2`

* Mount partitions for installation

```
mount /dev/DISK3 /mnt # mounts the root partition to the /mnt folder
```

* Install Arch base system

```
pacstrap /mnt base linux linux-firmware amd-ucode/intel-ucode vim git networkmanager base-devel
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

* Mount the boot partition

We need to mount the `/boot/EFI` folder to the boot partition we set up at the start.

```bash
mkdir /boot/EFI
mount /dev/DISK1 /boot/EFI
```

* Setup grub

Install the following packages: `grub efibootmgr dosfstools os-prober mtools`. 

`os-prober` allows grub to search for other bootable disks and add them to the grub menu, this is useful if you want to dual boot your system and is not needed if you do not want to do this. Edit the grub default config file at `/etc/default/grub` and uncomment the line `GRUB_DISABLE_OS_PROBER=false`, if you want to enable `os-prober`.

Run:
```
grub-install --target=x86_64-efi --bootloader-id=grub_uefi
grub-mkconfig -o /boot/grub/grub.cfg
```

* Setup network manager 

`systemctl enable NetworkManager`

* Exit the chroot

`exit`

* Unmount

`umount -l /mnt`

* Reboot

`reboot`

* Login 

Then you should be able to log in as the user you set up! See arch README.md for connecting to the internet using NetworkManager on your first user login. You will of course still have to use the system through the terminal however, you are now setup and ready to install whatever you want!