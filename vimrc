"http://vimdoc.sourceforge.net/htmldoc/
set nocompatible "don't be Vi compatible

" put file in $HOME/.config/nvim/init.vim
let VIMSHARE = $HOME.'/.vim/'

runtime plugins.vim
runtime colors.vim
runtime keymappings.vim
runtime commands.vim

set exrc "include .vimrc in CWD
set secure "limit .vimrc commands allowed
filetype on "enable filetype detection
filetype plugin on "filetype specific plugins
filetype indent on "filetype specific indents
set autoindent "copy indent from current line when starting new line
set autoread "auto read if file has changed outside vim but not inside
set clipboard=unnamedplus "copy/paste to/from system slipboard
set cmdheight=2 "use 2 screen lines for command line
set cursorline  "highlight line that cursor is currently on
set encoding=utf8 "use UTF-8 file encoding
set expandtab "use spaces instead of tabs
set foldenable  "enable folding
set foldmethod=indent "enable manual code folding
set foldlevelstart=6 "don't automatically close folds on open unless 6 folds deep
set hidden "hide buffers rather than unload
set history=1000 "remember the last 1000 commands used
set hlsearch "highlight matchs when searching
set incsearch "jump to next match when searching
set laststatus=2 "show status line
set linebreak "visually wrap long lines on breakat characters
set noswapfile "disable swapfiles
set number "show line numbers
set numberwidth=4 "width of line number column
set scrolloff=20 " keep lines above and below cursor when scorlling
set shiftwidth=4 "4 spaces for indents when using << or >>
set shortmess+=c "don't give |ins-completion-menu| messages
set signcolumn=yes "always show the sign column
set smarttab "use <BS> too delete shiftwidth worth of space at start of line
set softtabstop=4 "4 spaces for tabs in INSERT mode
set splitbelow "open new splits below instead of above
set splitright "open new split to the right instead of left
set switchbuf=useopen,usetab,newtab "use open buffer when switching
set tabstop=4 "4 space for tabs
set textwidth=99 " format lines to <100 characters
let textwidthbegin=&textwidth-9 " start considering line length before 100
let &colorcolumn=join(range(textwidthbegin, &textwidth),",") "highlight columns for visual indication of long line
set undodir=~/.vim/undodir  "keep undo file
set undofile "save undo's to a file
set undolevels=1000 "number of changes that can be undone
set updatetime=300 " milliseconds to wait before completing typed changes
set whichwrap=h,l "use h or l to change lines at beginning or end of line/format
set wrap " visually wrap

if  &term =~ "xterm" || &term =~ "screen" "if in xterm or screen
    set mouse=a "enable mouse in all modes
    if has("mouse_sgr")
        set ttymouse=sgr "enable SGR mouse reporting, works beyond column 223
    else
        set ttymouse=xterm2 "enable xterm mouse handling
    endif
endif
