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

-- temp fix until lazy supports winborder https://github.com/folke/lazy.nvim/issues/1951
local winborder = "rounded"
if vim.fn.exists("+winborder") == 1 and vim.o.winborder ~= "" then
    winborder = vim.opt.winborder:get()
    if vim.isarray(winborder) and #winborder == 1 then
        winborder = winborder[1]
    end
end

-- Install your plugins here
require('lazy').setup({
  spec = {
    { import = 'plugins_' },
  },
  diff = {
    cmd = 'diffview.nvim',
  },
  ui = {
    border = winborder,
  },
})
local lazy_view = require('lazy.view.config')
lazy_view.keys['close'] = '<ESC>' -- close lazy.nvim on Esc
