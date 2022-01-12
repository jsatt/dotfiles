for _, sign in pairs(require('common_').signs) do
  vim.fn.sign_define(sign.name, { texthl = sign.name, text = sign.text, numhl = sign.name })
end
vim.cmd [[
syntax enable
if has("termguicolors")
    set termguicolors
endif
let g:sonokai_transparent_background = 1
colorscheme sonokai

hi DiffDelete guibg=#5f0000 ctermbg=52
hi DiffAdd guibg=#005f00 ctermbg=22
hi DiffChange guibg=#5f5f00 ctermbg=58
hi DiffText guifg=#5f5f5f guibg=#d7d700 ctermbg=184 ctermfg=59
" hi htmlTag guibg=NONE ctermbg=NONE
" hi htmlEndTag guibg=NONE ctermbg=NONE
" hi illuminatedWord ctermbg=238 cterm=underline guibg=#444444 gui=underline
" hi GitAdd    guifg=#009900 ctermfg=2
" hi GitChange guifg=#bbbb00 ctermfg=3
" hi GitDelete guifg=#ff2222 ctermfg=1
" hi GitChangeDelete guifg=#ff2222 ctermfg=1
highlight BadWhitespace ctermbg=red guibg=red
let m = matchadd('BadWhitespace', '\s\+$')
"Highlight tabs used instead of spaces in red
let m = matchadd('BadWhitespace', '^\t\+')
]]
-- vim: set ft=vim:
