vim.api.nvim_set_keymap('n', ';', ':', {noremap = true})
vim.api.nvim_set_keymap('n', ':qt', ':tabc', {silent = true})
vim.api.nvim_set_keymap('n', '<leader>ld', ':Linediff<CR>', {noremap = true, silent = true})
vim.api.nvim_set_keymap('n', '<C-z>', ':UndotreeToggle<CR>', {noremap = true, silent = true})
--vim.api.nvim_buf_set_keymap(0, 'n', '[M', '<Plug>(PythonsenseEndOfPythonFunction)')
--vim.api.nvim_set_keymap('', '<leader>sa', ':s/\%V\([^(),]*\), \([^(),]*\)/\2, \1/<CR>')
vim.api.nvim_set_keymap('n', '<leader>hg', ':TSHighlightCapturesUnderCursor<CR>', {noremap = true})

vim.api.nvim_set_keymap('n', '<C-c>', '<C-a>', {}) -- remap increment to avoid clash with screen/tmux

-- remap home and ending keys
vim.api.nvim_set_keymap('n', 'H', '^', {noremap = true})
vim.api.nvim_set_keymap('v', 'H', '^', {noremap = true})
vim.api.nvim_set_keymap('n', 'L', '$', {noremap = true})
vim.api.nvim_set_keymap('v', 'L', 'g_', {noremap = true})

-- navigation on wrapped lines
vim.api.nvim_set_keymap('n', 'k', 'v:count == 0 ? "gk": "k"', {noremap = true, expr = true})
vim.api.nvim_set_keymap('n', 'j', 'v:count == 0 ? "gj": "j"', {noremap = true, expr = true})
vim.api.nvim_set_keymap('n', '<Up>', 'v:count == 0 ? "g<Up>": "<Up>"', {noremap = true, expr = true})
vim.api.nvim_set_keymap('n', '<Down>', 'v:count == 0 ? "g<Down>": "<Down>"', {noremap = true, expr = true})

-- navigation between tabs
vim.api.nvim_set_keymap('n', '<C-Right>', ':tabnext<CR>', {noremap = true, silent = true})
vim.api.nvim_set_keymap('n', '<C-Left>', ':tabprevious<CR>', {noremap = true, silent = true})
vim.api.nvim_set_keymap('i', '<C-Right>', '<Esc>:tabnext<CR>', {noremap = true, silent = true})
vim.api.nvim_set_keymap('i', '<C-Left>', '<Esc>:tabprevious<CR>', {noremap = true, silent = true})

-- navigation between splits
vim.api.nvim_set_keymap('n', '<S-Left>', '<C-w>h', {noremap = true})
vim.api.nvim_set_keymap('n', '<S-Right>', '<C-w>l', {noremap = true})
vim.api.nvim_set_keymap('n', '<S-Up>', '<C-w>k', {noremap = true})
vim.api.nvim_set_keymap('n', '<S-Down>', '<C-w>j', {noremap = true})
vim.api.nvim_set_keymap('i', '<S-Left>', '<C-w>h', {noremap = true})
vim.api.nvim_set_keymap('i', '<S-Right>', '<C-w>l', {noremap = true})
vim.api.nvim_set_keymap('i', '<S-Up>', '<C-w>k', {noremap = true})
vim.api.nvim_set_keymap('i', '<S-Down>', '<C-w>j', {noremap = true})

-- copy to terminal hosts clipboard
vim.api.nvim_set_keymap('v', '<leader>y', 'y:OSCYank<CR>', {noremap = true, silent = true})

-- LSP
vim.api.nvim_set_keymap('n', 'K', '<cmd>lua vim.lsp.buf.hover()<CR>', {noremap = true, silent = true})
vim.api.nvim_set_keymap('n', '<C-k>', '<cmd>lua vim.lsp.buf.signature_help()<CR>', {noremap = true, silent = true})
vim.api.nvim_set_keymap('n', 'gD', '<cmd>lua vim.lsp.buf.declaration()<CR>', {noremap = true, silent = true})
vim.api.nvim_set_keymap('n', 'gd', '<cmd>lua vim.lsp.buf.definition()<CR>', {noremap = true, silent = true})
vim.api.nvim_set_keymap('n', 'gi', '<cmd>lua vim.lsp.buf.implementation()<CR>', {noremap = true, silent = true})
vim.api.nvim_set_keymap('n', 'gr', '<cmd>lua vim.lsp.buf.references()<CR>', {noremap = true, silent = true})
vim.api.nvim_set_keymap('n', 'gy', '<cmd>lua vim.lsp.buf.type_definition()<CR>', {noremap = true, silent = true})
vim.api.nvim_set_keymap('n', '<leader>rn', '<cmd>lua vim.lsp.buf.rename()<CR>', {noremap = true, silent = true})
vim.api.nvim_set_keymap('x', '<leader>ra', '<cmd>lua vim.lsp.buf.code_action()<CR>', {noremap = true, silent = true})

