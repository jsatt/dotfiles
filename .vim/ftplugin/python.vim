"set python_highlight_all=1
"Highlight python code if lines over 79 columns
au BufWinEnter,WinEnter *.py let w:m2=matchadd('ErrorMsg', '\%>79v.\+', -1)

autocmd FileType python set omnifunc=pythoncomplete#Complete
set tags+=$HOME/.vim/tags/python.ctags

map <buffer> <s-c-D> Oimport ipdb; ipdb.set_trace()<esc>
map! <buffer> <s-c-D> import ipdb; ipdb.set_trace()
"map <buffer> <F4> :call ToolGrep('flake8')<CR>
"map! <buffer> <F4> :call ToolGrep('flake8')<CR>
map <buffer> <F4> :call ToolGrep('pyflakes')<CR>
map! <buffer> <F4> :call ToolGrep('pyflakes')<CR>
map <buffer> <F5> :call ToolGrep('pep8')<CR>
map! <buffer> <F5> :call ToolGrep('pep8')<CR>
"map <buffer> <F6> :call ToolGrep('pylint')<CR>
"map! <buffer> <F6> :call ToolGrep('pylint')<CR>
