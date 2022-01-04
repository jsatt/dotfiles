let g:vim_markdown_folding_disabled=1
autocmd FileType markdown setlocal spell spelllang=en_us
nmap <leader>md :%!Markdown.pl --html4tags <cr>
