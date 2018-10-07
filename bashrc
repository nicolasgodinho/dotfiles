#!/bin/bash

# If not running interactively, don't do anything.
[[ "$-" != *i* ]] && return

# Source global definitions in priority if existing
[[ -f /etc/profile ]] && source /etc/profile

# No clobber files while redirecting outputs
set -o noclobber

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
            'debian') git_prompt_sh="/etc/bash_completion.d/git-prompt" ;;
            *)        git_prompt_sh="/usr/share/git/git-prompt.sh" ;;
        esac
        ;;

    'FreeBSD')
        aliasls="ls -G"
        git_prompt_sh="/usr/local/share/git-core/contrib/completion/git-prompt.sh"
        ;;

    'OpenBSD')
        if command -v colorls &>/dev/null; then
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

# Colors in ls, tree and other fancy console tools (generated by dircolors)
export LS_COLORS='rs=0:di=01;34:ln=01;36:mh=00:pi=40;33:so=01;35:do=01;35:bd=40;33;01:cd=40;33;01:or=40;31;01:mi=00:su=37;41:sg=30;43:ca=30;41:tw=30;42:ow=34;42:st=37;44:ex=01;32:*.tar=01;31:*.tgz=01;31:*.arc=01;31:*.arj=01;31:*.taz=01;31:*.lha=01;31:*.lz4=01;31:*.lzh=01;31:*.lzma=01;31:*.tlz=01;31:*.txz=01;31:*.tzo=01;31:*.t7z=01;31:*.zip=01;31:*.z=01;31:*.Z=01;31:*.dz=01;31:*.gz=01;31:*.lrz=01;31:*.lz=01;31:*.lzo=01;31:*.xz=01;31:*.zst=01;31:*.tzst=01;31:*.bz2=01;31:*.bz=01;31:*.tbz=01;31:*.tbz2=01;31:*.tz=01;31:*.deb=01;31:*.rpm=01;31:*.jar=01;31:*.war=01;31:*.ear=01;31:*.sar=01;31:*.rar=01;31:*.alz=01;31:*.ace=01;31:*.zoo=01;31:*.cpio=01;31:*.7z=01;31:*.rz=01;31:*.cab=01;31:*.wim=01;31:*.swm=01;31:*.dwm=01;31:*.esd=01;31:*.jpg=01;35:*.jpeg=01;35:*.mjpg=01;35:*.mjpeg=01;35:*.gif=01;35:*.bmp=01;35:*.pbm=01;35:*.pgm=01;35:*.ppm=01;35:*.tga=01;35:*.xbm=01;35:*.xpm=01;35:*.tif=01;35:*.tiff=01;35:*.png=01;35:*.svg=01;35:*.svgz=01;35:*.mng=01;35:*.pcx=01;35:*.mov=01;35:*.mpg=01;35:*.mpeg=01;35:*.m2v=01;35:*.mkv=01;35:*.webm=01;35:*.ogm=01;35:*.mp4=01;35:*.m4v=01;35:*.mp4v=01;35:*.vob=01;35:*.qt=01;35:*.nuv=01;35:*.wmv=01;35:*.asf=01;35:*.rm=01;35:*.rmvb=01;35:*.flc=01;35:*.avi=01;35:*.fli=01;35:*.flv=01;35:*.gl=01;35:*.dl=01;35:*.xcf=01;35:*.xwd=01;35:*.yuv=01;35:*.cgm=01;35:*.emf=01;35:*.ogv=01;35:*.ogx=01;35:*.aac=00;36:*.au=00;36:*.flac=00;36:*.m4a=00;36:*.mid=00;36:*.midi=00;36:*.mka=00;36:*.mp3=00;36:*.mpc=00;36:*.ogg=00;36:*.ra=00;36:*.wav=00;36:*.oga=00;36:*.opus=00;36:*.spx=00;36:*.xspf=00;36:';

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
if command -v tput &>/dev/null && tput setaf 1 &>/dev/null; then
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
fi

# Source the git bash helper function for __git_ps1
if [[ "$(type -t __git_ps1)" == 'function' ]]; then
    git_prompt=y
elif [[ -e "$git_prompt_sh" ]]; then
    source "$git_prompt_sh" &&\
        [[ "$(type -t __git_ps1)" == 'function' ]] &&\
        git_prompt=y
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

