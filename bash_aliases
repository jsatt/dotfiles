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
alias grep='grep -nIE --exclude-dir=htmlcov --exclude-dir=.hg --exclude-dir=.git'
#alias l='ls -CF'
alias ll='ls -l'
alias la='ls -A'
alias lal='ls -al'
alias l.='ls -d .*'
alias manage='python manage.py'
alias pdbtest='manage test -sx --pdb --pdb-failures'
alias ipdbtest='manage test -sx --ipdb --ipdb-failures'
alias rscp='rsync --progress -r --rsh=ssh'
alias pep8='pep8 -r --exclude=migrations'
alias flake8='flake8 --exclude=migrations'
alias watchredis='redis-cli -n 1 monitor | cut -b -200'
alias watchtest='py.test --looponfail --tb=short'


if [ $UID -ne 0 ]; then
    gdr() { sudo killall -SIGHUP gunicorn_django; }
fi

