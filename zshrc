export TERM=xterm-256color
export ZSH=$HOME/.oh-my-zsh

#ZSH_THEME=agnoster
#ZSH_THEME=kafeitu
#ZSH_THEME=dpoggi

CASE_SENSITIVE="true"
DISABLE_UNTRACKED_FILES_DIRTY="true"

plugins=(
    autoenv
    celery
    command-not-found
    history-substring-search
    npm
    python
    pip
    sudo
    supervisor
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
LESS+=F

setopt appendhistory autocd extendedglob nomatch
setopt completealiases
setopt histignoredups histignorespace
setopt noclobber
setopt noshare_history

# completion
zstyle ':completion:*' completer _expand _complete _ignored _correct _approximate
zstyle :compinstall filename '/home/jsatt/.zshrc'
autoload -Uz compinit
compinit

# virtualenvwrapper
if [ `which virtualenvwrapper.sh` ]; then
    export WORKON_HOME=$HOME/.virtualenvs
    source `which virtualenvwrapper.sh`
    export PIP_RESPECT_VIRTUALENV=true
fi
