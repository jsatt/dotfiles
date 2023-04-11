local theme = require('theme_')
local colors = theme.colors
local lualine_theme = theme.lualine_theme

vim.g.sonokai_transparent_background = 1
vim.g.sonokai_diagnostic_virtual_text = 'colored'
vim.cmd [[
syntax enable
colorscheme sonokai
]]

vim.api.nvim_set_hl(0, 'DiffDelete',  {bg = colors.dark_red.gui})
vim.api.nvim_set_hl(0, 'DiffAdd', {bg = colors.dark_green.gui})
vim.api.nvim_set_hl(0, 'DiffChange', {bg = colors.dark_yellow.gui})
vim.api.nvim_set_hl(0, 'DiffText', {fg = colors.grey.gui, bg = colors.yellow.gui})
vim.api.nvim_set_hl(0, 'BadWhitespace', {bg = colors.red.gui})
vim.cmd [[
" Highlight whitespace at the end of lines
let m = matchadd('BadWhitespace', '\s\+$')
"Highlight tabs used instead of spaces in red
let m = matchadd('BadWhitespace', '^\t\+')
]]

-- vim.api.nvim_set_hl(0,'FloatBorder', {fg = colors.grey.gui, ctermfg = colors.grey.term})
vim.api.nvim_set_hl(0, 'FloatBorder', {link = 'Float'})
vim.api.nvim_set_hl(0, 'FloatTitle', {link = 'Normal'})
vim.api.nvim_set_hl(0, 'NormalFloat', {link = 'Normal'})
vim.api.nvim_set_hl(0, 'VertSplit', {fg = colors.dim_yellow.gui})
vim.api.nvim_set_hl(0, 'CursorLineFold', {link = 'CursorLineNr'})

local sonokai_config = vim.fn['sonokai#get_configuration']()
local colorscheme = vim.fn['sonokai#get_palette'](sonokai_config.style, sonokai_config.colors_override)
vim.api.nvim_set_hl(0, 'DiagnosticError', {fg = colorscheme.red[1]})
vim.api.nvim_set_hl(0, 'DiagnosticWarn', {fg = colorscheme.yellow[1]})
vim.api.nvim_set_hl(0, 'DiagnosticInfo', {fg = colorscheme.blue[1]})
vim.api.nvim_set_hl(0, 'DiagnosticHint', {fg = colorscheme.green[1]})
vim.api.nvim_set_hl(0, 'LuaLineDiagnosticsError', {bg = lualine_theme.normal.c.bg, fg = colorscheme.red[1]})
vim.api.nvim_set_hl(0, 'LuaLineDiagnosticsWarn', {bg = lualine_theme.normal.c.bg, fg = colorscheme.yellow[1]})
vim.api.nvim_set_hl(0, 'LuaLineDiagnosticsInfo', {bg = lualine_theme.normal.c.bg, fg = colorscheme.blue[1]})
vim.api.nvim_set_hl(0, 'LuaLineDiagnosticsHint', {bg = lualine_theme.normal.c.bg, fg = colorscheme.green[1]})

vim.api.nvim_set_hl(0,'TelescopePreviewBorder', {fg = colors.orange.gui})
vim.api.nvim_set_hl(0,'TelescopePromptBorder', {fg = colors.green.gui})
vim.api.nvim_set_hl(0,'TelescopeResultsBorder', {fg = colors.blue.gui})

vim.api.nvim_set_hl(0, 'FidgetTask', {link = 'MoreMsg'})
vim.api.nvim_set_hl(0, 'HighlightedyankRegion', {link = 'IncSearch'})

vim.api.nvim_set_hl(0, 'VirtualTextError',  {fg = colors.dim_red.gui})
vim.api.nvim_set_hl(0, 'VirtualTextWarning', {fg = colors.dim_yellow.gui})
vim.api.nvim_set_hl(0, 'VirtualTextInfo',  {fg = colors.dim_blue.gui})
vim.api.nvim_set_hl(0, 'VirtualTextHint', {fg = colors.dim_green.gui})

vim.api.nvim_set_hl(0, 'CoverageCovered', {link = 'GreenSign'})
vim.api.nvim_set_hl(0, 'CoverageUncovered', {link = 'RedSign'})
