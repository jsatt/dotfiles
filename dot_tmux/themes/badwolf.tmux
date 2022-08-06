
set -g status-bg '#45413b'
set -g status-fg '#f4cf86'
set -g status-interval 2
set -g status-justify left
set -g status-keys vi
set -g status-left "#{?client_prefix,#[fg=#141413]#[bg=#ffa724]#[bold]#[noitalics]#[nounderscore],#[fg=#ffa724]#[bg=colour232]#[nobold]#[noitalics]#[nounderscore]} #S #{?client_prefix,#[fg=#ffa724],#[fg=#141413]}#[bg=#45413b]#[nobold]"
set -g status-left-length 20
set -g status-left-style default
set -g status-position bottom
set -g status-right "#[fg=#242327,bg=default,nobold,noitalics,nounderscore]#[fg=#8cffba,bg=#242321,nobold,noitalics,nounderscore] #H #[fg=#aeee00,bg=#242321,nobold,noitalics,nounderscore]#[fg=#141413,bg=#aeee00,bold,noitalics,nounderscore] %Y-%m-%d %H:%M"
set -g status-right-length 150
set -g status-right-style default
set -g window-active-style default
set -g window-status-activity-style 'bg=#45413b'
set -g window-status-activity-style 'fg=#aeee00'
set -g window-status-bell-style 'bg=#141413'
set -g window-status-bell-style 'fg=#ff2c4b'
set -g window-status-current-format "#[fg=#45413b,bg=#aeee00,nobold,noitalics,nounderscore] #[fg=#141413,bg=#aeee00,bold,noitalics,nounderscore]#I#F  #[fg=#141413,bg=#aeee00,bold,noitalics,nounderscore]#W #[fg=#aeee00,bg=#45413b,nobold,noitalics,nounderscore] "
set -g window-status-current-style default
set -g window-status-format "#[fg=#f4cf86,bg=#45413b,nobold,noitalics,nounderscore]  #I#{?window_flags,#F, } #[fg=#242321,bg=#45413b,nobold,noitalics,nounderscore] #[default]#W   "
set -g window-status-last-style 'bg=#45413b'
set -g window-status-last-style 'fg=#f4cf86'
set -g window-status-separator " "
set -g window-status-style 'bg=#45413b'
set -g window-status-style 'fg=#8cffba'
set -g window-style default

# vim: set filetype=tmux:
