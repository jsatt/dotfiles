"http://vimdoc.sourceforge.net/htmldoc/
set nocompatible "don't be Vi compatible

filetype off "turn off filetype detection for vundle
set rtp+=~/.vim/bundle/vundle "add vundle
call vundle#rc() "start vundle
Bundle 'gmarik/vundle'
Bundle 'kchmck/vim-coffee-script'
Bundle 'lambdalisue/vim-django-support'
Bundle 'scrooloose/nerdtree'
Bundle 'wavded/vim-stylus'
Bundle 'ervandew/supertab'
Bundle 'tpope/vim-surround'
Bundle 'git://repo.or.cz/vcscommand'
Bundle 'vim-scripts/AutoTag'
Bundle 'lepture/vim-css'
Bundle 'mjbrownie/vim-htmldjango_omnicomplete'
Bundle 'vim-scripts/django.vim'
Bundle 'vim-scripts/Gundo'
Bundle 'vim-scripts/JSON.vim'
Bundle 'vim-scripts/nginx.vim'
Bundle 'vim-scripts/pythoncomplete'
Bundle 'vim-scripts/Rename'
Bundle 'vim-scripts/taglist-plus'
Bundle 'vim-scripts/indentpython.vim--nianyang'
Bundle 'jsatt/python_fn'
Bundle 'jsatt/python_syntax'
Bundle 'mattn/zencoding-vim.git'
Bundle 'plasticboy/vim-markdown'
Bundle 'lepture/vim-jinja.git'
Bundle 'scrooloose/syntastic'

syntax enable "enable syntax highlighting
filetype on "enable filetype detection
filetype plugin on "filetype specific plugins
filetype indent on "filetype specific indents
set autoindent "copy indent from current line when starting new line
set autoread "auto read if file has changed outside vim but not inside
set clipboard=unnamedplus "copy/paste to/from system slipboard
set colorcolumn=80 "highlight at column 80 for visual indication of long line
set expandtab "use spaces instead of tabs
set formatoptions=l "don't wrap long lines
set history=1000 "remember the last 1000 commands used
set hlsearch "highlight matchs when searching
set incsearch "jump to next match when searching
set laststatus=2 "show status line
set linebreak "visually wrap long lines
set number "show line numbers
set numberwidth=4 "width of line number column
set shiftwidth=4 "4 spaces for indents when using << or >>
set smarttab "use <BS> too delete shiftwidth worth of space at start of line
set softtabstop=4 "4 spaces for tabs in INSERT mode
set tabstop=4 "4 space for tabs
set undolevels=1000 "number of changes that can be undone
set whichwrap=h,l "use h or l to change lines at beginning or end of line/format
set wildchar=<Tab> "<Tab> to start wildcard completion
set wildmenu "enhaced completion mode
"remap increment to not clash w/ screen
nnoremap <C-c> <C-a>

"set color of line number column
highlight LineNr term=bold cterm=NONE ctermfg=DarkGrey ctermbg=NONE gui=NONE guifg=DarkGrey guibg=NONE
highlight ColorColumn ctermbg=darkgrey guibg=darkgrey

if &term =~ "xterm" || &term =~ "screen" "if in xterm or screen
	set mouse=a "enable mouse in all modes
    set ttymouse=xterm2 "enable xterm mouse handling
endif

au BufEnter * checkt "check for changes more often for autoread

"Taglist
"toggle Taglist w/ <F2>
nnoremap <silent> <F2> :TlistToggle<CR>
let Tlist_Process_File_Always=1 "process tags even with taglist closed
let Tlist_Exit_OnlyWindow=1 "exit vim if taglist is the only window
"let Tlist_Show_One_File=1 "only show tags from current file !!this is broken
let Tlist_Sort_Type="name" "sort by name by default

"NERDTree
"toggle NERDTree w/ <F3>
nnoremap <silent> <F3> :NERDTreeToggle<CR>
let g:netrw_list_hide=".*\.pyc$" "hide pyc files from nerdtree

"Gundo
"toggle Gundo w/ Ctrl-Z
nnoremap <silent> <C-z> :GundoToggle<CR>

"ZenCoding
"expand w/ Ctrl-e
let g:user_zen_expandabbr_key='<c-e>'

"Highlight end of line whitespace in red
highlight BadWhitespace ctermbg=red guibg=red
match BadWhitespace /\s\+$/
match BadWhitespace /^\t\+/

function ToolGrep(tool)
  set lazyredraw
  " Close any existing cwindows.
  cclose
  let l:grepformat_save = &grepformat
  let l:grepprogram_save = &grepprg
  set grepformat&vim
  set grepformat&vim
  let &grepformat = '%f:%l:%m'
  if a:tool == "pylint"
    let &grepprg = 'pylint --output-format=parseable --reports=n'
  elseif a:tool == "pyflakes"
    let &grepprg = 'pyflakes'
  elseif a:tool == "pychecker"
    let &grepprg = 'pychecker --quiet -q'
  elseif a:tool == "pep8"
    let &grepprg = 'pep8 -r'
  elseif a:tool == "flake8"
    let &grepprg = 'flake8'
  else
    echohl WarningMsg
    echo "ToolGrep Error: Unknown Tool"
    echohl none
  endif
  if &readonly == 0 | update | endif
  silent! grep! %
  let &grepformat = l:grepformat_save
  let &grepprg = l:grepprogram_save
  let l:mod_total = 0
  let l:win_count = 1
  " Determine correct window height
  windo let l:win_count = l:win_count + 1
  if l:win_count <= 2 | let l:win_count = 4 | endif
  windo let l:mod_total = l:mod_total + winheight(0)/l:win_count |
        \ execute 'resize +'.l:mod_total
  " Open cwindow
  execute 'belowright copen '.l:mod_total
  nnoremap <buffer> <silent> c :cclose<CR>
  set nolazyredraw
  redraw!
endfunction


"Filetype detection
au! BufRead,BufNewFile *.json set filetype=json
au! BufRead,BufNewFile *.html set filetype=htmldjango
