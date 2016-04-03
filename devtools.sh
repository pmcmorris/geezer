#!/bin/bash

# File: arch_install_devtools.sh
# URL: https://github.com/pmcmorris/linux_config/blob/master/arch_install_devtools.sh
# License: CC0 - Public Domain - No warranty is offered or implied; use this code at your own risk
# Author: Patrick McMorris

# This script sets up a minimal environment for doing native development. This
# is by no means exhaustive as each project will have specific dependencies. But
# this is a good starting point.

# tools for building code
build_tools="\
	automake\
	cmake\
"

# packages for native development
native_tools="\
	binutils\
	clang\
	gcc\
	llvm\
	nasm\
"

# packages for script development
scripting_tools="\
	lua\
	nodejs\
	npm\
	python\
"

# miscellaneous utilities
misc_tools="\
	ctags\
	git\
"

# glob together a list of all the required packages
package_list="$build_tools $native_tools $scripting_tools $misc_tools"

# install all the packages
echo installing development packages...
pacman -S --needed --noconfirm $package_list

