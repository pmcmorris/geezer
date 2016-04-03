#!/bin/bash

# File: arch_install_base.sh
# URL: https://github.com/pmcmorris/linux_config/blob/master/arch_install_base.sh
# License: CC0 - Public Domain - No warranty is offered or implied; use this code at your own risk
# Author: Patrick McMorris

# This script handles the initial setup of a fresh install to how I tend to like
# my systems configured.
#
# We assume that this script will be executed as root.  Note: We do not use sudo
# here as it is not yet installed. We also try to keep package installations to
# a minimum so that this script is also useful in embedded/headless images. We
# also assume that (wired) networking has already been configured.
#
# I don't expect an Arch install script to be very useful to anyone else as
# using Arch is all about customization. This script mainly exists to remind me
# how I configured my headless Raspberry Pi images.

geezer_install_dir=/usr/share/geezer
geezer_base_packages="\
	dos2unix\
	htop\
	p7zip\
	sudo\
	tree\
	vim\
"

# Install geezer configuration files
read -p "Install Geezer files? [Y/n]" -n 1 -r
echo
if [[ ! $REPLY =~ ^[Nn]$ ]]; then
	if [[ -e $geezer_install_dir ]]; then
		echo reinstalling geezer at $geezer_install_dir
	else
		echo installing geezer at $geezer_install_dir
		mkdir -p $geezer_install_dir || exit -1
	fi
	# copy scripts to the install
	cp -R * $geezer_install_dir/
fi

# configure bash
# Note: its important that we modify the skeleton file before creating the admin user account below
# otherwise it will copy the old version
skel_bashrc_path=/etc/skel/.bashrc
backup_bashrc_path="$geezer_install_dir/.bashrc.backup"
geezer_bashrc_path="$geezer_install_dir/bash.bashrc"
if [[ ! -e $backup_bashrc_path ]]; then
	read -p "Configure bash? [Y/n]" -n 1 -r
	echo
	if [[ ! $REPLY =~ ^[Nn]$ ]]; then
		echo Backing up original bash.bashrc to geezer install folder
		cp $skel_bashrc_path $backup_bashrc_path

		echo Adding geezer bash settings skeleton bashrc
		cat << EOF >> $skel_bashrc_path

# Load Geezer bash settings
if [[ -r $geezer_bashrc_path ]]; then
	. $geezer_bashrc_path
fi

EOF

	fi
else
	# the backup file exists, assume we've already modified the system scripts
	echo Bash scripts already configured
fi

# install packages
read -p "Update packages? [Y/n]" -n 1 -r
echo
if [[ ! $REPLY =~ ^[Nn]$ ]]; then
	echo updating package database...
	pacman -Sy

	echo upgrading out-of-date packages...
	pacman -Su

	# add handy utilities
	echo installing base packages...
	pacman -S --needed --noconfirm $geezer_base_packages

	echo removing packages no longer needed from the cache
	pacman -Sc --noconfirm
fi

# configure timezone
read -p "Set timezone? [y/N]" -n 1 -r
echo
if [[ $REPLY =~ ^[Yy]$ ]]; then
	# set the system timezone
	echo Setting timezone to America/Vancouver
	rm -f /etc/localtime
	ln -s /usr/share/zoneinfo/America/Vancouver /etc/localtime
fi

# configure hostname
read -p "Set hostname? [y/N]" -n 1 -r
echo
if [[ $REPLY =~ ^[Yy]$ ]]; then
	# read a new host name from the user
	echo -n Current hostname:
	cat /etc/hostname
	read -p "New hostname: "
	# set the host name used on next boot
	echo $REPLY > /etc/hostname
	# set the current hostname
	hostname $REPLY
fi

# configure Wifi
read -p "Configure Wifi? [y/N]" -n 1 -r
echo
if [[ $REPLY =~ ^[Yy]$ ]]; then
	# create a connection profile
	wifi-menu
	# attempt to get the name of the new profile (ugly, fails if it already exists or if there are multiple)
	network_name=`ls /etc/netctl/wlan* | sed "s/\/etc\/netctl\///"`
	# enable the service to allow it to reconnect after reboots
	netctl enable $network_name
fi

# configure sudo
read -p "Configure sudo? [y/N]" -n 1 -r
echo
if [[ $REPLY =~ ^[Yy]$ ]]; then
	# TODO
	# configure sudo
	# - create an sudo group
	# - add sudo group to /etc/sudoers file
	# if the last step MUST use visudo this may be a challenge to automate correctly
	# - but could back it up, check, and then replace
	# - add wheel to sudoers
	# - disable root login
	# - create an admin user
	echo not implemented
fi

# reboot after completion
read -p "Reboot now? [y/N]" -n 1 -r
echo
if [[ $REPLY =~ ^[Yy]$ ]]; then
	reboot
fi

# list orphaned packages
# pacman -Qqdt

