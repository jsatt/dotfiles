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
"nnoremap <silent> <F4> :mksession<CR>

":make to check python syntax errors
set makeprg=python\ -c\ \"import\ py_compile,sys;\ sys.stderr=sys.stdout;\ py_compile.compile(r'%')\"
set efm=%C\ %.%#,%A\ \ File\ \"%f\"\\,\ line\ %l%.%#,%Z%[%^\ ]%\\@=%m

"Highlight end of line whitespace.
highlight WhitespaceEOL ctermbg=red guibg=red
match WhitespaceEOL /\s\+$/

function <SID>PythonGrep(tool)
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
  else
    echohl WarningMsg
    echo "PythonGrep Error: Unknown Tool"
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

if ( !hasmapto('<SID>PythonGrep(pyflakes)') && (maparg('<F4>') == '') )
  map <F4> :call <SID>PythonGrep('pyflakes')<CR>
  map! <F4> :call <SID>PythonGrep('pyflakes')<CR>
else
  if ( !has("gui_running") || has("win32") )
    echo "Python Pyflakes Error: No Key mapped.\n".
          \ "<F4> is taken and a replacement was not assigned."
  endif
endif

if ( !hasmapto('<SID>PythonGrep(pylint)') && (maparg('<F5>') == '') )
  map <F5> :call <SID>PythonGrep('pylint')<CR>
  map! <F5> :call <SID>PythonGrep('pylint')<CR>
else
  if ( !has("gui_running") || has("win32") )
    echo "Python Pylint Error: No Key mapped.\n".
          \ "<F5> is taken and a replacement was not assigned."
  endif
endif

"if ( !hasmapto('<SID>PythonGrep(pychecker)') && (maparg('<F5>') == '') )
"  map <F5> :call <SID>PythonGrep('pychecker')<CR>
"  map! <F5> :call <SID>PythonGrep('pychecker')<CR>
"else
"  if ( !has("gui_running") || has("win32") )
"    echo "Python Pychecker Error: No Key mapped.\n".
"          \ "<F5> is taken and a replacement was not assigned."
"  endif
"endif

