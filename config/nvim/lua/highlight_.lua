local theme = require('theme_')
local colors = theme.colors
local lualine_theme = theme.lualine_theme

vim.g.sonokai_transparent_background = 1
vim.cmd [[
syntax enable
colorscheme sonokai
]]

vim.highlight.create('DiffDelete',  {guibg = colors.dark_red.gui, ctermbg = colors.dark_red.term})
vim.highlight.create('DiffAdd', {guibg = colors.dark_green.gui, ctermbg = colors.dark_green.term})
vim.highlight.create('DiffChange', {guibg = colors.dark_yellow.gui, ctermbg = colors.dark_yellow.term})
vim.highlight.create('DiffText', {guifg = colors.grey.gui, guibg = colors.yellow.gui, ctermbg = colors.yellow.term, ctermfg = colors.grey.term})
vim.highlight.create('BadWhitespace', {guibg = colors.red.gui, ctermbg = colors.red.term})
vim.cmd [[
" Highlight whitespace at the end of lines
let m = matchadd('BadWhitespace', '\s\+$')
"Highlight tabs used instead of spaces in red
let m = matchadd('BadWhitespace', '^\t\+')
]]

local colorscheme = vim.fn['sonokai#get_palette']('default')
vim.highlight.create('LuaLineDiagnosticsError', {guibg = lualine_theme.normal.c.bg, guifg = colorscheme.red[1], ctermfg = colorscheme.red[2]})
vim.highlight.create('LuaLineDiagnosticsWarn', {guibg = lualine_theme.normal.c.bg, guifg = colorscheme.yellow[1], ctermfg = colorscheme.yellow[2]})
vim.highlight.create('LuaLineDiagnosticsInfo', {guibg = lualine_theme.normal.c.bg, guifg = colorscheme.blue[1], ctermfg = colorscheme.blue[2]})
vim.highlight.create('LuaLineDiagnosticsHint', {guibg = lualine_theme.normal.c.bg, guifg = colorscheme.green[1], ctermfg = colorscheme.green[2]})

vim.highlight.create('TelescopePreviewBorder', {guifg = colors.orange.gui})
vim.highlight.create('TelescopePromptBorder', {guifg = colors.green.gui})
vim.highlight.create('TelescopeResultsBorder', {guifg = colors.blue.gui})

vim.highlight.link('FidgetTask', 'MoreMsg')
