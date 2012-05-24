au BufNewFile,BufReadPost *.coffee setl foldmethod=indent nofoldenable
au BufWritePost *.coffee silent CoffeeMake! -b | cwindow | redraw!
