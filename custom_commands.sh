#!/bin/bash

parse_git_branch()
{
	var=$(git branch 2> /dev/null | sed -e '/^[^*]/d' -e 's/* \(.*\)/(\1)/')
	if [[ -z "${var}" ]]
		then
		echo ""
	else
		echo " ${var}"
	fi
}
#Default:
# PS1='${debian_chroot:+($debian_chroot)}\[\033[01;32m\]\u@\h\[\033[00m\]:\[\033[01;34m\]\w\[\033[36m\]$(parse_git_branch)\[\033[00m\]\n\$ '
# PS1='${debian_chroot:+($debian_chroot)}\u@\h:\w$ (parse_git_branch) \$ '
#Retracted:
# PS1='${debian_chroot:+($debian_chroot)}\u@\h:\[\033[01;34m\]\w\[\033[36m\]$(parse_git_branch)\[\033[00m\]\n\$ '

if [ "$color_prompt" = yes ]; then
 PS1='${debian_chroot:+($debian_chroot)}\[\033[01;32m\]\u@\h\[\033[00m\]:\[\033[01;34m\]\w\[\033[36m\]$(parse_git_branch)\[\033[00m\]\n\$ '
else
 PS1='${debian_chroot:+($debian_chroot)}\u@\h:\w$ (parse_git_branch) \$ '
fi

# Remap caps to escape:
/usr/bin/setxkbmap -option "caps:escape"
# If wrongly turning on capslock, comment out the line above, and comment in this.
# And source ~/.bashrc
#/usr/bin/setxkbmap -option

# Ensure that vim is the preferred editor for Git and others.
export VISUAL=vim
export EDITOR="$VISUAL"

# Ensure that passwords are asked without gui prompt.
unset SSH_ASKPASS

# Copy to clipboard
alias clipboard='xclip -sel clip'

