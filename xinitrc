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

# Start X compositor daemonized (if existing in PATH)
command -v compton >/dev/null 2>&1 && compton -b

# exec gnome-session
# exec startkde
# exec startxfce4
# ...or the Window Manager of your choice
exec awesome

