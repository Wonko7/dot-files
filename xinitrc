#!/bin/sh

userresources=$HOME/.Xresources
usermodmap=$HOME/.Xmodmap
sysresources=/etc/X11/xinit/Xresources
sysmodmap=/etc/X11/xinit/Xmodmap

# merge in defaults and keymaps

if [ -f $sysresources ]; then
    xrdb -merge $sysresources
fi

if [ -f $sysmodmap ]; then
    xmodmap $sysmodmap
fi

if [ -f "$userresources" ]; then
    xrdb -merge "$userresources"
fi

#if [ -f "$usermodmap" ]; then
#    xmodmap "$usermodmap"
#fi

# start some nice programs


if [ -n "`/etc/X11/chooser.sh`" ]; then
	command="`/etc/X11/chooser.sh`"
else
	failsafe="yes"
fi

if [ -d /etc/X11/xinit/xinitrc.d ] ; then
	for f in /etc/X11/xinit/xinitrc.d/* ; do
		[ -x "$f" ] && . "$f"
	done
	unset f
fi

xset fp+ /usr/share/fonts/terminus

source ~/conf/zsh/env.zsh
source ~/conf/misc/amixer.sh

#perl .irssi/scripts/systray_server.pl&
#feh --bg-scale wallpapers/Wallpaper_Dec_2009_by_zedi0us.jpg
#feh --bg-scale img/wallpapers/fclub.jpg
feh --bg-scale wallpapers/kermit_wide.jpg
urxvtd&
xcompmgr -cCtF -t-5 -l-5 -r4.2 -o.55 -D6&
gnome-panel&
~/local/bin/gnome-gmail-notifier&
~/.dropbox-dist/dropboxd&
xscreensaver&
xbindkeys&
gnome-power-manager&
dbus-launch --exit-with-session xmonad
