set nocompatible
syntax enable
filetype on
filetype plugin on
filetype indent on
set autoindent
set tabstop=4
set softtabstop=4
set shiftwidth=4
set expandtab
set smarttab
set laststatus=2
set wildchar=<Tab>
set whichwrap=h,l
set formatoptions=l
set lbr
set hlsearch
set incsearch
set history=1000
set undolevels=1000
"More syntax highlighting.
let python_highlight_all = 1

if &term =~ "xterm" || &term =~ "screen"
	set mouse=a
    set ttymouse=xterm2
"else
"	set scrolloff=999
endif

"Highlight python code if lines over 80 columns
if has("colorcolumn")
    autocmd FileType python set colorcolumn=80
else
    autocmd FileType python au BufWinEnter * let w:m2=matchadd('ErrorMsg', '\%>80v.\+', -1)
endif

autocmd FileType python set omnifunc=pythoncomplete#Complete
inoremap <Nul> <C-x><C-o>
set tags +=$HOME/.vim/tags/python.ctags

"Taglist
nnoremap <silent> <F2> :TlistToggle<CR>
let Tlist_Process_File_Alway = 1
let Tlist_Show_Menu = 1

"NERDTree
nnoremap <silent> <F3> :NERDTreeToggle<CR>

"Vim Sessions
nnoremap <silent> <F4> :mksession<CR>

":make to check python syntax errors
set makeprg=python\ -c\ \"import\ py_compile,sys;\ sys.stderr=sys.stdout;\ py_compile.compile(r'%')\"
set efm=%C\ %.%#,%A\ \ File\ \"%f\"\\,\ line\ %l%.%#,%Z%[%^\ ]%\\@=%m

"Highlight end of line whitespace.
highlight WhitespaceEOL ctermbg=red guibg=red
match WhitespaceEOL /\s\+$/
