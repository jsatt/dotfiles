" Key mappings
nnoremap ; :

"remap increment to not clash w/ screen
map <C-c> <C-a>
map :qt :tabc

" easier home and end mapping
nnoremap H ^
nnoremap L $
vnoremap H ^
vnoremap L g_
nnoremap <expr> k      v:count == 0 ? 'gk' : 'k'
nnoremap <expr> j      v:count == 0 ? 'gj' : 'j'
nnoremap <expr> <Up>   v:count == 0 ? "g\<Up>" : "\<Up>"
nnoremap <expr> <Down> v:count == 0 ? "g\<Down>" : "\<Down>"

" navigate between buffers
nnoremap <silent> gb :bn<CR>
nnoremap <silent> gB :bp<CR>

" navigate tabs with ctrl-→/ctrl-←
nnoremap <silent> <C-right> :tabnext<CR>
nnoremap <silent> <C-left> :tabprevious<CR>
inoremap <silent> <C-right> <Esc>:tabnext<CR>
inoremap <silent> <C-left> <Esc>:tabprevious<CR>

" navigate splits with shift-→ , shift-←, shift-↓, shift-↑
nnoremap <S-left> <C-w>h
nnoremap <S-right> <C-w>l
nnoremap <S-up> <C-w>k
nnoremap <S-down> <C-w>j
inoremap <S-left> <C-w>h
inoremap <S-right> <C-w>l
inoremap <S-up> <C-w>k
inoremap <S-down> <C-w>j

" copy to terminal hosts clipboard
vnoremap <silent> <leader>y y:OSCYank<CR>

noremap <leader>ld :Linediff<CR>
"noremap <silent> <leader>tt :TagbarToggle<CR>
"noremap <silent> <leader>tn :NERDTreeToggle<CR>
noremap <silent> <leader>e :CocCommand explorer<CR>
noremap <silent> <leader>ef :CocCommand explorer --position floating<CR>
noremap <silent> <leader>m :MinimapToggle<CR>
noremap <silent> <leader>mr :MinimapRefresh<CR>
noremap <silent> <C-z> :UndotreeToggle<CR>

nnoremap <silent> K :call <SID>show_documentation()<CR>
nmap <silent> <leader>lp <Plug>(coc-diagnostic-prev)
nmap <silent> <leader>ln <Plug>(coc-diagnostic-next)
nnoremap <silent> <leader>lf  :<C-u>CocList -A -N files<CR>
nnoremap <silent> <leader>ls  :<C-u>CocList -I -N symbols<CR>
nnoremap <silent> <leader>ly  :<C-u>CocList -A --normal yank<CR>
nnoremap <silent> <leader>lr  :<C-u>CocList -A -N mru<CR>
nnoremap <silent> <leader>lb  :<C-u>CocList -A -N --normal buffers<CR>
nmap <silent> <leader>rn <Plug>(coc-rename)
nmap <silent> <leader>rf <Plug>(coc-refactor)
xmap <leader>ra <Plug>(coc-codeaction-selected)

" COC
" Use tab for trigger completion with characters ahead and navigate.
" Use command ':verbose imap <tab>' to make sure tab is not mapped by other plugin.
inoremap <silent><expr> <TAB>
    \ pumvisible() ? "\<C-n>" :
    \ <SID>check_back_space() ? "\<TAB>" :
    \ coc#refresh()
inoremap <expr><S-TAB> pumvisible() ? "\<C-p>" : "\<C-h>"
inoremap <expr> <cr> pumvisible() ? "\<C-y>" : "\<C-g>u\<CR>"

"Remap keys for gotos
nmap <silent> gd <Plug>(coc-definition)
nmap <silent> gy <Plug>(coc-type-definition)
nmap <silent> gi <Plug>(coc-implementation)
nmap <silent> gr <Plug>(coc-references)
map <buffer> [M <Plug>(PythonsenseEndOfPythonFunction)

map <leader>sa :s/\%V\([^(),]*\), \([^(),]*\)/\2, \1/<CR>

if &diff
    nnoremap <expr> <leader>n ]c
    nnoremap <expr> <leader>p [c
    nnoremap <silent> <leader>gl :diffg LOCAL<CR>
    nnoremap <silent> <leader>gb :diffg BASE<CR>
    nnoremap <silent> <leader>gr :diffg REMOTE<CR>
    nnoremap <silent> <leader>du :diffupdate<CR>
endif

if &term == "nvim" || &term =~ "xterm" || &term =~ "screen" "if in xterm or screen
    set mouse=a "enable mouse in all modes
    if !has('nvim')
        if has("mouse_sgr")
            set ttymouse=sgr "enable SGR mouse reporting, works beyond column 223
        else
            set ttymouse=xterm2 "enable xterm mouse handling
        endif
    endif
endif
