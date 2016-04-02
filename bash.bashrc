#!/bin/bash

# Load script for enhanced git prompts
# Note: Git no longer provides the prompt functions in the normal bash completion stuff to allow them to lazy
# load correctly. But they still load by default on Ubuntu via /etc/bash_completion.d/git-prompt? But on more
# "stock" installs like Arch and LFS, the prompt script is expected to be sourced explicitly

# Correct install location on Arch linux
if [[ -e /usr/share/git/git-prompt.sh ]]; then
	. /usr/share/git/git-prompt.sh
fi

# Load our custom prompt functions
if [[ -e /usr/share/geezer/geezer-prompt.sh ]]; then
	. /usr/share/geezer/geezer-prompt.sh
	# use the geezer prompt by default
	__geezer_set_prompt
fi

# Load MS friendly aliases
if [[ -e /usr/share/geezer/dos_friendly.sh ]]; then
	. /usr/share/geezer/dos_friendly.sh
fi

# Load Geezer aliases
if [[ -e /usr/share/geezer/aliases.sh ]]; then
	. /usr/share/geezer/aliases.sh
fi

