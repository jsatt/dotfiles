"set python_highlight_all=1
"Highlight python code if lines over 79 columns
"au BufWinEnter,WinEnter *.py let w:m2=matchadd('ErrorMsg', '\%>79v.\+', -1)

autocmd FileType python set omnifunc=pythoncomplete#Complete
set tags+=$HOME/.vim/tags/python.ctags

map <buffer> <leader>pl ologger = logging.getLogger(__name__)<esc>ggOimport logging<CR><esc>''
map <buffer> <leader>pu ggO# -*- coding: utf-8 -*-<CR>from __future__ import unicode_literals<esc>''

map <buffer> <F4> :call ToolGrep('flake8')<CR>
map! <buffer> <F4> :call ToolGrep('flake8')<CR>
