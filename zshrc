#!/bin/zsh

########################################################################## COLOURS
BLACK='0;0'
DBLACK='1;0'
RED='1;31'
DRED='0;31'
GREEN='1;32'
DGREEN='0;32'
YELLOW='1;33'
DYELLOW='0;33'
BLUE='1;34'
DBLUE='0;34'
MAGENTA='1;35'
DMAGENTA='0;35'
CYAN='1;36'
DCYAN='0;36'
WHITE='1;37'
DWHITE='0;37'

autoload -U colors && colors
LS_COLORS="fi=$BLACK:di=$BLUE:ln=$CYAN:pi=$YELLOW:so=$MAGENTA:do=$MAGENTA:bd=$YELLOW:cd=$YELLOW:or=$WHITE:mi=$WHITE:ex=$GREEN:*.tar=$MAGENTA:*.tgz=$MAGENTA:*.tar.bz2=$MAGENTA:*.tar.gz=$MAGENTA:*.c=$CYAN:*.h=$CYAN:*.mk=$RED:*.m?=$RED:*.diff=$YELLOW:*.patch=$YELLOW:"


########################################################################## ENVIRONMENTS
BLOCKSIZE=k
TZ=Europe/Moscow
HISTFILE=~/.zhistory
HISTSIZE=1024
SAVEHIST=1024
PATH=~/.local/bin:$PATH


########################################################################## ALIAS
alias vi='vim'

alias cp='nocorrect cp --verbose --recursive --preserve=all'
alias mv='nocorrect mv --verbose '
alias rm='nocorrect rm -v'

alias grep='grep --color=auto'

alias du='du --human-readable --total'
alias df='df --human-readable'
alias mkdir='nocorrect mkdir'

alias ls=' ls --classify --color --human-readable --group-directories-first'
alias ll=' ls -l'
alias la=' ls -a'
alias lla='ls -la'
alias df=' df -h'

alias cd..='cd ..'
alias cd~='cd ~'

alias psa='ps -eo user,pid,pcpu,pmem,size,vsz,rss,start,time,args'
alias rsync='rsync -avzrc'


alias scrn='screen_'
alias ssh='ssh_'

function screen_()
{
    if [[ $1 == -* ]]; then
        screen $@
    else
        SESSION=${1}
        screen -x $SESSION || screen -aOUS $SESSION
    fi
}

function ssh_()
{
    #set -x
    cd ~/.ssh
    MAIN_CFG="config.main"
    CFG="config"

    [ -e $MAIN_CFG ] && cat $MAIN_CFG  > $CFG
    FILES=$(/usr/bin/find . -name "config-*" 2> /dev/null)
    if [ ! -z "${FILES}" ]; then
        cat config-*  >> $CFG
    fi
    cd - &> /dev/null

    /usr/bin/ssh "$@"
    #set +x
}

########################################################################## PROMPT

HOMEHOST='aepifanov-nb'
SRV='srv'

function get_git_branch()
{
    str=`git branch 2>/dev/null`
    if (( $? == 0 )) ; then
        GIT_BRANCH=`awk '{if($1 == "*") {print $2}}' <<<$str`
        return 0
    fi
    return 1
}

function get_venv()
{
    if [[ -n ${VIRTUAL_ENV} ]]; then
        VENV=$(basename $VIRTUAL_ENV)
        return 0
    fi
    return 1
}

function set_prompt()
{

    #  Current working directory                                   %/
    #  Current working directory, with one's home directory by     %~
    #  Full hostname                                               %M
    #  Hostname up to the first                                    %m
    #  Start (stop) boldfacing mode                                %B (or %b)
    #  Start (stop) standout mode                                  %S (or %s)
    #  Start (stop) underline mode                                 %U (or %u)
    #  User name                                                   %n
    #  The shell's tty that the user is logged in on               %|
    #  The current history number                                  %h (or %!)
    #  Time of day in 12-hour hh:mm                                %t (or %@)
    #  Time of day in 24-hour hh:mm                                %T
    #  Time of day in 24-hour with seconds hh:mm:nn                %*
    #  The date in day-dd format                                   %w
    #  The date in Mon/dd/yy format                                %W
    #  The date in yy-mm-dd format                                 %D

    P=''
    case "${HOST}" in
    ${HOMEHOST})
        COLOR='cyan'
        ;;
    ${SRV})
        COLOR='green'
        ;;
    *)
        P="%{$fg_bold[yellow]%}%M|"
        ;;
    esac

    if [[ ${USER} == 'root' ]]; then
        COLOR='red'
    fi

    if get_venv; then
        P="${P}%{$fg_bold[blue]%}(${VENV})"
    fi

    if get_git_branch; then
        P="${P}%{$fg_bold[red]%}[${GIT_BRANCH}]"
    fi

    PROMPT="${P}%{$reset_color%}%{$fg[${COLOR}]%}%2d%{$fg_bold[${COLOR}]%} # "

    RPROMPT="%{$fg_bold[${COLOR}]%}%T%{$reset_color%}"
}

function precmd()
{
    set_prompt
}

########################################################################## SSH


SSH_ENV="$HOME/.ssh/environment"

function start_agent {
     echo "Initialising new SSH agent..."
     /usr/bin/ssh-agent | sed 's/^echo/#echo/' > "${SSH_ENV}"
     echo succeeded
     chmod 600 "${SSH_ENV}"
     . "${SSH_ENV}" > /dev/null
     /usr/bin/ssh-add;
}

# Source SSH settings, if applicable
if [[ "${HOMEHOST}" == "${HOST}" ]]; then
    if [ -f "${SSH_ENV}" ]; then
        . "${SSH_ENV}" > /dev/null
        #ps ${SSH_AGENT_PID} doesn't work under cywgin
        ps -ef | grep ${SSH_AGENT_PID} | grep ssh-agent$ > /dev/null || {
        start_agent;
        }
    else
        start_agent;
    fi
fi

# for cygwin
cd
