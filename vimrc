"http://vimdoc.sourceforge.net/htmldoc/
set nocompatible "don't be Vi compatible

" put file in $HOME/.config/nvim/init.vim
 let VIMSHARE = $HOME.'/.vim/'

" If vim-plug is not installed install it
if empty(glob(VIMSHARE.'autoload/plug.vim'))
   execute 'silent !curl -fLo '.VIMSHARE.'autoload/plug.vim --create-dirs https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim'
   autocmd VimEnter * PlugInstall --sync | source $MYVIMRC
endif
call plug#begin(VIMSHARE.'plugged')

" syntax highlighters
Plug 'othree/html5.vim'
Plug 'elzr/vim-json'
Plug 'lepture/vim-jinja'
Plug 'tweekmonster/django-plus.vim'
Plug 'kchmck/vim-coffee-script'
Plug 'wavded/vim-stylus'
Plug 'groenewege/vim-less'
Plug 'chr4/nginx.vim'
Plug 'plasticboy/vim-markdown'
Plug 'dense-analysis/ale'
Plug 'mxw/vim-jsx'
Plug 'mtscout6/vim-cjsx'
Plug 'luochen1990/rainbow'

" VCS
Plug 'tpope/vim-fugitive'
"Plug 'airblade/vim-gitgutter'

" Sidebars
Plug 'scrooloose/nerdtree'
Plug 'majutsushi/tagbar'
Plug 'sjl/gundo.vim'

" Code Completion
Plug 'tpope/vim-surround'
Plug 'craigemery/vim-autotag'
"Plug 'ervandew/supertab'
Plug 'mattn/emmet-vim'
Plug 'scrooloose/nerdcommenter'
"Plug 'Valloric/YouCompleteMe'
Plug 'neoclide/coc.nvim', {'branch': 'release'}
"Plug 'szw/vim-tags'

" Commands
Plug 'AndrewRadev/switch.vim'
Plug 'tpope/vim-eunuch'
Plug 'tpope/vim-speeddating'
Plug 'tmhedberg/matchit'
Plug 'AndrewRadev/linediff.vim'
Plug 'tpope/vim-dispatch'
Plug 'terryma/vim-multiple-cursors'
Plug 'lambdalisue/vim-gista'
Plug 'RRethy/vim-illuminate'

" Vim Config
Plug 'LucHermitte/lh-vim-lib'
Plug 'LucHermitte/local_vimrc'
Plug 'editorconfig/editorconfig-vim'
Plug 'vim-airline/vim-airline'
Plug 'vim-airline/vim-airline-themes'
Plug 'wesQ3/vim-windowswap'
Plug 'flazz/vim-colorschemes'

"Python
Plug 'klen/python-mode'
Plug 'jeetsukumaran/vim-pythonsense'
Plug 'mgedmin/coverage-highlight.vim'
call plug#end()

syntax enable "enable colors
colorscheme badwolf
hi Normal guibg=NONE ctermbg=NONE
hi NonText guibg=NONE ctermbg=NONE
hi Pmenu ctermfg=166 ctermbg=235
hi TODO ctermbg=220 ctermfg=16
hi DiffDelete ctermbg=52
hi DiffAdd ctermbg=22
hi DiffChange ctermbg=58
hi DiffText ctermbg=226 ctermfg=8
hi htmlTag guibg=NONE ctermbg=NONE
hi htmlEndTag guibg=NONE ctermbg=NONE
hi illuminatedWord ctermbg=238 cterm=underline gui=underline
hi GitAdd    guifg=#009900 ctermfg=2
hi GitChange guifg=#bbbb00 ctermfg=3
hi GitDelete guifg=#ff2222 ctermfg=1
hi GitChangeDelete guifg=#ff2222 ctermfg=1
"Highlight end of line whitespace in red
highlight BadWhitespace ctermbg=red guibg=red
let m = matchadd('BadWhitespace', '\s\+$')
"Highlight tabs used instead of spaces in red
let m = matchadd('BadWhitespace', '^\t\+')

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
set directory^=$HOME/.vim/swapfiles//  "keep swapfiles centralized
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
set number "show line numbers
set numberwidth=4 "width of line number column
set shiftwidth=4 "4 spaces for indents when using << or >>
set shortmess+=c "don't give |ins-completion-menu| messages
set signcolumn=yes "always show the sign column
set smarttab "use <BS> too delete shiftwidth worth of space at start of line
set softtabstop=4 "4 spaces for tabs in INSERT mode
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

