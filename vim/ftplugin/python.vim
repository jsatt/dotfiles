augroup PythonComplete
    autocmd!
    autocmd FileType python set omnifunc=pythoncomplete#Complete
augroup END

map <buffer> <leader>is :!isort %<CR>
map <buffer> <leader>pl ologger = logging.getLogger(__name__)<esc>ggOimport logging<CR><esc>''
map <buffer> <leader>pu ggO# -*- coding: utf-8 -*-<CR>from __future__ import unicode_literals<esc>''
