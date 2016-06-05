#!/bin/sh
#
# ~/.xinitrc
#
# Executed by startx (run your window manager from here)

if [ -d /etc/X11/xinit/xinitrc.d ]; then
  for f in /etc/X11/xinit/xinitrc.d/*; do
    [ -x "$f" ] && . "$f"
  done
  unset f
fi

# Do not beep
xset b off

# Little utility function to test if program exists on current system and is
# accessible through the PATH.
exists() {
    command -v "${1?}" >/dev/null 2>&1
}

# Start X compositor daemonized (if existing in PATH)
exists compton && compton -b
#exists xcompmgr && xcompmgr -cCtF -I.1 -O.08 -D10 -t-15 -l-15 -r12 -o.5 &

# Nitrogen restores the background
exists nitrogen && nitrogen --restore

# Dunst for the desktop notification
exists dunst && dunst -config ~/.config/dunst/dunstrc &

# exec gnome-session
# exec startkde
# exec startxfce4
# ...or the Window Manager of your choice
exec cwm

