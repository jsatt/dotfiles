local utils = require('utils_')

vim.cmd [[
syntax enable
colorscheme monokai-pro
]]

vim.opt.secure = true -- limit commands .nvimrc can run
vim.cmd('filetype plugin indent on') -- enable filetype detection and fieltype specific plugins and indents
vim.opt.autoindent = true -- copy indent from current line when starting new line
vim.opt.autoread = true -- auto-read if file has changed outside vim but not inside
vim.opt.clipboard = 'unnamedplus' -- copy/paste to/from system clipboard
-- vim.opt.cmdheight = 0 -- use 2 screen lines for command line
vim.opt.completeopt='menu,menuone,noselect'
vim.opt.cursorline = true -- highlight line that cursor is currently on
vim.opt.diffopt:append('linematch:60')
vim.opt.encoding = 'utf8' -- use UTF-8 file encoding
vim.opt.expandtab = true -- use spaces instead of tabs
vim.opt.foldenable = true -- enable folding
vim.opt.foldmethod = 'indent' -- enable indent based code folding
vim.opt.foldlevelstart = 6 -- don't automatically close folds on openunless 6 folds deep
vim.opt.hidden = true -- hide buffers when tab/window closed, needed on to gotodef in unsaved files
vim.opt.history = 1000 -- remember the last 1000 commands used
vim.opt.hlsearch = true -- highlight matches when searching
vim.opt.incsearch = true -- jump to next match when searching
vim.opt.linebreak = true -- visually wrap long lines on breakat characters
-- vim.opt.mouse = 'a' -- enable mouse in all modes
vim.opt.number = true -- show line numbers
vim.opt.numberwidth = 2 -- width of line number column
vim.opt.scrolloff = 10 -- keep lines above and below cursor when scrolliing
vim.opt.shiftwidth = 4 -- 4 spaces for indents when using << or >>
vim.opt.shortmess:append('I') -- don't give intro message when starting
vim.opt.shortmess:append('c') -- don't give |ins-completion-menu| messages
vim.opt.signcolumn = 'yes:2' -- always show sign column, 2 columns wide
vim.opt.smarttab = true -- use <BS> to delete shiftwidth worth of space at start of line
vim.opt.softtabstop = 4 -- 4 spaces for tabsin INSERT mode
vim.opt.spelllang = 'en_us' -- set spell check to US English
vim.opt.splitbelow = true -- open new splits below instead of above
vim.opt.splitright = true -- open new vsplits to the right instead of left
vim.opt.statuscolumn = '%s%l%C'  -- default statuscolumn = signs, line number, fold tree
vim.opt.swapfile = false -- diable swapfiles
vim.opt.switchbuf = 'useopen,usetab,newtab' -- use open buffers when switching
vim.opt.tabstop = 4 -- 4 spaces for tabs
vim.opt.textwidth = 99 -- format lines to <100 characters
local softtextwidth = 90 -- start considering line length at 90
vim.o.colorcolumn = table.concat(utils.range(softtextwidth, vim.opt.textwidth:get()), ',') -- highlight columns to indicate long lines
vim.opt.timeoutlen = 500 -- drop keymap timeout to 500ms
vim.opt.undodir = vim.fn.stdpath('data') .. '/undodir' -- keep undo files
vim.opt.undofile = true -- save undos to files
vim.opt.undolevels = 1000 -- number of undos to keep
vim.opt.updatetime = 300 -- milliseconds to wait before completing typed changes
vim.opt.whichwrap = 'h,l,<,>' -- keys to change lines at start/end of a line
vim.opt.wrap = true -- visually wrap

vim.g.no_plugin_maps = true -- disable default mappings for specific filetypes
vim.g.border_style = require('theme_').opts.border_style
