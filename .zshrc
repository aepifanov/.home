#!/bin/zsh

########################################################################## LIMIT
unlimit
limit -s
umask 022
########################################################################## FEATURES
zstyle ':completion:*' completer _expand _complete _ignored
zstyle ':completion:*' group-name ''
zstyle ':completion:*' list-colors ''
zstyle ':completion:*' list-prompt '%SAt %p: Hit TAB for more, or the character to insert%s'
zstyle ':completion:*' max-errors 1
zstyle ':completion:*' menu select=long-list select=0
zstyle ':completion:*' select-prompt '%SScrolling active: current selection at %p%s'
zstyle ':completion:*' use-compctl false
zstyle ':completion:*' verbose true
zstyle :compinstall filename '/home/bosha/.zsh/.zshrc'
zstyle ':completion:*' matcher-list 'm:{a-z}={A-Z}'
zstyle ':completion:*:default' list-colors ${(s.:.)LS_COLORS}

setopt autocd ignoreeof histignoredups histignorespace
setopt CORRECT
setopt AUTO_CD
autoload -Uz compinit
compinit

########################################################################## ENVIRONMENTS
BLOCKSIZE=k
TZ=Europe/Moscow
HISTFILE=~/.zhistory
HISTSIZE=1024
SAVEHIST=1024
PROMPT=$(echo '%{\033[32;22m%}%2d %{\033[32;1m%}%B#%} %{\033[32m%}%b')
RPROMPT=$(echo '%{\033[32;1m%}%T%{\033[0m%}')
hosts=( ${(s: :)${(ps:\t:)${${(f)"$(</etc/hosts)"}%%\#*}##[:blank:]#[^[:blank:]]#}} )


########################################################################## ALIAS
alias exit='sync; sync; exit'


alias cp='nocorrect cp --verbose --recursive --preserve=all'
alias mv='nocorrect mv --verbose '
alias rm='nocorrect rm -rv'

alias grep='grep --color=auto'

alias du='du --human-readable --total'
alias df='df --human-readable'
alias mkdir='nocorrect mkdir'

alias ls='ls --classify --color --human-readable --group-directories-first'
alias ll="ls -lh"
alias la="ls -a"
alias df="df -h"

alias cd..='cd ..'
alias cd~='cd ~'

alias ps="ps -eo user,pid,pcpu,pmem,size,vsz,rss,start,time,args"

alias -g cdw='cd /cygdrive/d/code/cisco'

########################################################################## FUNCTIONS
extract () {
 if [ -f $1 ] ; then
 case $1 in
 *.tar.bz2)   tar xjf $1        ;;
 *.tar.gz)    tar xzf $1     ;;
 *.bz2)       bunzip2 $1       ;;
 *.rar)       unrar x $1     ;;
 *.gz)        gunzip $1     ;;
 *.tar)       tar xf $1        ;;
 *.tbz2)      tar xjf $1      ;;
 *.tgz)       tar xzf $1       ;;
 *.zip)       unzip $1     ;;
 *.Z)         uncompress $1  ;;
 *.7z)        7z x $1    ;;
 *.tbz)       tar xjvf  ;;
 *)           echo "я не в курсе как распаковать '$1'..." ;;
 esac
 else
 echo "'$1' is not a valid file"
 fi
} 

# упаковка в архив
pk () {
 if [ $1 ] ; then
 case $1 in
 tbz)       tar cjvf $2.tar.bz2 $2      ;;
 tgz)       tar czvf $2.tar.gz  $2       ;;
 tar)       tar cpvf $2.tar  $2       ;;
 bz2)       bzip $2 ;;
 gz)        gzip -c -9 -n $2 > $2.gz ;;
 zip)       zip -r $2.zip $2   ;;
 7z)        7z a $2.7z $2    ;;
 *)         echo "'$1' cannot be packed via pk()" ;;
 esac
 else
 echo "'$1' is not a valid file"
 fi
}

## BEGIN KEY BINDINGS
# !?command <TAB>  complete from history  # Bang-history
# !#        <TAB>  repeat command line
#
# ^A   beginning-of-line, ^E end-of-line
# ^D   list completions, log out
# ^K   kill-line, ^U kill-whole-line
# ^R   history-incremental-search-backward, ^[P history-search-backward
# ^W   backward-kill-word, ^[D kill-word
# ^XU  undo, ^X^U undo
#
# ^[.  insert-last-word
# ^[B  backward-word, ^[F forward-word
# ^[H  run-help
# ^[Q  push-line
 
bindkey "^Z"    accept-and-hold
bindkey " "     magic-space  # also do history expansion on space
bindkey "\e[3~" delete-char
bindkey "\e[A"  up-line-or-search
bindkey "\e[B"  down-line-or-search
 
## Thorsten's own bindings
## rxvt
# These are the same as below - captured with [Ctrl]+[V]
#bindkey "^[Od"  backward-word
#bindkey "^[[7~" beginning-of-line
#bindkey "^[[8~" end-of-line
#bindkey "^[Oc"  forward-word

# captured with "od -c"
bindkey "\eOd"  backward-word
bindkey "\e[7~" beginning-of-line
bindkey "\e[8~" end-of-line
bindkey "\eOc"  forward-word
 
## Cygwin Console
# Cygwin Console does not distinguish between [Ctrl]+[<|] and [<|]
# respectively [Ctrl]+[|>] and [|>]
if   [ "$TERM" = cygwin ]
then bindkey "\e[1~" beginning-of-line
     bindkey "\e[4~" end-of-line
fi
## END KEY BINDINGS
