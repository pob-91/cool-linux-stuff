# Intro To Linux

Linux is a free and open source computer kernel. It was created and is run by Linus Torvalds. You can see the code that powers it [here](https://github.com/torvalds/linux).

Typically you also need to install many utilities and programs alongside the Linux kernel to make a complete operating system. In its most basic form a Linux based OS also includes the GNU utilities which are a set of programs that perform common actions. For example copying files. A lot of OSes refer to themselves as GNU/Linux in deference to GNU.

What are the benefits of this?

* No individual or corporation controls the Linux kernel in its entirety. Free and open source software is often considered better as it if it goes in a direction you do not like (e.g. gathering personal information without telling you about it), you can become aware of it and either modify it to not do the thing you don't like or use an alternative.
* Typically the best software is open source. This is not a struct rule of course, however, open source software is usually disconected from commercial intersts. Essentially it is a bunch of nerds who enjoy making things and care about the open source movement. Linux based systems are usually faster and more performant than their competitors (e.g. MacOS or Windows).
* Simplicity. Linux is a simpler system to understand and use once you get used to it especually if you are a developer or want to tinker at lower levels.
* Options. There is basically no end to what you can do with Linux based OSes, how you can make them look and feel and behave.
* It's free. Who doesn't like a free lunch!
* The community is huge. Thare are 1000s of different systems built on top of GNU/Linux.

### Flavours

When you install a Linux based system you don't typically get the source code and build and install it unless you are making your own OS or have some very specific requirements. Enter flavours.

The open source community has created 1000s of *flavours* of Linux from the simplest and rawest like Arch Linux or even Alpine (typically only used for servers), to full blown graphical systems that provide more of a MacOS or Windows experience out the box like Zorin, Pop or Ubuntu to name but a few. When you "use Linux" it means that you have researched a flavour that suits your needs and followed the installation instructions.

The flavour system is good because it provides a huge amount of variation, although this can be dauntinf for new users. There are flavours dedicated to gaming, hacking, day to day usage, programming and pretty much any other discipline of which you can think. Some of them are amazing, some are not, some are even downright weird!

### Installing Software

Linux typically uses *package managers* to install software, e.g. apt, pacman, yum e.t.c. You can think of these as utilities that install programs that are normally used via the terminal and their command lines.

There are, however, often GUIs built around these that enable you to have a much more App Store like experience. An example of this is the Gnome Software Center or the Snap Store. Most "off the shelf" systems, like Zorin, Pop or Ubuntu, will come with these GUI versions pre installed so you can interact with them by default.

There are also other ways of installing software for example with App Images, Flathub or Snaps.

### Finding the right distro & flavour

A distro is a significant and unique Linux based OS. A flavour is a slight variation on a distro (look, feel or other setup).

There is no right answer to finding the right distro / flavour, however, there are some useful guidelines you can follow.

Typically you want to stay with one of the big / most popular ones. Using 1 man band or edge distros / flavours can be fun but is usually not a seamless experience and any issues you come up against will probably not be fixed with any urgency if at all.

There are several very well known distros upon which others are based:

**Debian** - one of the oldest and kinda the daddy distro. A lot of other flavours build upon this one. It typically asks you which type of graphical environment you want to install and will do that for you too, although it can be set up without this. This is a particularly stable release, is often used for hosting servers, and prioritises stability above bleeding edge updates. Release cycles are not fixed but tend to be every 2 years. Whilst not the most complex it is also not the most beginner friendly.

**Ubuntu** - one of the most popular and widely used distros. It is based on Debian but also modifies the kernel (??) and so is usually thought of as more of a distro rather than a flavour. The company Canonical is the driving force behind Ubuntu. It doesn't always stick to the ethos of free and open source and so is sometimes rejected by more hardcore Linux enthusiasts. It drives the development of Snap packages and owns and runs the Snap store, again with mixed popularity. Ubuntu, however, is a good starting option for people new to Linux as it is very well supported, has a great community, is widely used and tends to "just work". 

**Arch Linux** - probably the most widely used distro for more technical linux users and those that want to role their own setups (i.e. not have an out the box experience). If you want to build a desktop environment that is truly your own this is probably the one to use. It has a very fast (monthly??) release cycle and is therefore more bleeding edge and is therefore rarely used for servers. It is, however, very well supported and also tends to "just work". It is more complex to set up and unless you get a flavour based on it that automates the process for you, there is a lot more to do yourself. It is not beginner friendly.

**RHEL / Centos** - a more privacy focused distro that has a slightly different file system and uses the *yum* & *dnf* package managers out the box. As of the time of writing RHEL is now not loved in the Linux community as it was purchaed by IBM and has now made the decision to stop being open source. There are flavours / distros based on it, the most notable being Fedora, which is a very accomplished OS. However, outside of the enterprise server use case it is less widely used and has a smaller community. It is more bleeding edge and can provide a very nice user experience, however, on balance, probably one to avoid unless you particularly fancy using it.

**Alpine** - not one to use as your daily desktop, although some nut cases have got that working! This one is here more just for interest. It is becoming more and more popular as a hosting OS especially via Docker virtualisation. This is because it is very small (+- 5MB for an entire OS!), and has a small surface area for attack.

### File System and Booting

Linux based systems tend to follow the Unix file system and layout with some occassional deviations. This is very similar to the MacOS file layout although Apple has deviated quite significantly in recent years and has locked lots of its file system down.

I won't cover the entire file system however important parts to note are:

* `/` - the root path
* `/bin` - this is where a lot of the main system utilities live and are typically managed by the root user
* `/tmp` - a temporary directory that is auto wiped typically after 10 days
* `/etc` - a lot of the system configuration live here
* `/home` - this is where every user's files and folders live. For eaxmple user **ben**'s files will live in `/home/ben`
* `/boot` - this contains files and configs used by the bootloader to start the OS

A lot of flavours set all this up for you automatically including booting, however, some more advanced flavours e.g. Arch Linux require you to do this yourself.

### Users and Groups

Just like any system linux has the idea of users. This is often auto managed and created for you however, again some systems require you to set it up for yourself.

A user typically only has access to the files and folders in their personal home directory but, if set up, can perform root actions using the `sudo` command. There are often graphical ways set up so that a user can give a program elevated permissions without having to use the terminal. A program that, when it installs, has to modify the file system is an example of this.

### More

This is by no means an exhaustive guide but just an intro to some of the key concepts that you may find useful especially of going down the route of using a more self configured / advanced flavour.
