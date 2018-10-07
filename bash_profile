#
# ~/.bash_profile
#

if [[ "$(tty)" == '/dev/tty1' && "$-" =~ i ]]; then
    turn_into_graphical_session() {
        exec sh -c 'startx; read -p ">>> Press return to get back to login invite."; exit'
    }
    while true; do
        read -n 1 -s -p "Turn this into a graphical session? [y|n] " _ans
        echo >&2  # line break
        case "${_ans}" in
            y|Y)  turn_into_graphical_session ;;
            n|N)  break ;;
            *)    echo >&2 " [!] Please answer (y)es or (n)o." ;;
        esac
    done
    unset _ans
fi

[[ -f ~/.bashrc ]] && . ~/.bashrc
