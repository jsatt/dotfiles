augroup PythonComplete
    autocmd!
    autocmd FileType python set omnifunc=pythoncomplete#Complete
augroup END

noremap <buffer> <leader>is :!isort %<CR><CR><CR>
noremap <buffer> <leader>hc :HighlightCoverage<CR><CR>
noremap <buffer> <leader>cn :NextUncovered<CR>
noremap <buffer> <leader>cp :PrevtUncovered<CR>
