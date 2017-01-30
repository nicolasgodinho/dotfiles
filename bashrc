#!/bin/bash

# If not running interactively, don't do anything.
[[ "$-" != *i* ]] && return

# Source global definitions in priority if existing
[[ -f /etc/profile ]] && source /etc/profile

# No clobber files while redirecting outputs
set -o noclobber

# I want to keep the vanilla ls colors. (VoidLinux)
unset LS_COLORS

# Checking that `uname` is well present in the system. If not, abandon
# everything.
if ! command -v uname &>/dev/null; then
    echo "bashrc: Can't find 'uname' to probe the operating system." >&2
    echo "bashrc: Leaving the bash environment untouched." >&2
    return
fi

# Probing the operating system and setting the proper configuration
kernel="$(uname -s)"
if [[ "$kernel" == "Linux" && -f /etc/os-release ]] && command -v sed &>/dev/null; then
    distro="$(sed -n "s/^\s*ID=['\"]\?\([a-zA-Z0-9_\-]\+\)['\"]\?/\1/p" /etc/os-release | sed -n 1p)"
fi
case "$kernel" in
    'Linux')
        aliasls="ls --color=auto --group-directories-first"
        case "${distro:-}" in
            'ubuntu') git_prompt_sh="/usr/lib/git-core/git-sh-prompt" ;;
            'debian') git_prompt_sh="/etc/bash_completion.d/git" ;;
            *)        git_prompt_sh="/usr/share/git/git-prompt.sh" ;;
        esac
        ;;

    'FreeBSD')
        aliasls="ls -G"
        git_prompt_sh="/usr/local/share/git-core/contrib/completion/git-prompt.sh"
        ;;

    'OpenBSD')
        if (command -v colorls &>/dev/null); then
            aliasls="colorls"
        else
            aliasls="ls"
        fi
        git_prompt_sh="/usr/local/share/git-core/contrib/completion/git-prompt.sh"
        ;;

    'Darwin')
        aliasls="ls -G"
        git_prompt_sh="/opt/local/share/git/git-prompt.sh"
        ;;
esac

# Setting the common `ls' aliases
# LC_COLLATE=C enables the file sort to follow ASCII code numbers of letters.
alias ls="LC_COLLATE=C ${aliasls:-ls}"
alias ll='ls -la'
alias la='ls -A'
alias l='ls -l'

# Defining the color variables
# The enclosing escaped brackets \[ \] are important to Bash: they enable Bash
# not to count these special ANSI color codes as characters printed on screen.
txtblk='\[\e[0;30m\]' # Black
txtred='\[\e[0;31m\]' # Red
txtgrn='\[\e[0;32m\]' # Green
txtylw='\[\e[0;33m\]' # Yellow
txtblu='\[\e[0;34m\]' # Blue
txtpur='\[\e[0;35m\]' # Purple
txtcyn='\[\e[0;36m\]' # Cyan
txtwht='\[\e[0;37m\]' # White
bldblk='\[\e[1;30m\]' # Bold Black
bldred='\[\e[1;31m\]' # Bold Red
bldgrn='\[\e[1;32m\]' # Bold Green
bldylw='\[\e[1;33m\]' # Bold Yellow
bldblu='\[\e[1;34m\]' # Bold Blue
bldpur='\[\e[1;35m\]' # Bold Purple
bldcyn='\[\e[1;36m\]' # Bold Cyan
bldwht='\[\e[1;37m\]' # Bold White
unkblk='\[\e[4;30m\]' # Underlined Black
undred='\[\e[4;31m\]' # Underlined Red
undgrn='\[\e[4;32m\]' # Underlined Green
undylw='\[\e[4;33m\]' # Underlined Yellow
undblu='\[\e[4;34m\]' # Underlined Blue
undpur='\[\e[4;35m\]' # Underlined Purple
undcyn='\[\e[4;36m\]' # Underlined Cyan
undwht='\[\e[4;37m\]' # Underlined White
bakblk='\[\e[40m\]'   # Background in Black
bakred='\[\e[41m\]'   # Background in Red
bakgrn='\[\e[42m\]'   # Background in Green
bakylw='\[\e[43m\]'   # Background in Yellow
bakblu='\[\e[44m\]'   # Background in Blue
bakpur='\[\e[45m\]'   # Background in Purple
bakcyn='\[\e[46m\]'   # Background in Cyan
bakwht='\[\e[47m\]'   # Background in White
txtrst='\[\e[0m\]'    # Text Reset

