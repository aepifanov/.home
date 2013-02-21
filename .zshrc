#!/bin/zsh -x

########################################################################## COLOURS
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

autoload -U colors && colors
LS_COLORS="fi=$BLACK:di=$BLUE:ln=$CYAN:pi=$YELLOW:so=$MAGENTA:do=$MAGENTA:bd=$YELLOW:cd=$YELLOW:or=$WHITE:mi=$WHITE:ex=$GREEN:*.tar=$MAGENTA:*.tgz=$MAGENTA:*.tar.bz2=$MAGENTA:*.tar.gz=$MAGENTA:*.c=$CYAN:*.h=$CYAN:*.mk=$RED:*.m?=$RED:*.diff=$YELLOW:*.patch=$YELLOW:"

########################################################################## COMPLETION
#zstyle ':completion:*' completer _expand _complete _ignored
#zstyle ':completion:*' group-name ''
#zstyle ':completion:*' list-colors ''
#zstyle ':completion:*' list-prompt '%SAt %p: Hit TAB for more, or the character to insert%s'
#zstyle ':completion:*' max-errors 1
#zstyle ':completion:*' menu select=long-list select=0
#zstyle ':completion:*' select-prompt '%SScrolling active: current selection at %p%s'
#zstyle ':completion:*' use-compctl false
#zstyle ':completion:*' verbose true
#zstyle ':completion:*' matcher-list 'm:{a-z}={A-Z}'
#zstyle ':completion:*:default' list-colors ${(s.:.)LS_COLORS}

#setopt autocd ignoreeof histignoredups histignorespace
#setopt CORRECT
#setopt AUTO_CD
#autoload -Uz compinit
#compinit

########################################################################## ENVIRONMENTS
BLOCKSIZE=k
TZ=Europe/Moscow
HISTFILE=~/.zhistory
HISTSIZE=1024
SAVEHIST=1024


########################################################################## ALIAS
alias vi='vim'

alias exit='sync; sync; exit'

alias cp='nocorrect cp --verbose --recursive --preserve=all'
alias mv='nocorrect mv --verbose '
alias rm='nocorrect rm -rv'

alias grep='grep --color=auto'

alias du='du --human-readable --total'
alias df='df --human-readable'
alias mkdir='nocorrect mkdir'

alias ls=' ls --classify --color --human-readable --group-directories-first'
alias ll=" ls -l"
alias la=" ls -a"
alias lla="ls -la"
alias df=" df -h"

alias cd..='cd ..'
alias cd~='cd ~'

alias psa="ps -eo user,pid,pcpu,pmem,size,vsz,rss,start,time,args"

alias -g cdw='cd ~/code'

alias s='screen -aOUDRR -s /bin/zsh'

alias cfg_push="git push git@github.com:aepifanov/config.git master"
alias cfg_pull="git pull git@github.com:aepifanov/config.git master"

alias vim_push="git push git@github.com:aepifanov/.vim.git master"
alias vim_pull="git pull git@github.com:aepifanov/.vim.git master"


########################################################################## PROMPT
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

    color="cyan"

    if [[ $HOST == "srv" ]]; then
        color="green"
    fi

    if [[ $USER == "root" ]]; then
        color="red"
    fi

    if get_git_branch; then
        PROMPT="%{$fg_bold[red]%}[$branch]%{$reset_color%}%{$fg[$color]%}%2d%{$fg_bold[$color]%} # "
    else
        PROMPT="%{$fg[$color]%}%2d%{$fg_bold[$color]%} # "
    fi

    RPROMPT="%{$fg_bold[$color]%}%T%{$reset_color%}"

}

function get_git_branch()
{
    str=`git branch 2>/dev/null`
    if (( $? == 0 )) ; then
        branch=`awk '{if($1 == "*") {print $2}}' <<<$str`
        return 0
    else
        return 1
    fi
}


function chpwd() 
{
    set_prompt
}

set_prompt

