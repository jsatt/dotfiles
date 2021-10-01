au FileType * setlocal formatoptions-=t formatoptions+=l " don't automatically wrap long lines in INSERT
au! BufRead,BufNewFile *.json set filetype=json
au! BufRead,BufNewFile *.html set filetype=jinja
au! BufRead,BufNewFile *.sls set filetype=yaml
au! BufRead,BufNewFile Jenkinsfile* set filetype=groovy
au BufEnter * checkt "check for changes more often for autoread

function! DeleteInactiveBufs()
    "From tabpagebuflist() help, get a list of all buffers in all tabs
    let tablist = []
    for i in range(tabpagenr('$'))
        call extend(tablist, tabpagebuflist(i + 1))
    endfor

    "Below originally inspired by Hara Krishna Dara and Keith Roberts
    "http://tech.groups.yahoo.com/group/vim/message/56425
    let nWipeouts = 0
    for i in range(1, bufnr('$'))
        if bufexists(i) && !getbufvar(i,"&mod") && index(tablist, i) == -1
        "bufno exists AND isn't modified AND isn't in the list of buffers open in windows and tabs
            silent exec 'bwipeout' i
            let nWipeouts = nWipeouts + 1
        endif
    endfor
    echomsg nWipeouts . ' buffer(s) wiped out'
endfunction

command! Bdi :call DeleteInactiveBufs()
command! CloseOthers :%bd|e#
command! CloseBuffers :call DeleteInactiveBufs()

" have vim start coc-explorer if vim started with folder
"autocmd StdinReadPre * let s:std_in=1
"autocmd VimEnter * if argc() == 1 && isdirectory(argv()[0]) && !exists("s:std_in") | exe 'CocCommand explorer' argv()[0] | wincmd p | ene | exe 'cd '.argv()[0] | endif
"com! -nargs=+ -complete=dir	Ex		:CocCommand explorer --position tab:. --no-toggle <args>
let g:loaded_netrwPlugin = "1"
augroup FileExplorer
 au!
 au BufEnter *	sil call s:LocalBrowse(expand("<amatch>"))
 au VimEnter *	sil call s:VimEnter(expand("<amatch>"))
augroup END

function! s:LocalBrowse(dirname)
  if !exists("s:vimentered")
   return
  endif

  if isdirectory(a:dirname)
   let l:bufid = bufnr()
   exec 'CocCommand explorer ' . a:dirname
   exec 'sleep 100m | bd ' . l:bufid
  endif
endfun

function! s:VimEnter(dirname)
  let s:vimentered = 1
  call s:LocalBrowse(expand("%:p"))
endfun
