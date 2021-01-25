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
"Plug 'dense-analysis/ale'
Plug 'mxw/vim-jsx'
Plug 'mtscout6/vim-cjsx'
Plug 'luochen1990/rainbow'
Plug 'chrisbra/csv.vim'
Plug 'Galicarnax/vim-regex-syntax'

" VCS
Plug 'tpope/vim-fugitive'
Plug 'rbong/vim-flog'
"Plug 'airblade/vim-gitgutter'

" Sidebars
Plug 'scrooloose/nerdtree'
Plug 'majutsushi/tagbar'
Plug 'sjl/gundo.vim'

" Code Completion
Plug 'tpope/vim-surround'
"Plug 'craigemery/vim-autotag'
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
Plug 'stevearc/vim-arduino'
Plug 'wfxr/minimap.vim'

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
nnoremap <S-down> <C-w>j
inoremap <S-left> <C-w>h
inoremap <S-right> <C-w>l
inoremap <S-up> <C-w>k
inoremap <S-down> <C-w>j

" copy to terminal hosts clipboard
vnoremap <silent> <leader>y y:call SendViaOSC52(getreg('"'))<cr>

noremap <leader>ld :Linediff<CR>
"noremap <silent> <leader>tt :TagbarToggle<CR>
"noremap <silent> <leader>tn :NERDTreeToggle<CR>
noremap <silent> <leader>e :CocCommand explorer<CR>
noremap <silent> <leader>ef :CocCommand explorer --position floating<CR>
noremap <silent> <leader>m :MinimapToggle<CR>
noremap <silent> <leader>mr :MinimapRefresh<CR>
noremap <silent> <C-z> :GundoToggle<CR>

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

"Tagbar
let g:tagbar_left = 1
let g:tagbar_autofocus = 1

"NERDTree
let NERDTreeIgnore=['\~$', '__pycache__', '*.pyc']

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
let g:airline#extensions#ale#enabled = 0
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

"JSON
let g:vim_json_syntax_conceal = 0

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
    \ 'coc-css',
    \ 'coc-git',
    \ 'coc-github',
    \ 'coc-jira-complete',
    \ 'coc-json',
    \ 'coc-lists',
    \ 'coc-marketplace',
    \ 'coc-python',
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

" CSV
let g:csv_nomap_c_left = 1
let g:csv_nomap_c_right = 1

" Markdown
let g:vim_markdown_conceal = 2
"let g:vim_markdown_conceal_code_blocks = 0 
let g:vim_markdown_strikethrough = 1
let g:vim_markdown_edit_url_in = 'tab'


" OSC52 - copy to terminal hosts clipboard
let g:max_osc52_sequence=100000
function! SendViaOSC52 (str)
  if !empty($TMUX)
    let osc52 = "\ePtmux;\e\e]52;c;" . s:b64encode(a:str, 0) . "\x07\e\\"
  elseif match($TERM, 'screen') > -1
    let osc52 = s:get_OSC52_DCS(a:str)
    let b64 = s:b64encode(a:str, 76)
    let b64 = substitute(b64, '\n*$', '', '')
    let b64 = substitute(b64, '\n', "\e/\eP", "g")
    let b64 = substitute(b64, '/', '\', 'g')
    let osc52 = "\eP\e]52;c;" . b64 . "\x07\e\x5c"
  else
    let osc52 = "\e]52;c;" . s:b64encode(a:str, 0) . "\x07"
  endif
  let len = strlen(osc52)
  if len < g:max_osc52_sequence
    exec("silent! !echo " . shellescape(osc52))
    redraw!
  else
    echo "Selection too long to send to terminal: " . len
  endif
endfunction
function! s:b64encode(str, size)
    let b64_table = [
                \ "A","B","C","D","E","F","G","H","I","J","K","L","M","N","O","P",
                \ "Q","R","S","T","U","V","W","X","Y","Z","a","b","c","d","e","f",
                \ "g","h","i","j","k","l","m","n","o","p","q","r","s","t","u","v",
                \ "w","x","y","z","0","1","2","3","4","5","6","7","8","9","+","/"]
    let bytes = s:str2bytes(a:str)
    let b64 = []
    for i in range(0, len(bytes) - 1, 3)
        let n = bytes[i] * 0x10000
                    \ + get(bytes, i + 1, 0) * 0x100
                    \ + get(bytes, i + 2, 0)
        call add(b64, b64_table[n / 0x40000])
        call add(b64, b64_table[n / 0x1000 % 0x40])
        call add(b64, b64_table[n / 0x40 % 0x40])
        call add(b64, b64_table[n % 0x40])
    endfor
    if len(bytes) % 3 == 1
        let b64[-1] = '='
        let b64[-2] = '='
    endif
    if len(bytes) % 3 == 2
        let b64[-1] = '='
    endif
    let b64 = join(b64, '')
    if a:size <= 0
        return b64
    endif
    let chunked = ''
    while strlen(b64) > 0
        let chunked .= strpart(b64, 0, a:size) . "\n"
        let b64 = strpart(b64, a:size)
    endwhile
    return chunked
endfunction
function! s:str2bytes(str)
    return map(range(len(a:str)), 'char2nr(a:str[v:val])')
endfunction

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
