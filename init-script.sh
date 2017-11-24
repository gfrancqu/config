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
	echo -e "[archlinuxfr]\nSigLevel = Never\nServer = http://repo.archlinux.fr/$arch" >> /etc/pacman.conf
	pacman -Syu yaourt
}

###############
# user creation
###############

function create_user() {
	user -g $USERS_GROUP -G network -m -s /bin/bash $USERNAME
	mkdir /home/$USERNAME/screenshots && chown guy /home/$USERNAME/screenshots
}

#########################
# graphical environnement
#########################

function install_desktop_environnement(){
	pacman -Syu xorg-server xorg-xinit
	# DM
	pacman -S lightdm lightdm-webkit2-greeter
	sed -i "s/greeter-session=lightdm-gtk-greeter/greeter-session=lightdm-webkit2-greeter/g"
	systemctl enable lightdm.service
	pacman -Syu i3
	su -c "yaourt lightdm-webkit2-theme-material2 ttf-roboto rofi scrot alsa-utils feh dmenu network-manager-applet" $USERNAME
	cp lightdm-webkit2-greeter.conf /etc/lightdm/
	cp -r i3 /home/guy/.config/
}

#############
# networking
#############

function install_network(){
	pacman -Syu iw networkmanager networkmanager-openvpn
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
