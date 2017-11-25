# init-script.sh --- 
# 
# Filename: init-script.sh
# Description: initialisation script for my custom archlinux configuration
# Author: Guy[P_TE]
# Maintainer: 
# Created: lun. nov. 13 17:09:30 2017 (+0100)
# Last-Updated: lun. nov. 13 18:18:25 2017 (+0100)
#           By: Guy[P_TE]
#     Update #: 10

# Code:

# variables
USERNAME="guy"
USERS_GROUP="users"

#####
# AUR
#####

function install_aur() {
	#  archlinuxfr repo
	echo -e "[archlinuxfr]\nSigLevel = Never\nServer = http://repo.archlinux.fr/\$arch" >> /etc/pacman.conf
	pacman -Syu yaourt
}

###############
# user creation
###############

function create_user() {
	useradd -g $USERS_GROUP -G network,sudo  -m -s /bin/bash $USERNAME
	mkdir /home/$USERNAME/screenshots && chown guy /home/$USERNAME/screenshots
}

#########################
# graphical environnement
#########################

function install_desktop_environment(){
	yaourt -Sy xorg-server xorg-xinit
	# DM
	yaourt -Sy lightdm lightdm-webkit2-greeter i3 lemonbar-xft-git conky lightdm-webkit2-theme-material2 ttf-roboto ttf-font-awesome rofi scrot alsa-utils feh dmenu network-manager-applet terminator xorg-xlsfonts upower acpixorg-dpyinfo ttf-inconsolata
	sudo sed -i "s/^#greeter-session=example-gtk-gnome/greeter-session=lightdm-webkit2-greeter/g" /etc/lightdm/lightdm.conf
	sudo systemctl enable lightdm.service
	sudo cp lightdm-webkit2-greeter.conf /etc/lightdm/
	sudo cp Xresources /home/$USERNAME/.Xresources
	sudo cp 50-keyboard.conf /etc/X11/xorg.conf.d/
	cp -r i3 /home/$USERNAME/.config/
	cp terminator-config.conf /home/$USERNAME/.config/terminator/config
}

#############
# networking
#############

function install_network(){
	pacman -Syu iw networkmanager networkmanager-openvpn
	sudo systemctl enable NetworkManager
	sudo cp 50-org-freedesktop.NetowkrManager.rules /etc/polkit-1/rules.d/
}

################
# virtualisation
################

function install_virtu(){
	# qemu kvm
	pacman -Syu qemu virt-manager 
	# virtualbox
	pacman -S virtualbox virtualbox-host-dkms
}

#####################
# source code edition
#####################

function install_developer_tools(){
	pacman -Syu emacs
}

#########
# java...
#########

########
# docker
########

######
# apps
######



# 
# init-script.sh ends here
