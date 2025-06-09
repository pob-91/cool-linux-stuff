# Dev

This file will go through setting up common dev tools in Arch Linux.

## VPN

To set up an openvpn client install `networkmanager-openvpn`. An extra menu will be added to the tray icon that will let you set up VPN connections.

Use the `openvpn-ubuntu-install.sh` file to auto set up an OpenVPN server on ubuntu. Or use a different distro and use this as information.

## JQ

A useful JSON parsing program for the CLI is `jq`.

## AWS

You can install the `awscli` straight from pacman.

## Dotnet

You can install the latest dotnet sdk with:

```bash
pacman -S dotnet-sdk aspnet-runtime
```

## Node

Arch has the latest nodejs and also the lts versions e.g. iron:

```bash
pacman -S nodejs-lts-iron npm
mkdir ~/.npm-global
npm set prefix '~/.npm-global'
```

## Python

The Arch installation will come with the latest version of python3. You can install older version e.g. 3.9 from the AUR like:

```bash
yay -S python39
```

You may also want to install pip (the python package manager):

```bash
pacman -S python-pip
```

## Java

This can be installed from the openjdk:

```bash
pacman -S jdk17-openjdk maven
```

You can install the latest version or many of the lts versions as above.

## Docker

First you need to [go here](https://wiki.archlinux.org/title/Linux_Containers#Required_software) and follow the instructions but don't bother with the delegate stuff.

Then follow the [arch instructions here](https://docs.docker.com/engine/security/rootless/).

Then enable the service, install buildx and remember to export the DOCKER_HOST.

```bash
systemctl --user enable docker.service
systemctl --user start docker.service
pacman -S docker-buildx
```

**NOTE** the `DOCKER_HOST` and many other useful variables are exported in the `.bashrc` file in this folder.

## Git

Git is part of the base install. However to set it up:

```bash
pacman -S meld
git config --global email "EMAIL"
git config --global name "NAME"
git config --global credential.helper libsecret
git config --global diff.tool meld
git config --global merge.tool meld
```

## Modify the max file watches

IDEs and other dev processes often rely on watching the statuses of lots of files. To enable this, edit the `/etc/sysctl.conf` file and add the line:

```
fs.inotify.max_user_watches = 524288
```

Then run `sysctl -l --system`.

## Docker credential storage

Run the following to setup credential storage for docker, remember to get the link to the docker credential helper download:

```bash
cd ~/bin
gpg --full-generate-key
wget https://github.com/docker/docker-credential-helpers/releases/download/v0.6.4/docker-credential-pass-v0.6.4-amd64.tar.gz # replace with latest link
tar xvzf docker-credential-pass-v0.6.4-amd64.tar.gz
rm docker-credential-pass-v0.6.4-amd64.tar.gz
chmod a+x docker-credential-pass
gpg --list-secret-keys # copy the UUID from the output here
pass init UUID # replace UUID with the value from the last line
pass insert docker-credential-helpers/docker-pass-initialized-check
```

Now edit the `~/.docker/config.json` and add the json value:
```json
{
    "experimental": "enabled"
}
```

Now create a file at `~/.config/docker/daemon.json` that looks like:

```json
{
    "dns": ["8.8.4.4", "8.8.8.8"]
}
```

## Virtualisation

Virtualisation outside of docker on arch is done with qemu and lib virt:

```bash
pacman -S qemu-base lib-virt dnsmasq
```

you will need to add your user to the libvirt group:

```bash
usermod -aG libvirt user
```

and then enable the libvirtd service:

```bash
systemctl enable libvirtd.service
```

You can also install virt manager for a GUI to run VMs:

```bash
pacman -S virt-manager
```

This is probably all you need to get going however, if you are running something like the Android Emulator for development then you may want the full thing using:

```bash
pacman -S qemu-emulators-full
``
