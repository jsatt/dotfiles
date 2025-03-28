vim.bo.shiftwidth = 2 -- 2 spaces for indents when using << or >>
vim.bo.softtabstop = 2 -- 2 spaces for tabs in INSERT mode
vim.bo.tabstop = 2 -- 2 space for tabs

vim.g.vim_markdown_folding_disabled = 1
vim.api.nvim_buf_set_keymap(0, 'n', '<leader>md', ':%!Markdown.pl --html4tags <cr>', {noremap = true})
