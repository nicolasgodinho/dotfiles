#!/bin/sh

set -o errexit -o pipefail -o nounset

FG='#CCC'
BG='#111'

#FONT='-misc-fixed-medium-r-normal--10-*-*-*-*-*-*-*'
#FONT='DejaVu Sans Mono:pixelsize=9'
#FONT='Dina:pixelsize=12'
FONT='MonteCarlo:pixelsize=10'

dzen_on_screen() {
    dzen2 -fg "$FG" -bg "$BG" -fn "$FONT" \
          -ta r -sa r -x 0 -y 0 -h 14 -xs "${1?}" -e ''
}

count_screens() {
    xrandr | awk '
    BEGIN { nb_screens=0 }
    /^[A-Z0-9]+ connected/ {
        getline;
        while ($0 ~ /^\s+/) {
            if ($2 ~ /[0-9\.]+\*/) nb_screens++;
            getline;
        }
    }
    END { print nb_screens; }'
}

# Kill all dzen2 processes in case we run this script twice inadvertently...
killall dzen2 2>&1 >/dev/null || true

if [[ "$(count_screens)" -ge 2 ]]; then
    CONKYPIPE="$(mktemp -p "$HOME" -t ".conkypipe.XXX" -u)"
    mkfifo -m 0600 "$CONKYPIPE"
    trap rm\ -f\ "$CONKYPIPE" EXIT
    conky | tee "$CONKYPIPE" | dzen_on_screen 1 &
    dzen_on_screen 2 <"$CONKYPIPE"
else
    conky | dzen_on_screen 1
fi

