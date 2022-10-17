vim.wo.spell = true
vim.g.vim_markdown_folding_disabled = 1
vim.api.nvim_buf_set_keymap(0, 'n', '<leader>md', ':%!Markdown.pl --html4tags <cr>', {noremap = true})
