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
Plug 'numirias/semshi', { 'do': ':UpdateRemotePlugins' }

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
Plug 'ojroques/vim-oscyank', {'branch': 'main'}

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
call airline#parts#define('linenr', {
    \ 'raw': '%{g:airline_symbols.linenr}%#__accent_bold#%l%#__restore__#',
    \ 'accent': 'none'})
call airline#parts#define('maxlinenr', {
    \ 'raw': '%#__accent_bold#/%L%#__restore__#%{g:airline_symbols.maxlinenr}',
    \ 'accent': 'none'})
call airline#parts#define('colnr', {
    \ 'raw': '%{g:airline_symbols.colnr}%#__accent_bold#%v%#__restore__#',
    \ 'accent': 'none'})

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

" Semshi (Python syntax)
let g:semshi#error_sign=v:false
let semshi#no_default_builtin_highlight=v:false
let g:semshi#excluded_hl_groups = ['local', 'unresolved', 'attribute', 'builtin', 'free',]  "global, parameter, parameterUnused, self, imported

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

function! _COC_check_back_space() abort
    let col = col('.') - 1
    return !col || getline('.')[col - 1]  =~# '\s'
endfunction

function! _COC_show_documentation()
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
