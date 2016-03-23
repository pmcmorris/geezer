#!/bin/bash

# get a colorized version of the git branch name
function git_branch_colored {
	# check if git tools are available
	if [ "$(type -t __git_ps1)" = "function" ]; then
		# get the current branch name
		local git_branch_name=$(__git_ps1)
		if [ "$git_branch_name" ]; then
			# peek at the status to see if there are uncommitted changes
			local status_str=$(git status 2>/dev/null | tail -n 1 | sed -e "s/\(nothing to commit\).*/\\1/")
			if [ "$status_str" = "nothing to commit" ]; then
				# show the branch name in yellow when there are no uncommited changes
				# Note: we don't use the escape \[ \] guards here and emit the color codes directly
				echo -n -e "\033[1;33m$git_branch_name"
			else
				# show the branch name in red when there are uncommited changes
				echo -n -e "\033[1;31m$git_branch_name"
			fi
		fi
	fi
}

# check if the current terminal is capable of color output
function test_terminal_color {
	# use tput (if it's executable) to set the foreground color as a test to see whether we're using a color terminal
	if [ -x /usr/bin/tput ] && tput setaf 1 >&/dev/null; then
		echo true
	else
		echo false
	fi
}

function set_prompt {

	# check if the terminal supports color
	local use_color=$(test_terminal_color)

	# check if the git shell functions are available
	if [ "$(type -t __git_ps1)" = "function" ]; then
		local use_git="true"
	else
		local use_git="false"
	fi

	if [ $use_color = "true" ]; then
		local   NO_COLOR="\[\033[0m\]"
		local       BLUE="\[\033[0;34m\]"
		local        RED="\[\033[0;31m\]"
		local  LIGHT_RED="\[\033[1;31m\]"
		local      WHITE="\[\033[1;37m\]"
		local LIGHT_GRAY="\[\033[0;37m\]"
		local      GREEN="\[\033[0;32m\]"
		local      AMBER="\[\033[0;33m\]"
		local     YELLOW="\[\033[1;33m\]"
		local  DARK_GRAY="\[\033[0;30m\]"
	fi

	# xterm windows peek into the prompt string to set the window title string
	case $TERM in
		xterm*)
			local TITLEBAR='\[\033]0;\u@\h:\w\007\]'
			;;
		*)
			local TITLEBAR=""
			;;
	esac

	# Build the command prompt string
	PS1="${TITLEBAR}" 
	# Result of the last command
	#PS1="$PS1$BLUE[${RED}\$?$BLUE]"
	# Completion time of the command
	PS1="$PS1$DARK_GRAY\$(date +%I:%M:%S%p) " 
	# user@machine:dir
	PS1="$PS1$BLUE\u$DARK_GRAY@$BLUE\h$DARK_GRAY:$WHITE\w" 
	# Show git branch name
	if [ $use_git = "true" ]; then
		if [ $use_color = "true" ]; then
			PS1="$PS1\$(git_branch_colored)"
		else
			PS1="$PS1\$(__git_ps1)"
		fi
	fi
	# Restore default color
	PS1="$PS1$WHITE\n\$$NO_COLOR "
	# Set continuation strings
	PS2="${WHITE}>$NO_COLOR "
	PS4="${WHITE}+$NO_COLOR "
}

