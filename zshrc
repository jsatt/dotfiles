export ZSH=$HOME/.oh-my-zsh

ZSH_THEME=dpoggi

plugins=(
    screen
    autoenv
    git
    python
    django
    pip
    virtualenv
    virtualenvwrapper
    celery
    debian
    colored-man
    colorize
    command-not-found
    common-aliases
    jsontools
    npm
    sudo
    supervisor
)

source $ZSH/oh-my-zsh.sh

if [ -f $HOME/.zsh_aliases ]; then
    source $HOME/.zsh_aliases
fi

CASE_SENSITIVE="true"
DISABLE_UNTRACKED_FILES_DIRTY="true"

# The following lines were added by compinstall

zstyle ':completion:*' completer _expand _complete _ignored _correct _approximate
zstyle :compinstall filename '/home/jsatt/.zshrc'

autoload -Uz compinit
compinit
# End of lines added by compinstall
# Lines configured by zsh-newuser-install
HISTFILE=~/.histfile
HISTSIZE=10000
SAVEHIST=10000
setopt appendhistory autocd extendedglob nomatch
bindkey -v
# End of lines configured by zsh-newuser-install
