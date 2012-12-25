#!/bin/bash 

BLACK='0;0'
DBLACK='1;0'
RED='1;31'
DRED='0;31'
GREEN='1;32'
DGREEN='0;32'
YELLOW="1;33"
DYELLOW="0;33"
BLUE="1;34"
DBLUE="0;34"
MAGENTA="1;35"
DMAGENTA="0;35"
CYAN="1;36"
DCYAN="0;36"
WHITE="1;37"
DWHITE='0;37'


ESC_RED="\[\e["$RED"m\]"
ESC_GREEN="\[\e["$GREEN"m\]"
ESC_DGREEN="\[\e["$DGREEN"m\]"
ESC_BLACK="\[\e["$BLACK"m\]"

PS1="$ESC_DGREEN\w $ESC_GREEN# $ESC_BLACK"

########################
#
# Export CScope DataBase for given branch
#
########################
function export_cscope()
{
    for build in $(ls -dt $1/*); do
        if [ -r "$build/cscope.out" ]; then
            export CSCOPE_DB="$build/cscope.out"
            echo $CSCOPE_DB
            return 0
        fi
    done
    return 1
}

alias s='screen -aOUDRR -s /bin/bash'

alias ls=' ls --color=auto --human-readable'
alias ll=" ls -lh"
alias la=" ls -a"
alias lla="ls -la"
alias df=" df -h"
alias du=" du -c --si --max-depth=1"
alias e="  vim"
alias mmake="gmake --directory=build"

diff_options="-wubpB --unified=5"

alias diff="diff $diff_options"

alias cd..='cd ..'
alias cdw=' cd $WS'

LS_COLORS="di=$BLUE:ln=$CYAN:pi=$YELLOW:so=$MAGENTA:do=$MAGENTA:bd=$YELLOW:cd=$YELLOW:or=$WHITE:mi=$WHITE:ex=$GREEN:*.tar=$MAGENTA:*.tgz=$MAGENTA:*.tar.bz2=$MAGENTA:*.tar.gz=$MAGENTA:*.c=$CYAN:*.h=$CYAN:*.mk=$RED:*.m?=$RED:*.diff=$YELLOW:*.patch=$YELLOW:"

