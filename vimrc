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
Plug 'groenewege/vim-less'
Plug 'chr4/nginx.vim'
Plug 'plasticboy/vim-markdown'
Plug 'mxw/vim-jsx'
Plug 'luochen1990/rainbow'
Plug 'Galicarnax/vim-regex-syntax'

" VCS
Plug 'tpope/vim-fugitive'
Plug 'rbong/vim-flog'

" Sidebars
Plug 'mbbill/undotree'

" Code Completion
Plug 'tpope/vim-surround'
Plug 'mattn/emmet-vim'
Plug 'preservim/nerdcommenter'
Plug 'neoclide/coc.nvim', {'branch': 'release'}

" Commands
Plug 'AndrewRadev/switch.vim'
Plug 'tpope/vim-eunuch'
Plug 'tpope/vim-speeddating'
Plug 'AndrewRadev/linediff.vim'
Plug 'tpope/vim-dispatch'
Plug 'terryma/vim-multiple-cursors'
Plug 'lambdalisue/vim-gista'
Plug 'RRethy/vim-illuminate'
Plug 'stevearc/vim-arduino'
Plug 'wfxr/minimap.vim'
Plug 'ojroques/vim-oscyank'

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
hi Comment gui=italic cterm=italic
hi Pmenu guifg=#d75f00 guibg=#262626 ctermfg=166 ctermbg=235
hi TODO guifg=#000000 guibg=#ffd700 gui=italic,bold ctermbg=220 ctermfg=16 cterm=italic,bold
hi DiffDelete guibg=#5f0000 ctermbg=52
hi DiffAdd guibg=#005f00 ctermbg=22
hi DiffChange guibg=#5f5f00 ctermbg=58
hi DiffText guifg=#5f5f5f guibg=#d7d700 ctermbg=184 ctermfg=59
hi htmlTag guibg=NONE ctermbg=NONE
hi htmlEndTag guibg=NONE ctermbg=NONE
hi illuminatedWord ctermbg=238 cterm=underline guibg=#444444 gui=underline 
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
set t_ZH=[3m  " set proper italics start
set t_ZR=[23m  " set proper italics end

if has("termguicolors")
    "set t_Co=256
    set termguicolors
    let &t_8f="\<Esc>[38;2;%lu;%lu;%lum"
    let &t_8b="\<Esc>[48;2;%lu;%lu;%lum"
endif

if &term == "nvim" || &term =~ "xterm" || &term =~ "screen" "if in xterm or screen
    set mouse=a "enable mouse in all modes
    if !has('nvim')
        if has("mouse_sgr")
            set ttymouse=sgr "enable SGR mouse reporting, works beyond column 223
        else
            set ttymouse=xterm2 "enable xterm mouse handling
        endif
    endif
endif


au FileType * setlocal formatoptions-=t formatoptions+=l " don't automatically wrap long lines in INSERT
au! BufRead,BufNewFile *.json set filetype=json
au! BufRead,BufNewFile *.html set filetype=jinja
au! BufRead,BufNewFile *.sls set filetype=yaml
au! BufRead,BufNewFile Jenkinsfile* set filetype=groovy
au BufEnter * checkt "check for changes more often for autoread

" Key mappings
nnoremap ; :

"remap increment to not clash w/ screen
map <C-c> <C-a>
map :qt :tabc

" easier home and end mapping
nnoremap H ^
nnoremap L $
vnoremap H ^
vnoremap L g_
nnoremap <expr> k      v:count == 0 ? 'gk' : 'k'
nnoremap <expr> j      v:count == 0 ? 'gj' : 'j'
nnoremap <expr> <Up>   v:count == 0 ? "g\<Up>" : "\<Up>"
nnoremap <expr> <Down> v:count == 0 ? "g\<Down>" : "\<Down>"

" navigate between buffers
nnoremap <silent> gb :bn<CR>
nnoremap <silent> gB :bp<CR>

" navigate tabs with ctrl-→/ctrl-←
nnoremap <silent> <C-right> :tabnext<CR>
nnoremap <silent> <C-left> :tabprevious<CR>
inoremap <silent> <C-right> <Esc>:tabnext<CR>
inoremap <silent> <C-left> <Esc>:tabprevious<CR>

" navigate splits with shift-→ , shift-←, shift-↓, shift-↑
nnoremap <S-left> <C-w>h
nnoremap <S-right> <C-w>l
nnoremap <S-up> <C-w>k
nnore:ap <S-down> <C-w>j
inoremap <S-left> <C-w>h
inoremap <S-right> <C-w>l
inoremap <S-up> <C-w>k
inoremap <S-down> <C-w>j

" copy to terminal hosts clipboard
vnoremap <silent> <leader>y y:OSCYank<CR>

noremap <leader>ld :Linediff<CR>
"noremap <silent> <leader>tt :TagbarToggle<CR>
"noremap <silent> <leader>tn :NERDTreeToggle<CR>
noremap <silent> <leader>e :CocCommand explorer<CR>
noremap <silent> <leader>ef :CocCommand explorer --position floating<CR>
noremap <silent> <leader>m :MinimapToggle<CR>
noremap <silent> <leader>mr :MinimapRefresh<CR>
noremap <silent> <C-z> :UndotreeToggle<CR>

nnoremap <silent> K :call <SID>show_documentation()<CR>
nmap <silent> <leader>lp <Plug>(coc-diagnostic-prev)
nmap <silent> <leader>ln <Plug>(coc-diagnostic-next)
nnoremap <silent> <leader>lf  :<C-u>CocList -A -N files<CR>
nnoremap <silent> <leader>ls  :<C-u>CocList -I -N symbols<CR>
nnoremap <silent> <leader>ly  :<C-u>CocList -A --normal yank<CR>
nnoremap <silent> <leader>lr  :<C-u>CocList -A -N mru<CR>
nnoremap <silent> <leader>lb  :<C-u>CocList -A -N --normal buffers<CR>
nmap <silent> <leader>rn <Plug>(coc-rename)
nmap <silent> <leader>rf <Plug>(coc-refactor)
xmap <leader>ra <Plug>(coc-codeaction-selected)

" COC
" Use tab for trigger completion with characters ahead and navigate.
" Use command ':verbose imap <tab>' to make sure tab is not mapped by other plugin.
inoremap <silent><expr> <TAB>
    \ pumvisible() ? "\<C-n>" :
    \ <SID>check_back_space() ? "\<TAB>" :
    \ coc#refresh()
inoremap <expr><S-TAB> pumvisible() ? "\<C-p>" : "\<C-h>"
inoremap <expr> <cr> pumvisible() ? "\<C-y>" : "\<C-g>u\<CR>"

"Remap keys for gotos
nmap <silent> gd <Plug>(coc-definition)
nmap <silent> gy <Plug>(coc-type-definition)
nmap <silent> gi <Plug>(coc-implementation)
nmap <silent> gr <Plug>(coc-references)
map <buffer> [M <Plug>(PythonsenseEndOfPythonFunction)

map <leader>sa :s/\%V\([^(),]*\), \([^(),]*\)/\2, \1/<CR>

if &diff
    nnoremap <expr> <leader>n ]c
    nnoremap <expr> <leader>p [c
    nnoremap <silent> <leader>gl :diffg LOCAL<CR>
    nnoremap <silent> <leader>gb :diffg BASE<CR>
    nnoremap <silent> <leader>gr :diffg REMOTE<CR>
    nnoremap <silent> <leader>du :diffupdate<CR>
endif

"OSC52
let g:oscyank_max_length = 1000000

"NERDCommenter
let g:NERDCustomDelimiters = {
    \ 'python': {'left': '# ', 'leftAlt': '#'},
    \ }

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

"JSON
let g:vim_json_syntax_conceal = 0

"Multiple Cursors
let g:multi_cursor_exit_from_visual_mode = 0
let g:multi_cursor_exit_from_insert_mode = 0

" CoC
let g:coc_global_extensions = [
    \ 'coc-css',
    \ 'coc-explorer',
    \ 'coc-git',
    \ 'coc-github',
    \ 'coc-jira-complete',
    \ 'coc-json',
    \ 'coc-lists',
    \ 'coc-marketplace',
    \ 'coc-pyright',
    "\ 'coc-python',
    \ 'coc-yank',
    \]

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

"Switch
let g:switch_mapping = '='
let g:switch_reverse_mapping = '+'
let g:switch_no_builtins = 1
let g:switch_custom_definitions = [
    \   ['&&', '||'],
    \   ['and', 'or'],
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

" Rainbow
let g:rainbow_active = 1
"let g:rainbow_conf = {
"\	'guifgs': ['royalblue3', 'darkorange3', 'seagreen3', 'firebrick'],
"\	'ctermfgs': ['green', 'red', 'yellow', 'blue', 'brown', 'darkmagenta', 'darkcyan',
"\                'darkgray', 'darkgreen', 'lightyellow', 'darkblue', 'magenta', 'cyan'],
"\}

" local vimrc
let g:local_vimrc = ['.vimlocal', '_vimrc_local.vim']
call lh#local_vimrc#munge('whitelist', $HOME.'/dev')

" Markdown
let g:vim_markdown_conceal = 2
let g:vim_markdown_strikethrough = 1
let g:vim_markdown_edit_url_in = 'tab'


function! DeleteInactiveBufs()
    "From tabpagebuflist() help, get a list of all buffers in all tabs
    let tablist = []
    for i in range(tabpagenr('$'))
        call extend(tablist, tabpagebuflist(i + 1))
    endfor

    "Below originally inspired by Hara Krishna Dara and Keith Roberts
    "http://tech.groups.yahoo.com/group/vim/message/56425
    let nWipeouts = 0
    for i in range(1, bufnr('$'))
        if bufexists(i) && !getbufvar(i,"&mod") && index(tablist, i) == -1
        "bufno exists AND isn't modified AND isn't in the list of buffers open in windows and tabs
            silent exec 'bwipeout' i
            let nWipeouts = nWipeouts + 1
        endif
    endfor
    echomsg nWipeouts . ' buffer(s) wiped out'
endfunction
command! Bdi :call DeleteInactiveBufs()
command CloseOthers :%bd|e#
command CloseBuffers :call DeleteInactiveBufs()
