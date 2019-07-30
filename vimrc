"http://vimdoc.sourceforge.net/htmldoc/
set nocompatible "don't be Vi compatible

filetype off "turn off filetype detection for vundle
set rtp+=~/.vim/bundle/vundle "add vundle
call vundle#begin() "start vundle
Plugin 'gmarik/vundle'

" syntax highlighters
Plugin 'othree/html5.vim'
Plugin 'elzr/vim-json'
Plugin 'lepture/vim-jinja.git'
Plugin 'tweekmonster/django-plus.vim'
Plugin 'kchmck/vim-coffee-script'
Plugin 'wavded/vim-stylus'
Plugin 'groenewege/vim-less'
Plugin 'chr4/nginx.vim'
Plugin 'plasticboy/vim-markdown'
Plugin 'dense-analysis/ale'
Plugin 'mxw/vim-jsx'
Plugin 'mtscout6/vim-cjsx'
Plugin 'luochen1990/rainbow'

" VCS
Plugin 'tpope/vim-fugitive'
Plugin 'airblade/vim-gitgutter'

" Sidebars
Plugin 'scrooloose/nerdtree'
Plugin 'majutsushi/tagbar'
Plugin 'sjl/gundo.vim'

" Code Completion
Plugin 'tpope/vim-surround'
Plugin 'craigemery/vim-autotag'
Plugin 'ervandew/supertab'
Plugin 'mattn/emmet-vim.git'
Plugin 'scrooloose/nerdcommenter'
Plugin 'Valloric/YouCompleteMe'
"Plugin 'szw/vim-tags'

" Commands
Plugin 'AndrewRadev/switch.vim'
Plugin 'tpope/vim-eunuch'
Plugin 'tpope/vim-speeddating'
Plugin 'tmhedberg/matchit'
Plugin 'AndrewRadev/linediff.vim'
Plugin 'tpope/vim-dispatch'
Plugin 'terryma/vim-multiple-cursors'
Plugin 'lambdalisue/vim-gista'
Plugin 'RRethy/vim-illuminate'

" Vim Config
Plugin 'LucHermitte/lh-vim-lib'
Plugin 'LucHermitte/local_vimrc'
Plugin 'editorconfig/editorconfig-vim'
Plugin 'vim-airline/vim-airline'
Plugin 'vim-airline/vim-airline-themes'
Plugin 'wesQ3/vim-windowswap'
Plugin 'flazz/vim-colorschemes'

"Python
Plugin 'klen/python-mode'
Plugin 'jeetsukumaran/vim-pythonsense'
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
syn match StrikeoutBetterComments "[\*\/#]\+\s*\~.*"
hi ErrorBetterComments ctermfg=196 term=bold gui=bold guifg=#ff2c4b
hi HighlightInlineComments ctermfg=93 term=bold gui=bold guifg=#8700ff
hi QuestionBetterComments ctermfg=39 term=bold gui=bold guifg=#242321
hi StrikeoutBetterComments ctermfg=22 term=bold gui=bold guifg=#35322d
hi link TodoBetterComments Todo
hi illuminatedWord ctermbg=238 cterm=underline gui=underline

set exrc "include .vimrc in CWD
set secure "limit .vimrc commands allowed
filetype on "enable filetype detection
filetype plugin on "filetype specific plugins
filetype indent on "filetype specific indents
set autoindent "copy indent from current line when starting new line
set autoread "auto read if file has changed outside vim but not inside
set clipboard=unnamedplus "copy/paste to/from system slipboard
set cursorline  "highlight line that cursor is currently on
set directory^=$HOME/.vim/swapfiles//  "keep swapfiles centralized
set encoding=utf8 "use UTF-8 file encoding
set expandtab "use spaces instead of tabs
set foldenable  "enable folding
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
set undodir=~/.vim/undodir  "keep undo file
set undofile "save undo's to a file
set undolevels=1000 "number of changes that can be undone
set whichwrap=h,l "use h or l to change lines at beginning or end of line/format
set wildchar=<Tab> "<Tab> to start wildcard completion
set wildmenu "enhaced completion mode
set wrap " visually wrap
au FileType * setlocal formatoptions-=t formatoptions+=l " don't automatically wrap long lines in INSERT


nnoremap ; :

"remap increment to not clash w/ screen
map <C-c> <C-a>
map :qt :tabc

command CloseOthers :%bd|e#

" easier home and end mapping
nnoremap H ^
nnoremap L $
vnoremap H ^
vnoremap L g_

" navigate tabs with ctrl-→/ctrl-←
nnoremap <C-right> :tabnext<CR>
nnoremap <C-left> :tabprevious<CR>
inoremap <C-right> <Esc>:tabnext<CR>
inoremap <C-left> <Esc>:tabprevious<CR>

" navigate splits with shift-→ , shift-←, shift-↓, shift-↑
nnoremap <S-left> <C-w>h
nnoremap <S-right> <C-w>l
nnoremap <S-up> <C-w>k
nnoremap <S-down> <C-w>j
inoremap <S-left> <C-w>h
inoremap <S-right> <C-w>l
inoremap <S-up> <C-w>k
inoremap <S-down> <C-w>j

