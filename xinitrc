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
#command -v xcompmgr >/dev/null 2>&1 && \
#    xcompmgr -cCtF -I.1 -O.08 -D10 -t-15 -l-15 -r12 -o.5 &

# Nitrogen restores the background
command -v nitrogen >/dev/null 2>&1 && nitrogen --restore

# exec gnome-session
# exec startkde
# exec startxfce4
# ...or the Window Manager of your choice
exec cwm

