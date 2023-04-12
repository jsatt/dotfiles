-- Bootstrap lazy.nvim
local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
if not vim.loop.fs_stat(lazypath) then
  vim.fn.system({
    "git",
    "clone",
    "--filter=blob:none",
    "https://github.com/folke/lazy.nvim.git",
    "--branch=stable", -- latest stable release
    lazypath,
  })
end
vim.opt.rtp:prepend(lazypath)

-- Install your plugins here
require('lazy').setup({
  import = 'plugins_',
  ui = {
    border = require('theme_').opts.border_style,
  },
  diff = {
    cmd = 'diffview.nvim',
  },
})
local lazy_view = require('lazy.view.config')
lazy_view.keys['close'] = '<ESC>' -- close lazy.nvim on Esc