map location map cycling
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
let g:airline_detect_paste = 1
let g:airline_detect_crypt = 1
let g:airline_detect_modified = 1
let g:airline_detect_spell = 1
let g:airline#extensions#ale#enabled = 1
let g:airline#extensions#ale#error_symbol = ' '
let g:airline#extensions#ale#warning_symbol = ' '
let g:airline#extensions#ale#open_lnum_symbol = ''
let g:airline#extensions#ale#close_lnum_symbol = ''
let g:airline#extensions#hunks#non_zero_only = 1
let g:airline#extensions#hunks#hunk_symbols = [' ', ' ', ' ']
let g:airline#extensions#tabline#enabled = 1
let g:airline#extensions#tabline#show_buffers = 1
let g:airline#extensions#tabline#tab_nr_type = 2
let g:airline#extensions#tabline#show_tab_type = 1
let g:airline#extensions#tagbar#flags = 'fs'
let g:airline#extensions#whitespace#mixed_indent_algo = 1
let g:airline_right_sep=''
let g:airline_right_alt_sep = ''
let g:airline_left_sep=''
let g:airline_left_alt_sep = ''
if !exists('g:airline_symbols')
    let g:airline_symbols = {}
endif
let g:airline_symbols.crypt = ''
let g:airline_symbols.readonly = ''
let g:airline_symbols.branch = ''
let g:airline_symbols.paste = ''

"Python Mode
let g:pymode_options_max_line_length = 89
let g:pymode_options_colorcolumn = 0
let g:pymode_lint = 0
let g:pymode_rope = 0
let g:pymode_virtualenv = 1
let g:pymode_breakpoint_cmd = 'import ipdb; ipdb.set_trace()  # XXX BREAKPOINT'
let g:pymode_python = 'python3'

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

"ALE
let g:ale_linter_aliases = {'htmldjango': 'html'}
let g:ale_sign_error = ''
let g:ale_sign_warning = ''
let g:ale_sign_info = ''
highlight ALEErrorSign ctermfg=1 guifg=#ff0000
highlight ALEInfoSign ctermfg=21 guifg=#0000ff
highlight ALEWarningSign ctermfg=226 guifg=#ffff00

"Gitgutter
let g:gitgutter_sign_added              = ''
let g:gitgutter_sign_modified           = ''
let g:gitgutter_sign_removed            = ''
let g:gitgutter_sign_removed_first_line = ''
let g:gitgutter_sign_modified_removed   = ''
let g:gitgutter_override_sign_column_highlight = 0
let g:gitgutter_diff_args = '-w'
highlight GitGutterAdd    guifg=#009900 ctermfg=2
highlight GitGutterChange guifg=#bbbb00 ctermfg=3
highlight GitGutterDelete guifg=#ff2222 ctermfg=1

"Multiple Cursors
let g:multi_cursor_exit_from_visual_mode = 0
let g:multi_cursor_exit_from_insert_mode = 0

"YouCompleteMe
let g:ycm_autoclose_preview_window_after_completion = 1
let g:ycm_server_python_interpreter = '/usr/bin/python3'

"Switch
let g:switch_mapping = '='
let g:switch_reverse_mapping = '+'
let g:switch_no_builtins = 1
let g:switch_custom_definitions = [
    \   ['&&', '||'],
    \   {'\<on\>': 'off', '\<off\>': 'on'},
    \   {'\<On\>': 'Off', '\<Off\>': 'On'},
    \   {'\<yes\>': 'no', '\<no\>': 'yes'},
    \   {'\<Yes\>': 'No', '\<No\>': 'Yes'},
    \   {'\<true\>': 'false', '\<false\>': 'true'},
    \   {'\<True\>': 'False', '\<False\>': 'True'},
    \   {
    \    '\(\k\+\) is \(not\)\@!\(\k\+\)': '\1 is not \3',
    \    '\(\k\+\) is not \(\k\+\)': '\1 is \2',
    \   },
    \ ]

" Pythonsense
map <buffer> [M <Plug>(PythonsenseEndOfPythonFunction)

" Rainbow
let g:rainbow_active = 1
let g:rainbow_conf = {
\	'guifgs': ['royalblue3', 'darkorange3', 'seagreen3', 'firebrick'],
\	'ctermfgs': ['green', 'red', 'yellow', 'blue', 'brown', 'darkmagenta', 'darkcyan',
\                'darkgray', 'darkgreen', 'lightyellow', 'darkblue', 'magenta', 'cyan'],
\}

"let g:vim_tags_use_vim_dispatch = 1
let g:vim_tags_ignore_files = ['.gitignore', 'client', '*.pyc']
let g:vim_tags_project_tags_command = "{CTAGS} -R {OPTIONS} -h .py --exclude='*.js' {DIRECTORY} 2>/dev/null"

" local vimrc
let g:local_vimrc = ['.vimlocal', '_vimrc_local.vim']
call lh#local_vimrc#munge('whitelist', $HOME.'/dev')

"Filetype detection
au! BufRead,BufNewFile *.json set filetype=json
au! BufRead,BufNewFile *.html set filetype=htmldjango
au! BufRead,BufNewFile *.sls set filetype=yaml
au! BufRead,BufNewFile Jenkinsfile* set filetype=groovy
