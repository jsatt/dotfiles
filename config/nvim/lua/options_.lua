vim.opt.secure = true -- limit commands .nvimrc can run
vim.cmd('filetype plugin indent on') -- enable filetype detection and fieltype specific plugins and indents
vim.opt.autoindent = true -- copy indent from current line when starting new line
vim.opt.autoread = true -- auto-read if file has changed outside vim but not inside
vim.opt.clipboard = 'unnamedplus' -- copy/paste to/from system clipboard
vim.opt.cmdheight = 2 -- use 2 screen lines for command line
vim.opt.cursorline = true -- highlight line that cursor is currently on
vim.opt.encoding = 'utf8' -- use UTF-8 file encoding
vim.opt.expandtab = true -- use spaces instead of tabs
vim.opt.foldenable = true -- enable folding
vim.opt.foldmethod = 'indent' -- enable indent based code folding
vim.opt.foldlevelstart = 6 -- don't automatically close folds on openunless 6 folds deep
vim.opt.hidden = false -- unload buffers when tab/window closed
vim.opt.history = 1000 -- remember the last 1000 commands used
vim.opt.hlsearch = true -- highlight matches when searching
vim.opt.incsearch = true -- jump to next match when searching
vim.opt.laststatus = 2 -- show status line
vim.opt.linebreak = true -- visually wrap long lines on breakat characters
vim.opt.mouse = 'a' -- enable mouse in all modes
vim.opt.number = true -- show line numbers
vim.opt.numberwidth = 2 -- width of line number column
vim.opt.scrolloff = 20 -- keep lines above and below cursor when scrolliing
vim.opt.shiftwidth = 4 -- 4 spaces for indents when using << or >>
vim.opt.shortmess:append('I') -- don't give intro message when starting
vim.opt.shortmess:append('c') -- don't give |ins-completion-menu| messages
vim.opt.signcolumn = 'yes' -- always show sign column, 2 columns wide
vim.opt.smarttab = true -- use <BS> to delete shiftwidth worth of space at start of line
vim.opt.softtabstop = 4 -- 4 spaces for tabsin INSERT mode
vim.opt.splitbelow = true -- open new splits below instead of above
vim.opt.splitright = true -- open new vsplits to the right instead of left
vim.opt.swapfile = false -- diable swapfiles
vim.opt.switchbuf = 'useopen,usetab,newtab' -- use open buffers when switching
vim.opt.tabstop = 4 -- 4 spaces for tabs
vim.opt.textwidth = 99 -- format lines to <100 characters
-- local softtextwidth = 90 -- start considering line length at 90
vim.o.colorcolumn = '90,91,92,93,94,95,96,97,98,99' -- highlight columns to indicate long lines
vim.opt.timeoutlen = 500 -- drop keymap timeout to 500ms
vim.opt.undodir = vim.fn.stdpath('data') .. '/undodir' -- keep undo files
vim.opt.undofile = true -- save undos to files
vim.opt.undolevels = 1000 -- number of undos to keep
vim.opt.updatetime = 300 -- milliseconds to wait before completing typed changes
vim.opt.whichwrap = 'h,l,<,>' -- keys to change lines at start/end of a line
vim.opt.wrap = true -- visually wrap

vim.g.border_style = 'rounded'

local signs = require('theme_').signs

for _, sign in pairs(signs) do
  vim.fn.sign_define(sign.name, { texthl = sign.name, text = sign.text, numhl = sign.name })
end

vim.diagnostic.config {
  signs = {
    active = signs,
  },
  update_in_insert = true,
  underline = true,
  severity_sort = true,
  float = {
    focusable = false,
    style = "minimal",
    border = "rounded",
    source = "always",
    header = "",
    prefix = "",
  },
}