-- Diagnostics
vim.api.nvim_set_keymap('n', '<leader>lp', '<cmd>lua vim.diagnostic.goto_prev()<CR>', {noremap = true, silent = true})
vim.api.nvim_set_keymap('n', '<leader>ln', '<cmd>lua vim.diagnostic.goto_next()<CR>', {noremap = true, silent = true})
vim.api.nvim_set_keymap('n', '<leader>d', '<cmd>lua vim.diagnostic.open_float()<CR>', {noremap = true, silent = true})

-- COC
-- vim.api.nvim_set_keymap('n', 'K', ':call _COC_show_documentation()<CR>', {noremap = true, silent = true})
-- vim.api.nvim_set_keymap('n', '<leader>lp', '<Plug>(coc-diagnostic-prev)', {silent = true})
-- vim.api.nvim_set_keymap('n', '<leader>ln', '<Plug>(coc-diagnostic-next)', {silent = true})
-- vim.api.nvim_set_keymap('n', '<leader>lf', ':<C-u>CocList -A -N files<CR>', {noremap = true, silent = true})
-- vim.api.nvim_set_keymap('n', '<leader>ls', ':<C-u>CocList -I -N symbols<CR>', {noremap = true, silent = true})
-- vim.api.nvim_set_keymap('n', '<leader>ly', ':<C-u>CocList -A --normal yank<CR>', {noremap = true, silent = true})
-- vim.api.nvim_set_keymap('n', '<leader>lr', ':<C-u>CocList -A -N mru<CR>', {noremap = true, silent = true})
-- vim.api.nvim_set_keymap('n', '<leader>lb', ':<C-u>CocList -A -N --normal buffers<CR>', {noremap = true, silent = true})
-- vim.api.nvim_set_keymap('n', '<leader>rn', '<Plug>(coc-rename)', {silent = true})
-- vim.api.nvim_set_keymap('n', '<leader>rf', '<Plug>(coc-refactor)', {silent = true})
-- vim.api.nvim_set_keymap('x', '<leader>ra', '<Plug>(coc-codeaction-selected)', {silent = true})
-- vim.api.nvim_set_keymap('i', '<Tab>', 'pumvisible() ? "<C-n>" : _COC_check_back_space() ? "<Tab>" : coc#refresh()', {noremap = true, silent = true, expr = true})
-- vim.api.nvim_set_keymap('i', '<S-Tab>', 'pumvisible() ? "<C-p>" : "<C-h>"', {noremap = true, expr = true})
-- vim.api.nvim_set_keymap('i', '<CR>', 'pumvisible() ? "<C-y>" : "<C-g>u<CR>"', {noremap = true, expr = true})

-- COC gotos
-- vim.api.nvim_set_keymap('n', 'gd', '<Plug>(coc-definition)', {silent = true})
-- vim.api.nvim_set_keymap('n', 'gy', '<Plug>(coc-type-definition)', {silent = true})
-- vim.api.nvim_set_keymap('n', 'gi', '<Plug>(coc-implementation)', {silent = true})
-- vim.api.nvim_set_keymap('n', 'gr', '<Plug>(coc-references)', {silent = true})

-- Diff navigation
if vim.opt.diff:get() then
    vim.api.nvim_set_keymap('n', '<leader>n', ']c', {noremap = true, expr = true})
    vim.api.nvim_set_keymap('n', '<leader>p', '[c', {noremap = true, expr = true})
    vim.api.nvim_set_keymap('n', '<leader>gl', ':diffg LOCAL<CR>', {noremap = true, silent = true})
    vim.api.nvim_set_keymap('n', '<leader>gb', ':diffg BASE<CR>', {noremap = true, silent = true})
    vim.api.nvim_set_keymap('n', '<leader>gr', ':diffg REMOTE<CR>', {noremap = true, silent = true})
    vim.api.nvim_set_keymap('n', '<leader>du', ':diffupdate<CR>', {noremap = true, silent = true})
end
