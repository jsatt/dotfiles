if [ ! "$ZPROFILE_SOURCED" ]; then
    source $HOME/.zprofile
fi
export SHELL=zsh
export TERM=xterm-256color
export ZSH=$HOME/.oh-my-zsh
export EDITOR=vim

if [ "`which pip3`" ]; then
    powerline_root=`pip3 show powerline-status | \grep Location: | awk '{ print $2}'`
    if [ "$powerline_root" ]; then
        export POWERLINE_REPO="$powerline_root/powerline"
    fi
fi

#ZSH_THEME=agnoster
#ZSH_THEME=kafeitu
#ZSH_THEME=dpoggi

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
    sudo
    virtualenvwrapper

    zshmarks
)

source $ZSH/oh-my-zsh.sh
if [ "$POWERLINE_REPO" ]; then
    source $POWERLINE_REPO/bindings/zsh/powerline.zsh 
else
    source ~/.zsh_theme
fi

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
