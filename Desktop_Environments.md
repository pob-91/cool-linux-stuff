# Desktop Environments (DEs)

What most people don't realise is that when you power on, for example, an Uubntu powered computer. A lot of programs and services start that, when all combine together, create the Ubuntu experience. Very simply these are:

* The kernel - the interface between software and hardware.
* System utilities - e.g. GNU utilities, networking utilities, bluetooth, inter proces communications e.t.c.
* A window server - this is a program that recives instructions from other programs to draw things (typically windows) on the screen. In the Linux world there are 2 main ones: Xorg and Wayland.
* A window manager - a programm that actually decides which windows are drawn on the screen, where they are, how you interact with them e.t.c. There are quite a few types.
* Desktop utilities - this is usually stuff like a settings program, wallpapers, start and menu bars e.t.c
* Software suites - most desktop environments come with a suite of software pre bundled, sometimes (e.g. Windows and MacOS) you cannot even uninstall this stuff. E.g. calculator, weather, emails, browser, e.t.c.


### Out the box

A lot of linux distros give you an "out the box" experience. This means that everything mentioned above is installed automatically when you install the distro and there is a nice graphical installer that will help you through the process. This is often the experience that most people want.

Some distros like PopOS and Zorin OS have their own desktop environments and that is what you are stuck with with them. This is the MacOS or Windows experience. This offers the least fuss and gets you up and running smoothly.

The following are some of the most popular or well known desktop environments tyoically used in other out the box distros. For example with ubuntu, whilst Gnome is its flagship, you can choose to use many others ([see here](https://ubuntu.com/desktop/flavours)).

**Gnome** - this is a very widely used DE and is ofteh the flagship for distros like Ubuntu and Fedora. It can be installed pretty much anywhere so you could use Arch Linux with Gnome. It provides a more MacOS like look and feel.

**KDE Plasma** - Another very popular one. Linux users tend to be either in the Gnome or KDE camp unless they roll their own. A very sophisticaed DE with more configuration options. It is slightly harder to learn to use well but worth the investment in time. It offers a more Windows like experience.

**Mate** - This DE is the continuation of Gnome 2 which many people consider to be Gnome's pinnacle after which it collapsed somewhat for a while although in recent years it has become very popular again. It is a good DE, however, looks a feels quite dated, probably something more akin to Windows 2000.

**LXDE & LXQt** - These are lightweight DEs that are designed to breathe new life into older machines and have a focus on using fewer resources. As a result, whilst they work well they don't have the visual appeal of something shiny like Gnome. They will appeal to much more minimalstic or "old school" stlye lovers or those that have a slow old computer. This is really where they shine. A sluggish 10 year old Mac can feel light and snappy again running one of these.

**Xfce** - Another lightweight DE but not as light as LXDE and LXQt. Xfce sacrifices a bit more performance to get some shinyness back.

As a new user (or even a veteran), either Gnome or KDE are the go tos. The quickest way to get set up would be to use a distro like Ubuntu or if you want to avoid Snaps and Canonical, use one like EndeavourOS (Arch based).

### Roll your own

There is a lot of power that comes from setting up your own DE but getting it right can take time and there are often hurdles that have to be overcome. For this reason it is usually only more hardcore enthusiasts and those more comortable with Linux that go this direction.

Many of the setups mentioned here can be automated and there are distros like Garuda Linux, that will do a lot of it for you and will install less well known window managers like i3 (one of my faves). However, they are opinionated and the whole point of this part is to set up the system to be *exactly* as you want it so I would tend to go the roll your own route rather than use a distro / flavour that has got something close.

In reality with roll your own systems you have 2 main choices to make:

* Which window server will I use?
* Which window manager will I use?

There are lots of other bits of software you can choose to use or not e.g. email client or document viewer, however these are side points to the 2 main ones above.

### Xorg & Wayland

Xorg & Wayland are window servers. Xorg is the old daddy and Wayland is the new kid on the block. 

As you might expect Xorg is very reliable and well supported. Things that you would expect to work like screen sharing, windows running smoothly and with no stuttering e.t.c tend to work out the box woth Xorg. There are some applications that have yet to support Wayland at all.

Wayland, on the other hand, is new and less supported. However, offers a lot more "new stuff" out the box which you have to use 3rd parties or hacks to get Xorg to do. Things like transparency, animations e.t.c are things that Xorg still thinks of as new and challenging whereas Wayland has this all built in from the word go.

If you want certain support and fewer headaches then Xorg is still probably the way to go, however, many of the latest distros mentioned above e.g. Ubuntu with Gnome, now default to using Wayland whereas not that long ago that was Xorg. It won't be much longer before Wayland is the default everywhere and Xorg becomes legacy. As of writing I use both interchangably.

### Window Managers

TODO: Write overview of different typpes: standard, tiling, e.t.c. research some

Do an overvoew of some popular ones

Finih this page with the fact that more info is in each specific sub folder
