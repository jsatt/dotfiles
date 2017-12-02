export TERM=xterm-256color
export ZSH=$HOME/.oh-my-zsh

#ZSH_THEME=agnoster
#ZSH_THEME=kafeitu
#ZSH_THEME=dpoggi

CASE_SENSITIVE="true"
DISABLE_UNTRACKED_FILES_DIRTY="true"

plugins=(
    autoenv
    aws
    celery
    command-not-found
    docker
    docker-compose
    history-substring-search
    kubectl
    npm
    pip
    python
    sudo
    supervisor
    virtualenvwrapper
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

setopt appendhistory
setopt autocd
setopt completealiases
setopt correct
setopt extendedglob
setopt histignoredups
setopt histignorespace
setopt nomatch
setopt menu_complete
setopt rec_exact
unsetopt share_history
unsetopt clobber

# completion
zstyle ':completion:*' completer _expand _complete _ignored _correct _approximate
zstyle :compinstall filename '/home/jsatt/.zshrc'
autoload -Uz compinit
compinit

# pipenv 
export PIPENV_SHELL_FANCY=true
