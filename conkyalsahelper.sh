#!/bin/sh

set -o errexit -o pipefail -o nounset

amixer -c 0 get Master | \
    awk -v preon="${1?}" -v premute="${2?}" -v postfix="${3?}" '
    /^\s+Mono:/ {
        gsub(/(^\[|\]$)/, "", $(NF-2)); gsub(/(^\[|\]$)/, "", $NF);
        if ($NF == "on") {
            printf("%s%s%s", preon, $(NF-2), postfix);
        } else {
            printf("%smute%s", premute, postfix);
        }
    }' || echo -ne "ERROR"

