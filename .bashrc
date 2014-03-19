#
# ~/.bashrc
#

# If not running interactively, don't do anything
[[ $- != *i* ]] && return

alias ls='ls --color=auto'

PS1='[\u@\h \W]\$ '

# Some more `ls` aliases
alias ll='ls -la'
alias la='ls -A'
alias l='ls -l'

export EDITOR="vim"

# when available:
if [ -f /usr/bin/grc ]
then
    alias ping="grc --colour=auto ping"
    alias traceroute="grc --colour=auto traceroute"
    alias make="grc --colour=auto make" # broke kernel compilation once
    alias diff="grc --colour=auto diff"
    alias cvs="grc --colour=auto cvs"
    alias netstat="grc --colour=auto netstat"
fi

# Search history with PgUp/PgDown
bind '"\e[5~": history-search-backward'
bind '"\e[6~": history-search-forward'

# Just a test.
#PS1="\u@\h:\w\$(git branch&>/dev/null && echo -n ' (' && git branch 2>/dev/null | grep '^*' | colrm 1 2 && echo -n ')')\$ "

# Colors!

# Regular
txtblk='\[\e[0;30m\]' # Black
txtred='\[\e[0;31m\]' # Red
txtgrn='\[\e[0;32m\]' # Green
txtylw='\[\e[0;33m\]' # Yellow
txtblu='\[\e[0;34m\]' # Blue
txtpur='\[\e[0;35m\]' # Purple
txtcyn='\[\e[0;36m\]' # Cyan
txtwht='\[\e[0;37m\]' # White

# Bold
bldblk='\[\e[1;30m\]' # Black
bldred='\[\e[1;31m\]' # Red
bldgrn='\[\e[1;32m\]' # Green
bldylw='\[\e[1;33m\]' # Yellow
bldblu='\[\e[1;34m\]' # Blue
bldpur='\[\e[1;35m\]' # Purple
bldcyn='\[\e[1;36m\]' # Cyan
bldwht='\[\e[1;37m\]' # White

# Underline
unkblk='\[\e[4;30m\]' # Black
undred='\[\e[4;31m\]' # Red
undgrn='\[\e[4;32m\]' # Green
undylw='\[\e[4;33m\]' # Yellow
undblu='\[\e[4;34m\]' # Blue
undpur='\[\e[4;35m\]' # Purple
undcyn='\[\e[4;36m\]' # Cyan
undwht='\[\e[4;37m\]' # White

# Background
bakblk='\[\e[40m\]' # Black
bakred='\[\e[41m\]' # Red
bakgrn='\[\e[42m\]' # Green
bakylw='\[\e[43m\]' # Yellow
bakblu='\[\e[44m\]' # Blue
bakpur='\[\e[45m\]' # Purple
bakcyn='\[\e[46m\]' # Cyan
bakwht='\[\e[47m\]' # White
txtrst='\[\e[0m\]'  # Text Reset


# uncomment for a colored prompt, if the terminal has the capability; turned
# off by default to not distract the user: the focus in a terminal window
# should be on the output of commands, not on the prompt
force_color_prompt=yes

if [ -n "$force_color_prompt" ]
then
    if [ -x /usr/bin/tput ] && tput setaf 1 >&/dev/null; then
	# We have color support; assume it's compliant with Ecma-48
	# (ISO/IEC-6429). (Lack of such support is extremely rare, and such
	# a case would tend to support setf rather than setaf.)
	color_prompt=yes
    else
	color_prompt=
    fi
fi

# Source the git bash helper function for __git_ps1
if [ -e /usr/share/git/git-prompt.sh ]
then
    source /usr/share/git/git-prompt.sh
fi

if [ "$color_prompt" = yes ]
then
    #PS1="$bldgrn\u$bldwht@$bldpur\h$bldwht:$bldblu\w$bldylw\$(__git_ps1 ' (%s)')$txtrst\$ "
    PS1="$bldblk[\t] $bldgrn\u$txtwht at $bldblu\h$txtwht in $bldcyn\w\$(__git_ps1 '$txtwht in branch $bldylw%s')$txtrst\n\$ "
    #PS1="$bldblk[\t] $bldgrn\u$txtwht at $bldblu\h$txtwht in $bldcyn\w$txtrst\n\$ "
else
    PS1="\u@\h:\w\$(__git_ps1 ' (%s)')\$ "
    #PS1="\u@\h:\w\$ "
fi

# If this is an xterm set the title to user@host:dir
case "$TERM" in
xterm*|rxvt*)
    PS1="\[\e]0;\u@\h: \w\$(__git_ps1 ' (%s)')\a\]$PS1"
    #PS1="\[\e]0;\u@\h: \w\a\]$PS1"
    ;;
*)
    ;;
esac

unset force_color_prompt color_prompt

unset txtblk txtred txtgrn txtylw txtblu txtpur txtcyn txtwht bldblk bldred bldgrn bldylw bldblu bldpur bldcyn bldwht unkblk undred undgrn undylw undblu undpur undcyn undwht bakblk bakred bakgrn bakylw bakblu bakpur bakcyn bakwht txtrst


# TMUX BY DEFAULT
#if [[ ! $TERM =~ screen ]]
#then
#    exec tmux
#fi

