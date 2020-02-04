augroup PythonComplete
    autocmd!
    autocmd FileType python set omnifunc=pythoncomplete#Complete
augroup END

map <buffer> <leader>is :CocCommand python.sortImports<CR>
map <buffer> <leader>hc :HighlightCoverage<CR><CR>
map <buffer> <leader>cn :NextUncovered<CR>
map <buffer> <leader>cp :PrevtUncovered<CR>
