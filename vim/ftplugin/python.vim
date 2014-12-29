"set python_highlight_all=1
"Highlight python code if lines over 79 columns
"au BufWinEnter,WinEnter *.py let w:m2=matchadd('ErrorMsg', '\%>79v.\+', -1)

autocmd FileType python set omnifunc=pythoncomplete#Complete
set tags+=$HOME/.vim/tags/python.ctags

map <buffer> <s-c-D> Oimport ipdb; ipdb.set_trace()<esc>
map! <buffer> <s-c-D> import ipdb; ipdb.set_trace()
map <buffer> <s-c-F> oself.mock = mox.Mox()<CR><CR><BS>def tearDown(self):<CR>self.mock.UnsetStubs()<esc>
map! <buffer> <s-c-F> self.mock = mox.Mox()<CR><CR><BS>def tearDown(self):<CR>self.mock.UnsetStubs()
map <buffer> <s-c-L> ologger = logging.getLogger(__name__)<esc>ggOimport logging<CR><esc>''
map <buffer> <c-U>  i# -*- coding: utf-8 -*-<CR><esc>
map! <buffer> <c-U>  # -*- coding: utf-8 -*-

map <buffer> <F4> :call ToolGrep('flake8')<CR>
map! <buffer> <F4> :call ToolGrep('flake8')<CR>
"map <buffer> <F4> :call ToolGrep('pyflakes')<CR>
"map! <buffer> <F4> :call ToolGrep('pyflakes')<CR>
"map <buffer> <F5> :call ToolGrep('pep8')<CR>
"map! <buffer> <F5> :call ToolGrep('pep8')<CR>
"map <buffer> <F6> :call ToolGrep('pylint')<CR>
"map! <buffer> <F6> :call ToolGrep('pylint')<CR>
