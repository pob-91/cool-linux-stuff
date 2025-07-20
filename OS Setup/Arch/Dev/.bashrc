#
# ~/.bashrc
#

# If not running interactively, don't do anything
[[ $- != *i* ]] && return

alias ls='ls --color=auto'
alias HOME="cd"
alias DOCUMENTS="cd ~/Documents"
alias UPDATE=update_all
alias open=linux_open
alias autoremove=arch_autoremove
alias windowname=get_windowname
alias sonic=get_fastest_mirrors

PS1='\W >> '

export PATH=$HOME/.local/bin:$HOME/bin:$HOME/.npm-packages/bin:$PATH
export DOCKER_HOST=unix:///run/user/1000/docker.sock
export ANDROID_HOME=$HOME/Android/Sdk

export PATH=$PATH:/home/rob/go/bin
export PATH=$PATH:/home/rob/.npm-global/bin

# Fix an issue with some java programs
export _JAVA_AWT_WM_NONREPARENTING=1
# Some QT programs need to be configured to run on wayland
export QT_QPA_PLATFORM=wayland

function update_all() {
	sudo pacman -Syu
	yay -Syu
}

function linux_open() {
	xdg-open $1
}

function arch_autoremove() {
	sudo pacman -R $(sudo pacman -Qdtq)
	yay -R $(yay -Qdtq)
}

function get_windowname() {
	echo "Click on the window you want"
	xprop | grep -i 'class'
}

function get_fastest_mirrors() {
	sudo reflector -c "United Kingdom" --latest 20 --protocol https --sort rate --save /etc/pacman.d/mirrorlist
}

source /usr/share/git/completion/git-completion.bash
source /usr/share/nvm/init-nvm.sh
