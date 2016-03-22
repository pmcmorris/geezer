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

read -p "Update packages? [y/N]" -n 1 -r
echo
if [[ $REPLY =~ ^[Yy]$ ]]
then
	# download a fresh copy of the master package database
	pacman -Sy
	# upgrade any out-of-date packages
	pacman -Su

	# add handy utilities
	base_packages="\
		dos2unix\
		htop\
		p7zip\
		tree\
		vim\
	"

	pacman -S --needed --noconfirm $base_packages

	# remove any packages which are no longer installed from the cache
	pacman -Sc --noconfirm
fi

read -p "Set timezone? [y/N]" -n 1 -r
echo
if [[ $REPLY =~ ^[Yy]$ ]]
then
	# set the system timezone
	echo Setting timezone to America/Vancouver
	rm -f /etc/localtime
	ln -s /usr/share/zoneinfo/America/Vancouver /etc/localtime
fi

# configure hostname
read -p "Set hostname? [y/N]" -n 1 -r
echo
if [[ $REPLY =~ ^[Yy]$ ]]
then
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
if [[ $REPLY =~ ^[Yy]$ ]]
then
	# create a connection profile
	wifi-menu
	# attempt to get the name of the new profile (ugly, fails if it already exists or if there are multiple)
	network_name=`ls /etc/netctl/wlan* | sed "s/\/etc\/netctl\///"`
	# enable the service to allow it to reconnect after reboots
	netctl enable $network_name
fi

# reboot after completion
read -p "Reboot now? [y/N]" -n 1 -r
echo
if [[ $REPLY =~ ^[Yy]$ ]]
then
	reboot
fi

# list orphaned packages
# pacman -Qqdt

