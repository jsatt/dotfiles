export ZPROFILE_SOURCED=1
typeset -U path
path=(~/bin ~/.local/bin /usr/local/bin $path)
stty -ixon  # disable tty flow control, ie. CTRL-S, CTRL-Q
