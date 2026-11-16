#!/bin/sh

# xinitrc runs automatically when you run startx
# there are some smalll but important commands that need to be run when we start
# the graphical envirenment. There is a link to this file in ~/.xprofile
# because that file is run automatically if someone uses a display manager
# (login screen) and so they are needed there. to prevent doubling up commands,
# I source them here with the line below

if [ -f "${XDG_CONFIG_HOME:-$HOME/.config}/x11/xprofile" ]; then
	. "${XDG_CONFIG_HOME:-$HOME/.config}/x11/xprofile"
else
	. "${HOME}/.xprofile"
fi

xss-lock -- slock -m "Locked at $(date +'%I:%M %p') | Type password to unlock" &
exec dwm
#exec dwm > ~/.dwm.log 2>&1
