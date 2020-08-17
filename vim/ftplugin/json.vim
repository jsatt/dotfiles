nmap <buffer> gq :%! python -m json.tool<CR><CR>
vmap <buffer> gq :'<,'>!python -m json.tool<CR><CR>
setlocal foldmethod=syntax
setlocal tabstop=2
