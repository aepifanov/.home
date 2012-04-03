#!/bin/bash 

export ACME_USE_SSH

export WS=/ws/aepifano-sjc
export HOME=/users/aepifano
export PATH=$PATH:/usr/cisco/bin
export PATH_INIT=$PATH
export LD_LIBRARY_PATH=$HOME/lib:$HOME/local/lib:$HOME/local/lib/expect5.45

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
# Run static analysis for given module
#
########################
function sa () 
{
    local bugid=$1
    shift

    local modules=
    for module in "$@"; do
        modules="$modules mipsbe/final/$module/sb-itasca"
    done

    rm -rf $modules

    /auto/ses/bin/static_adbu -j1 \
        $modules \
        -compare_baseline \
        -baseline /auto/itasca/static_analysis/converge_dev_sa.log \
        -bugid $bugid
}

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

########################
#
# Export my pathes
#
########################
function export_path()
{
    export PATH=$HOME/local/bin:$PATH
}

export_path


########################
#
# Setting WorkSpace 
#
########################
function set_ws ()
{
    local platf=$1
    local path=$2

    platform=$platf

    PS1="$ESC_RED[$platf] $ESC_DGREEN\w $ESC_GREEN# $ESC_BLACK"

    alias cdw="cd $WS/$path"
}

alias export_cs_fusion='   export_cscope /auto/itasca/build/nightly_rel_a42_sustaining'
alias export_cs_baikal='   export_cscope /auto/itasca/build/nightly_baikal-rib'
alias export_cs_earth='    export_cscope /auto/itasca/build/nightly_converge_dev'
alias export_cs_mars='     export_cscope /auto/itasca/build/nightly_airstrike_platform_dev'

alias fusion='   source /auto/itasca/tools/env/converge_dev.bashrc           && export_path && export_cs_fusion    && set_ws "fusion"    "42x"'
alias baikal='   source /auto/itasca/tools/etc/itasca.bashrc                 && export_path && export_cs_baikal    && set_ws "baikal"    "23x"'
alias earth='    source /auto/itasca/tools/env/earth_dev.bashrc              && export_path && export_cs_earth     && set_ws "earth"     "52x"'
alias mars='     source /auto/itasca/tools/env/airstrike_platform_dev.bashrc && export_path && export_cs_mars      && set_ws "mars"      "mars"'

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
#LS_COLORS='di=$BLUE:ln=01;36:pi=40;33:so=01;35:do=01;35:bd=40;33;01:cd=40;33;01:or=01;05;37;41:mi=01;05;37;41:ex=01;32:*.tar=01;35:*.tgz=01;35:*.c=01;36:*.h=01;36:*.mk=01;31:*.m?=01;31:*.diff=01;33:*.patch=01;33:'

export ACME_DIFF_OPTS=$diff_options
