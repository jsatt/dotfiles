if [ ! "$ZPROFILE_SOURCED" ]; then
    source $HOME/.zprofile
fi
export SHELL=zsh
export ZSH=$HOME/.oh-my-zsh
export EDITOR="$(command -v nvim 2>/dev/null || command -v vim)"
if [ "$TERM" = "xterm" ]; then
    export TERM=xterm-256color
fi

CASE_SENSITIVE="true"
DISABLE_UNTRACKED_FILES_DIRTY="true"

plugins=(
    #autoenv
    aws
    celery
    command-not-found
    docker
    docker-compose
    encode64
    extract
    fd
    gcloud
    golang
    helm
    history-substring-search
    kops
    kubectl
    minikube
    npm
    pip
    python
    ripgrep
    sudo
    virtualenvwrapper

    zshmarks
)

source $ZSH/oh-my-zsh.sh
if [ -f $HOME/.zsh_theme ]; then
    source $HOME/.zsh_theme
fi

if [ -f $HOME/.zsh_aliases ]; then
    source $HOME/.zsh_aliases
fi
if [ -f $HOME/.local_aliases ]; then
    source $HOME/.local_aliases
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

export VIRTUALENVWRAPPER_PYTHON=$(which python3)