# Function to display a warning message before prompt when a mountpoint lacks
# too much free space
__df_warning_ps1() {
    local exit_code="$?"
    if command -v df &>/dev/null && command -v awk &>/dev/null; then
        local status="$(LC_ALL=C df -k -P 2>/dev/null | awk '
        BEGIN { first=1; }
        (NR == 1) { next; }  # skip the header line
        ($1 ~ /^\/dev/) {   # consider only mount points to devices in /dev
        percentage=substr($5, 1, index($5, "%")-1)+1-1;
        if (percentage >= 90) {
            if (first) first=0; else printf(" ");
                printf("%s @ %d%%", $6, percentage);
            }
        }')"
        [[ "${status:-}" ]] && printf "$1 $2" "${status}"
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

__jobs_ps1() {
    local exit_code="$?" # save error code from previous command in shell
    if [[ ! -z "$(jobs -p)" ]]; then
        echo -ne "$1"
    fi
    return "$exit_code"  # propagate the error code from previous command
}

# Setting the prompt.
PROMPT_COMMAND=''
PS1=''
if [[ "${color_prompt:-}" ]]; then
    PS1+="$bldblk[ $user_color\u$txtwht at $bldblu\h$txtwht"
    #PS1+="$user_color\u$txtwht at $bldblu\h$txtwht"
    PS1+="\$(__viassh_ps1 ' via $bakpur$bldwht SSH $txtrst$txtwht')"
    [[ "${git_prompt:-}" ]] \
        && PS1+=" in $bldcyn\w\$(__git_ps1 '$txtwht on $bldylw┢ %s')$bldblk ]$txtwht"
    PS1+="\$(__jobs_ps1 ' with $bldred\j$txtwht jobs')$txtrst"
    PS1+="\n"
    PS1+="\$(__exitcode_ps1 '$bldred%d$txtrst ')"
else
    PS1+="\$(__exitcode_ps1 '{%d} ')\u@\h:\w"
    [[ "${git_prompt:-}" ]] && PS1+="\$(__git_ps1 ' (%s)')"
fi
PS1+='\\$ '   # the final prompt sign ($ or #)

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

# Flush history file after every command in an interactive session. This
# enables to share history commands from multiple terminals.
export PROMPT_COMMAND="${PROMPT_COMMAND:+$PROMPT_COMMAND; }history -a"

# It is often a bad idea to set LC_ALL since it comes to override all the other
# locale defining variables such as LC_* and LANG. These other variables should
# only be defined by /etc/locale.conf. Resetting LC_ALL.
export LC_ALL=''

# The basic requirements for Golang development
export GOPATH="$HOME/go"
export CARGOBINPATH="$HOME/.cargo/bin"
export PATH="$PATH:$GOPATH/bin:$CARGOBINPATH"

# Include Luarocks local environment
if command -v luarocks &>/dev/null; then
    eval $(luarocks path --bin)
fi

# Include Gem user in PATH
if command -v ruby &>/dev/null && command -v gem &>/dev/null; then
    gembinpath="$(ruby -e 'puts Gem.user_dir')/bin"
    if [[ -n "$gembinpath" ]]; then
        export PATH="$PATH:$gembinpath"
    fi
    unset gembinpath
fi

# My favourite editor
export EDITOR="vim"
if command -v nvim &>/dev/null; then
    alias vi=nvim
    alias vim=nvim
    alias vimdiff='nvim -d'
    export EDITOR=nvim
fi

# X Terminal titles
__fancy_window_title() {
    local prefix=''
    if [[ -n "${SSH_CONNECTION:-}" ]]; then
        prefix+="$USER@$HOSTNAME: "
    elif [[ "$USER" == 'root' ]]; then
        prefix+="(root) "
    fi
    echo -ne "\033]0;${prefix}$*\007"
}
__fancy_window_title_during_prompt() { __fancy_window_title "$PWD"; }
__fancy_window_title_during_cmd() { __fancy_window_title "$BASH_COMMAND"; }
if [[ "$TERM" =~ ^(xterm|rxvt)(-.*)?$ ]]; then
    export PROMPT_COMMAND="${PROMPT_COMMAND:+$PROMPT_COMMAND; }__fancy_window_title_during_prompt"
    trap __fancy_window_title_during_cmd DEBUG
fi

__prettyprint_json_with_jq() {
    if [[ "$#" -gt 1 ]]; then
        echo "function '${FUNCNAME[0]}': bad usage" >&2
        return 1
    elif [[ "$#" -eq 0 || "${1:-}" == '-' ]]; then
        jq -C .
    else
        jq -C . < "$1"
    fi
}

if command -v jq &>/dev/null; then
    alias jsonpp=__prettyprint_json_with_jq
fi

# vim: set ts=4 sts=4 sw=4 et:
