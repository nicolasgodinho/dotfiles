#
# ~/.bashrc
#

# If not running interactively, don't do anything
[[ $- != *i* ]] && return

# Checking that `uname` is well present in the system. If not, abandon
# everything.
if [ ! -f /usr/bin/uname ]
then
    echo "Can't find \`uname\' to probe the operating system." >&2
    echo "Leaving the bash environment untouched." >&2
    return
fi

# Probing the operating system and setting the proper configuration
kernel=$(/usr/bin/uname)
if [ "$kernel" = "Linux" ] && [ -x /usr/bin/sed ] && [ -f /etc/os-release ]
then
    eval $(/usr/bin/sed -n -e "/^\s*ID=/p" /etc/os-release |
           /usr/bin/sed "s/ID/distro/")
else
    distro=
fi
case "$kernel:$distro" in
    Linux:ubuntu)
        aliasls="ls --color=auto"
        git_prompt_sh="/usr/lib/git-core/git-sh-prompt"
        ;;

    Linux:void | Linux:arch | Linux:*)
        aliasls="ls --color=auto"
        git_prompt_sh="/usr/share/git/git-prompt.sh"
        ;;

    FreeBSD:)
        aliasls="ls -G"
        git_prompt_sh="/usr/local/share/git-core/contrib/completion/git-prompt.sh"
        ;;

    OpenBSD:)
        if [ -f /usr/local/bin/colorls ]
        then
            aliasls="colorls"
        else
            aliasls="ls"
        fi
        git_prompt_sh="/usr/local/share/git-core/contrib/completion/git-prompt.sh"
        ;;

    Darwin:)
        aliasls="ls -G"
        git_prompt_sh="/opt/local/share/git/git-prompt.sh"
        ;;
esac

# Setting the common `ls' aliases
alias ls=$aliasls
alias ll='ls -la'
alias la='ls -A'
alias l='ls -l'

# Defining the color variables
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
if [ -x /usr/bin/tput ] && (/usr/bin/tput setaf 1 >&/dev/null)
then
    # We have color support; assume it's compliant with Ecma-48
    # (ISO/IEC-6429). (Lack of such support is extremely rare, and such
    # a case would tend to support setf rather than setaf.)
    color_prompt=yes
elif [[ $kernel =~ .*BSD ]]
then
    # Enforce the color if we are on *BSD since the above test does not seem to
    # work.
    # FIXME: Investigate the appropriate code for probing the terminal
    # capabilities on *BSDs.
    color_prompt=yes
else
    color_prompt=no
fi

# Source the git bash helper function for __git_ps1
if [ -e "$git_prompt_sh" ]
then
    source $git_prompt_sh
    git_prompt=yes
else
    git_prompt=no
fi

# Display the username underlined and in red if I am root.
if [ "$USER" = "root" ]
then
    user_color=$undred
else
    user_color=$bldgrn
fi

# Function to display the exit code
__exitcode_ps1()
{
    local exit_code=$?
    if [ "$exit_code" -ne 0 -a -x /usr/bin/printf -a -n "$1" ]
    then
        /usr/bin/printf "$1" $exit_code
    fi
}

# Setting the prompt.
case "$color_prompt:$git_prompt" in
    yes:yes)
        PS1="$bldblk[\t] $user_color\u$txtwht at $bldblu\h$txtwht in $bldcyn\w\$(__git_ps1 '$txtwht in branch $bldylw%s')$txtrst\n\$(__exitcode_ps1 '$bldred%d$txtrst ')\\$ "
        ;;
    yes:no)
        PS1="$bldblk[\t] $user_color\u$txtwht at $bldblu\h$txtwht in $bldcyn\w$txtrst\n\$(__exitcode_ps1 '$bldred%d$txtrst ')\\$ "
        ;;
    no:yes)
        PS1="\$(__exitcode_ps1 '{%d} ')\u@\h:\w\$(__git_ps1 ' (%s)')\\$ "
        ;;
    no:no)
        PS1="\$(__exitcode_ps1 '{%d} ')\u@\h:\w\\$ "
        ;;
esac

# Unsetting the different variables used in this bashrc, since we don't want
# them exported in every shell.
unset kernel distro git_prompt_sh aliasls color_prompt
unset txtblk txtred txtgrn txtylw txtblu txtpur txtcyn txtwht bldblik bldred \
      bldgrn bldylw bldblu bldpur bldcyn bldwht unkblk undred undgrn undylw  \
      undblu undpur undcyn undwht bakblk bakred bakgrn bakylw bakblu bakpur  \
      bakcyn bakwht txtrst

# Tmux in 256 colors
alias tmux="tmux -2"

# Search history with PgUp/PgDown
bind '"\e[5~": history-search-backward'
bind '"\e[6~": history-search-forward'

# The basic requirements for Golang development
GOPATH=$HOME/go
PATH=$PATH:$GOPATH/bin

# Vim is my favourite editor
EDITOR="vim"


