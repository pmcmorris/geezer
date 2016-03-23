#!/bin/bash

# File: dos_friendly.sh
# URL: https://github.com/pmcmorris/linux_config/blob/master/dos_friendly.sh
# License: CC0 - Public Domain - No warranty is offered or implied; use this code at your own risk
# Author: Patrick McMorris

# This script provides aliases that make a Unix system more friendly to windows
# users.
#
# Rather than change user behavior to suit the host system it is often more
# pragmatic to adjust the system to allow it to respond appropriately to
# foreign commands. This approach may be useful in the following situations: 
# - Systems that have a lot of users who are new to Unix
# - Users working in multi-platform environments (e.g. windows ssh into Linux,
#   Linux RDP into Window, frequent use of virtual machines with different
#   operating systems, etc.)
# - Windows users who are uninterested in retraining ingrained muscle memory
#   for no little benefit
#
# This script can be referenced from a user's ~/.bashrc (or .bash_aliases) file
# using:
#
# if [ -f ~/dos_friendly.sh ]; then
#     . ~/dos_friendly.sh
# fi
# 
# Some prefer to avoid editing their ~/.bashrc directly and adding these kinds
# of things to a ~/.bash_aliases file included from ~/.bashrc
#
# A more aggressive approach is for the system administrator to add a reference
# to these aliases from /etc/skel/.bashrc so that new users get the behavior by
# default. (Note: expert users will have no trouble disabling this should they
# dislike it.)

alias cd..='cd ..'
alias cls='reset'
alias copy='cp'
alias del='rm -iv'
alias deltree='rm -R'
alias dir='ls --color=auto --group-directories-first -Fl'
alias edit='nano -FLNdmw'
alias ipconfig='ifconfig'
alias md='mkdir'
alias more='less'
alias move='mv'
alias rd='rmdir'
alias rename='mv'
# This is what the dos users mean, but "type" is a real command that gets used
# in scripts and remapping it can cause strange errors
#alias type='cat'
alias xcopy='cp -R'

