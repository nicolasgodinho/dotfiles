#!/bin/sh

my_dmenu_path() {
    dmenu_path

    echo 'chromium --incognito'

    local f
    for f in ~/.screenlayout/*; do
        [ -e "$f" ] && echo "$f"
    done
}

my_dmenu_path | dmenu "$@" | ${SHELL:-"/bin/sh"} &

