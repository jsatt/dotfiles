#!/bin/bash
alias ..='cd ..'
alias ...='cd ../..'
alias ....='cd ../../..'
alias .....='cd ../../../..'
alias ......='cd ../../../../..'
alias df='df -h'
alias du='du -h'
alias du1='du --max-depth=1'
alias du1g='du1 |grep G |sort -n'
alias du1m='du1 |grep M |sort -n'
#alias l='ls -CF'
alias ll='ls -l'
alias la='ls -A'
alias lal='ls -al'
alias l.='ls -d .*'

if [ -f $HOME/.aliases ]; then
    source $HOME/.aliases
fi
