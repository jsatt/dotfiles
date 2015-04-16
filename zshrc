export TERM=xterm-256color
export ZSH=$HOME/.oh-my-zsh

#ZSH_THEME=agnoster
#ZSH_THEME=kafeitu
#ZSH_THEME=dpoggi

CASE_SENSITIVE="true"
DISABLE_UNTRACKED_FILES_DIRTY="true"

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
    command-not-found
    npm
    sudo
    supervisor
    history-substring-search
)

source $ZSH/oh-my-zsh.sh
source ~/.zsh_theme

if [ -f $HOME/.zsh_aliases ]; then
    source $HOME/.zsh_aliases
fi

HISTFILE=~/.histfile
HISTSIZE=10000
SAVEHIST=10000
bindkey -e

setopt appendhistory autocd extendedglob nomatch
setopt completealiases
setopt histignoredups histignorespace
setopt noclobber

zstyle ':completion:*' completer _expand _complete _ignored _correct _approximate
zstyle :compinstall filename '/home/jsatt/.zshrc'

autoload -Uz compinit
compinit
