local theme = require('theme_')
local colors = theme.colors
local lualine_theme = theme.lualine_theme

vim.g.sonokai_transparent_background = 1
vim.g.sonokai_diagnostic_virtual_text = 'colored'
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

-- vim.highlight.create('FloatBorder', {guifg = colors.grey.gui, ctermfg = colors.grey.term})
vim.highlight.link('FloatBorder', 'Float', true)
vim.highlight.link('FloatTitle', 'Normal', true)
vim.highlight.link('NormalFloat', 'Normal', true)

local sonokai_config = vim.fn['sonokai#get_configuration']()
local colorscheme = vim.fn['sonokai#get_palette'](sonokai_config.style, sonokai_config.colors_override)
vim.highlight.create('DiagnosticError', {guifg = colorscheme.red[1], ctermfg = colorscheme.red[2]})
vim.highlight.create('DiagnosticWarn', {guifg = colorscheme.yellow[1], ctermfg = colorscheme.yellow[2]})
vim.highlight.create('DiagnosticInfo', {guifg = colorscheme.blue[1], ctermfg = colorscheme.blue[2]})
vim.highlight.create('DiagnosticHint', {guifg = colorscheme.green[1], ctermfg = colorscheme.green[2]})
vim.highlight.create('LuaLineDiagnosticsError', {guibg = lualine_theme.normal.c.bg, guifg = colorscheme.red[1], ctermfg = colorscheme.red[2]})
vim.highlight.create('LuaLineDiagnosticsWarn', {guibg = lualine_theme.normal.c.bg, guifg = colorscheme.yellow[1], ctermfg = colorscheme.yellow[2]})
vim.highlight.create('LuaLineDiagnosticsInfo', {guibg = lualine_theme.normal.c.bg, guifg = colorscheme.blue[1], ctermfg = colorscheme.blue[2]})
vim.highlight.create('LuaLineDiagnosticsHint', {guibg = lualine_theme.normal.c.bg, guifg = colorscheme.green[1], ctermfg = colorscheme.green[2]})

vim.highlight.create('TelescopePreviewBorder', {guifg = colors.orange.gui})
vim.highlight.create('TelescopePromptBorder', {guifg = colors.green.gui})
vim.highlight.create('TelescopeResultsBorder', {guifg = colors.blue.gui})

vim.highlight.link('FidgetTask', 'MoreMsg')
vim.highlight.link('HighlightedyankRegion', 'IncSearch', true)

vim.highlight.create('VirtualTextError',  {guifg = colors.dim_red.gui, ctermfg = colors.dim_red.term})
vim.highlight.create('VirtualTextWarning', {guifg = colors.dim_yellow.gui, ctermfg = colors.dim_yellow.term})
vim.highlight.create('VirtualTextInfo',  {guifg = colors.dim_blue.gui, ctermfg = colors.dim_blue.term})
vim.highlight.create('VirtualTextHint', {guifg = colors.dim_green.gui, ctermfg = colors.dim_green.term})

vim.highlight.link('CoverageCovered', 'GreenSign')
vim.highlight.link('CoverageUncovered', 'RedSign')
