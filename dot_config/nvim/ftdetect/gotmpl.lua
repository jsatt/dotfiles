vim.cmd [[
autocmd BufNewFile,BufRead * if search('{{.\+}}', 'nw') | setlocal filetype=gotmpl | endif
]]
-- vim.api.nvim_create_autocmd(['BufNewFile', 'BufRead'], {
--     group = vim.api.nvim_create_augroup('gotmpl_detection', {clear = true}),
--     callback = function()
--        vim.highlight.on_yank { higroup='HighlightedyankRegion', timeout=500 }

