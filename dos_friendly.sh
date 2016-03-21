#!/bin/bash

#
# This script provides aliases that make a unix system for friendly to windows
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
# Some prefer to avoid editing their ~/.bashrc directly and adding these kinds of
# things to a ~/.bash_aliases file included from ~/.bashrc
#
# A more aggressive approach is for the system administrator to add a reference
# these aliases from /etc/skel/.bashrc so that new users get the behavior by
# default. (Note: expert users will have no trouble disabling this if they
# don't like it.)

alias cd..='cd ..'
alias cls=reset
alias copy='cp'
alias del='rm -iv'
alias deltree='rm -R'
alias dir='dir --color=auto --group-directories-first -Fl'
alias edit=subl
alias ifconfig=ipconfig
alias md='mkdir'
alias more='less'
alias move='mv'
alias rd='rmdir'
alias rename='mv'
alias type='cat'
alias xcopy='cp -R'
