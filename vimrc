"http://vimdoc.sourceforge.net/htmldoc/
set nocompatible "don't be Vi compatible

filetype off "turn off filetype detection for vundle
set rtp+=~/.vim/bundle/vundle "add vundle
call vundle#begin() "start vundle
Plugin 'gmarik/vundle'

" syntax highlighters
"Plugin 'vim-scripts/JSON.vim'
Plugin 'elzr/vim-json'
Plugin 'lepture/vim-jinja.git'
Plugin 'vim-scripts/django.vim'
Plugin 'kchmck/vim-coffee-script'
Plugin 'wavded/vim-stylus'
Plugin 'groenewege/vim-less'
Plugin 'vim-scripts/nginx.vim'
Plugin 'plasticboy/vim-markdown'
Plugin 'scrooloose/syntastic'
Plugin 'mxw/vim-jsx'
Plugin 'mtscout6/vim-cjsx'

" VCS
Plugin 'tpope/vim-fugitive'
Plugin 'airblade/vim-gitgutter'

" Sidebars
Plugin 'scrooloose/nerdtree'
Plugin 'majutsushi/tagbar'
Plugin 'vim-scripts/Gundo'

" Code Completion
Plugin 'tpope/vim-surround'
Plugin 'vim-scripts/AutoTag'
Plugin 'ervandew/supertab'
Plugin 'mattn/emmet-vim.git'
Plugin 'scrooloose/nerdcommenter'
Plugin 'Valloric/YouCompleteMe'
Plugin 'szw/vim-tags'

" Commands
Plugin 'vim-scripts/Toggle'
Plugin 'tpope/vim-eunuch'
Plugin 'tpope/vim-speeddating'
Plugin 'tmhedberg/matchit'
Plugin 'AndrewRadev/linediff.vim'
Plugin 'tpope/vim-dispatch'
Plugin 'terryma/vim-multiple-cursors'
Plugin 'lambdalisue/vim-gista'

" Vim Config
Plugin 'editorconfig/editorconfig-vim'
Plugin 'bling/vim-airline'
Plugin 'wesQ3/vim-windowswap'
Plugin 'flazz/vim-colorschemes'

"Python
Plugin 'klen/python-mode'
call vundle#end()

syntax enable "enable colors
colorscheme badwolf
hi Normal guibg=NONE ctermbg=NONE
hi NonText guibg=NONE ctermbg=NONE
hi TODO ctermbg=220 ctermfg=16
hi DiffDelete ctermbg=52
hi DiffAdd ctermbg=22
hi DiffChange ctermbg=58
hi DiffText ctermbg=226 ctermfg=8
hi htmlTag guibg=NONE ctermbg=NONE
hi htmlEndTag guibg=NONE ctermbg=NONE
hi SyntasticWarningSign ctermfg=1 ctermbg=233

set exrc "include .vimrc in CWD
set secure "limit .vimrc commands allowed
filetype on "enable filetype detection
filetype plugin on "filetype specific plugins
filetype indent on "filetype specific indents
set autoindent "copy indent from current line when starting new line
set autoread "auto read if file has changed outside vim but not inside
set clipboard=unnamedplus "copy/paste to/from system slipboard
set encoding=utf8 "use UTF-8 file encoding
set expandtab "use spaces instead of tabs
set foldmethod=indent "enable manual code folding
set foldlevelstart=6 "don't automatically close folds on open unless 6 folds deep
set history=1000 "remember the last 1000 commands used
set hlsearch "highlight matchs when searching
set incsearch "jump to next match when searching
set laststatus=2 "show status line
set linebreak "visually wrap long lines on breakat characters
set number "show line numbers
set numberwidth=4 "width of line number column
set shiftwidth=4 "4 spaces for indents when using << or >>
set smarttab "use <BS> too delete shiftwidth worth of space at start of line
set softtabstop=4 "4 spaces for tabs in INSERT mode
set tabstop=4 "4 space for tabs
set textwidth=99 " format lines to <100 characters
let textwidthbegin=&textwidth-9 " start considering line length before 100
let &colorcolumn=join(range(textwidthbegin, &textwidth),",") "highlight columns for visual indication of long line
set undolevels=1000 "number of changes that can be undone
set whichwrap=h,l "use h or l to change lines at beginning or end of line/format
set wildchar=<Tab> "<Tab> to start wildcard completion
set wildmenu "enhaced completion mode
set wrap " visually wrap
au FileType * setlocal formatoptions-=t formatoptions+=l " don't automatically wrap long lines in INSERT