" navigate between buffers
nnoremap <silent> gb :bn<CR>
nnoremap <silent> gB :bp<CR>

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

map <leader>ld :Linediff<CR>
map <leader>] :vsp <CR>:exec("tag ".expand("<cword>"))<CR>

nnoremap <silent> K :call <SID>show_documentation()<CR>
nnoremap <silent> <leader>lp <Plug>(coc-diagnostic-prev)
nnoremap <silent> <leader>ln <Plug>(coc-diagnostic-next)
nnoremap <silent> <leader>lf  :<C-u>CocList -A -N files<CR>
nnoremap <silent> <leader>ls  :<C-u>CocList -I -N symbols<CR>
nnoremap <silent> <leader>ly  :<C-u>CocList -A --normal yank<CR>
nnoremap <silent> <leader>lr  :<C-u>CocList -A -N mru<CR>
nnoremap <silent> <leader>lb  :<C-u>CocList -A -N --normal buffers<CR>

map <leader>sa :s/\%V\([^(),]*\), \([^(),]*\)/\2, \1/<CR>

if &diff
    nnoremap <expr> <leader>n ]c
    nnoremap <expr> <leader>p [c
    nnoremap <silent> <leader>gl :diffg LOCAL<CR>
    nnoremap <silent> <leader>gb :diffg BASE<CR>
    nnoremap <silent> <leader>gr :diffg REMOTE<CR>
    nnoremap <silent> <leader>du :diffupdate<CR>
endif


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
let g:pymode_doc = 0
let g:pymode_doc_bind = ''

"ALE
let g:ale_linter_aliases = {'htmldjango': 'html'}
let g:ale_sign_error = '⛔️ '
let g:ale_sign_warning = '⚠️ '
let g:ale_sign_info = 'ℹ️ '
highlight ALEErrorSign ctermfg=1 guifg=#ff0000
highlight ALEInfoSign ctermfg=21 guifg=#0000ff
highlight ALEWarningSign ctermfg=226 guifg=#ffff00

"Multiple Cursors
let g:multi_cursor_exit_from_visual_mode = 0
let g:multi_cursor_exit_from_insert_mode = 0

" CoC
let g:coc_global_extensions = [
    \ 'coc-json',
    \ 'coc-python',
    \ 'coc-git',
    \ 'coc-yank',
    \ 'coc-lists',
    \ 'coc-css',
    \ 'coc-marketplace',
    \ 'coc-jira-complete',
    \ 'coc-github',
    \]
" Use tab for trigger completion with characters ahead and navigate.
" Use command ':verbose imap <tab>' to make sure tab is not mapped by other plugin.
inoremap <silent><expr> <TAB>
    \ pumvisible() ? "\<C-n>" :
    \ <SID>check_back_space() ? "\<TAB>" :
    \ coc#refresh()
inoremap <expr><S-TAB> pumvisible() ? "\<C-p>" : "\<C-h>"

function! s:check_back_space() abort
    let col = col('.') - 1
    return !col || getline('.')[col - 1]  =~# '\s'
endfunction

function! s:show_documentation()
  if (index(['vim','help'], &filetype) >= 0)
    execute 'h '.expand('<cword>')
  else
    call CocActionAsync('doHover')
  endif
endfunction

"Remap keys for gotos
nmap <silent> gd <Plug>(coc-definition)
nmap <silent> gy <Plug>(coc-type-definition)
nmap <silent> gi <Plug>(coc-implementation)
nmap <silent> gr <Plug>(coc-references)

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
