for _, sign in pairs(require('common_').signs) do
  vim.fn.sign_define(sign.name, { texthl = sign.name, text = sign.text, numhl = sign.name })
end
vim.cmd [[
syntax enable
let g:sonokai_transparent_background = 1
colorscheme sonokai

hi DiffDelete guibg=#5f0000 ctermbg=52
hi DiffAdd guibg=#005f00 ctermbg=22
hi DiffChange guibg=#5f5f00 ctermbg=58
hi DiffText guifg=#5f5f5f guibg=#d7d700 ctermbg=184 ctermfg=59
highlight BadWhitespace ctermbg=red guibg=red
let m = matchadd('BadWhitespace', '\s\+$')
"Highlight tabs used instead of spaces in red
let m = matchadd('BadWhitespace', '^\t\+')

hi LuaLineDiagnosticsError guibg=#242321 ctermfg=203 guifg=#fc5d7c
hi LuaLineDiagnosticsWarn guibg=#242321 ctermfg=179 guifg=#e7c664
hi LuaLineDiagnosticsInfo guibg=#242321 ctermfg=110 guifg=#76cce0
hi LuaLineDiagnosticsHint guibg=#242321 ctermfg=107 guifg=#9ed072

hi TelescopePreviewBorder guifg=#ffa724
hi TelescopePromptBorder guifg=#aeee00
hi TelescopeResultsBorder guifg=#050fff

hi link FidgetTask MoreMsg
]]
-- vim: set ft=vim:
