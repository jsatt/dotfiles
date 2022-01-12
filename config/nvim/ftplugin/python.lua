vim.api.nvim_buf_set_keymap(0, 'n', '<leader>is', ':!isort %<CR><CR><CR>', {noremap = true, silent = true})
vim.api.nvim_buf_set_keymap(0, 'n', '<leader>hc', ':HighlightCoverage<CR><CR>', {noremap = true, silent = true})
vim.api.nvim_buf_set_keymap(0, 'n', '<leader>cn', ':NextUncovered<CR>', {noremap = true, silent = true})
vim.api.nvim_buf_set_keymap(0, 'n', '<leader>cp', ':PrevtUncovered<CR>', {noremap = true, silent = true})