"remap increment to not clash w/ screen
map <C-c> <C-a>

"map location map cycling
map <leader>ln :lnext<CR>
map <leader>lp :lprev<CR>

map <leader>ld :Linediff<CR>
map <leader>] :vsp <CR>:exec("tag ".expand("<cword>"))<CR>

map <leader>sa :s/\%V\([^(),]*\), \([^(),]*\)/\2, \1/<CR>

if &term =~ "xterm" || &term =~ "screen" "if in xterm or screen
    set mouse=a "enable mouse in all modes
    set ttymouse=xterm2 "enable xterm mouse handling
endif

au BufEnter * checkt "check for changes more often for autoread

"Tagbar
"toggle Tagbar w/ <F2>
map <silent> <F2> :TagbarToggle<CR>
let g:tagbar_left = 1
let g:tagbar_autofocus = 1

"NERDTree
"toggle NERDTree w/ <F3>
map <silent> <F3> :NERDTreeToggle<CR>
let NERDTreeIgnore=['\~$', '__pycache__', '*.pyc']

"NERDCommenter
let g:NERDCustomDelimiters = {
    \ 'python': {'left': '# ', 'leftAlt': '#'},
    \ }

"Gundo
"toggle Gundo w/ Ctrl-Z
map <silent> <C-z> :GundoToggle<CR>

"ZenCoding
"expand w/ Ctrl-e
let g:user_emmet_expandabbr_key='<c-e>'

"Highlight end of line whitespace in red
highlight BadWhitespace ctermbg=red guibg=red
let m = matchadd('BadWhitespace', '\s\+$')
"Highlight tabs used instead of spaces in red
let m = matchadd('BadWhitespace', '^\t\+')

"Airline
let g:airline_theme = 'badwolf'
let g:airline_powerline_fonts = 1
let g:airline#extensions#tabline#enabled = 1
let g:airline#extensions#tabline#show_buffers = 1
let g:airline#extensions#tabline#tab_nr_type = 2
let g:airline#extensions#tabline#show_tab_type = 1
let g:airline#extensions#tagbar#flags = 'fs'
let g:airline#extensions#whitespace#mixed_indent_algo = 1

"Python Mode
let g:pymode_options_max_line_length = 89
let g:pymode_options_colorcolumn = 0
let g:pymode_lint = 0
let g:pymode_rope = 0

"Syntastic
let g:syntastic_check_on_open = 1
let g:syntastic_always_populate_loc_list = 1
let g:syntastic_css_checkers = ['prettycss']
let g:syntastic_html_checkers = ['jshint', 'tidy']
let g:syntastic_filetype_map = {
    \ "htmldjango": "html" }
let g:syntastic_html_tidy_ignore_errors = [
    \ ' proprietary attribute ' ]
let g:syntastic_html_tidy_blocklevel_tags = [
    \ 'ng-switch'
    \ ]

"Multiple Cursors
let g:multi_cursor_exit_from_visual_mode = 0
let g:multi_cursor_exit_from_insert_mode = 0

"YouCompleteMe
let g:ycm_autoclose_preview_window_after_completion = 1

let g:vim_tags_use_vim_dispatch = 1
let g:vim_tags_ignore_files = ['.gitignore', 'client', '*.pyc']
let g:vim_tags_project_tags_command = "{CTAGS} -R {OPTIONS} -h .py --exclude='*.js' {DIRECTORY} 2>/dev/null"

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
au! BufRead,BufNewFile *.sls set filetype=yaml
