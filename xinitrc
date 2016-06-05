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
#compton -b
xcompmgr -I.1 -O.08 -D10 -t-5 -l-5 -r12 -o.5 -CcFf &

# Launch dzen script if available
[[ -x .dzen.sh ]] && ./.dzen.sh &

# Nitrogen restores the background
nitrogen --restore &

# Dunst for the desktop notification
dunst -config ~/.config/dunst/dunstrc &

# exec gnome-session
# exec startkde
# exec startxfce4
# ...or the Window Manager of your choice
exec cwm