# Probe the capability to display colors in the shell (seems to work only in
# Linux and Mac OS X)...
# Source: the Debian's default bashrc file.
if (command -v tput &>/dev/null) && (tput setaf 1 &>/dev/null); then
    # We have color support; assume it's compliant with Ecma-48
    # (ISO/IEC-6429). (Lack of such support is extremely rare, and such
    # a case would tend to support setf rather than setaf.)
    color_prompt=y
elif [[ $kernel =~ .*BSD ]]; then
    # Enforce the color if we are on *BSD since the above test does not seem to
    # work.
    # FIXME: Investigate the appropriate code for probing the terminal
    # capabilities on *BSDs.
    color_prompt=y
else
    color_prompt=n
fi

# Source the git bash helper function for __git_ps1
if [[ -e "$git_prompt_sh" ]]; then
    source $git_prompt_sh
    git_prompt=y
else
    git_prompt=n
fi

# Display the username underlined and in red if I am root.
if [[ "$EUID" == 0 ]]; then
    user_color="$undred"
else
    user_color="$bldgrn"
fi

# Function to display the exit code
__exitcode_ps1() {
    local exit_code="$?"
    if [[ "$exit_code" != 0 && -n "$1" ]]; then
        printf "$1" "$exit_code"
    fi
    return "$exit_code"  # propagate the error code from previous command
}

__viassh_ps1() {
    local exit_code="$?"
    if [[ ! -z "${SSH_CONNECTION:-}" ]]; then
        local ssh_connection_array=($SSH_CONNECTION)
        local ssh_client_ip="${ssh_connection_array[0]}"
        printf "$1" "$ssh_client_ip"
    fi
    return "$exit_code"  # propagate the error code from previous command
}

# Setting the prompt.
case "$color_prompt:$git_prompt" in
    y:y)
        PS1="$bldblk[\t] $user_color\u$txtwht at $bldblu\h$txtwht\$(__viassh_ps1 ' via ${bldpur}SSH$txtwht') in $bldcyn\w\$(__git_ps1 '$txtwht in branch $bldylw%s')$txtrst\n\$(__exitcode_ps1 '$bldred%d$txtrst ')\\$ "
        ;;
    y:n)
        PS1="$bldblk[\t] $user_color\u$txtwht at $bldblu\h$txtwht\$(__viassh_ps1 ' via ${bldpur}SSH$txtwht') in $bldcyn\w$txtrst\n\$(__exitcode_ps1 '$bldred%d$txtrst ')\\$ "
        ;;
    n:y)
        PS1="\$(__exitcode_ps1 '{%d} ')\u@\h:\w\$(__git_ps1 ' (%s)')\\$ "
        ;;
    n:n)
        PS1="\$(__exitcode_ps1 '{%d} ')\u@\h:\w\\$ "
        ;;
esac

# Unsetting the different variables used in this bashrc, since we don't want
# them polluting every Bash shell.
unset kernel distro git_prompt_sh aliasls color_prompt
unset txtblk txtred txtgrn txtylw txtblu txtpur txtcyn txtwht bldblk bldred \
      bldgrn bldylw bldblu bldpur bldcyn bldwht unkblk undred undgrn undylw \
      undblu undpur undcyn undwht bakblk bakred bakgrn bakylw bakblu bakpur \
      bakcyn bakwht txtrst

# Tmux in 256 colors
alias tmux="tmux -2"

# Search history with PgUp/PgDown
bind '"\e[5~": history-search-backward'
bind '"\e[6~": history-search-forward'

# The basic requirements for Golang development
export GOPATH="$HOME/go"
export PATH="$PATH:$GOPATH/bin"

# Include Luarocks local environment
if command -v luarocks &>/dev/null; then
    eval $(luarocks path --bin)
fi

# Vim is my favourite editor
export EDITOR="vim"
