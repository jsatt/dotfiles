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
alias getip='wget -qO- icanhazip.com'
alias grep='grep -inIE --exclude-dir=htmlcov --exclude-dir=.hg'
#alias l='ls -CF'
alias ll='ls -l'
alias la='ls -A'
alias lal='ls -al'
alias l.='ls -d .*'
alias pdbtest='./manage.py test -sx --pdb --pdb-failures'
alias ipdbtest='./manage.py test -sx --ipdb --ipdb-failures'
alias rscp='rsync --progress -r --rsh=ssh'
alias pep8='pep8 -r --exclude=migrations'
alias flake8='flake8 -r --exclude=migrations'
alias watchredis='redis-cli -n 1 monitor | cut -b -200'


if [ $UID -ne 0 ]; then
    gdr() { sudo killall -SIGHUP gunicorn_django; }
fi

