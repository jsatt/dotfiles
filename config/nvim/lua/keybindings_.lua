vim.api.nvim_set_keymap('n', ';', ':', {noremap = true})
vim.api.nvim_set_keymap('n', ':qt', ':tabc', {silent = true})
vim.api.nvim_set_keymap('n', '<leader>ld', ':Linediff<CR>', {noremap = true, silent = true})
vim.api.nvim_set_keymap('n', '<C-z>', ':UndotreeToggle<CR>', {noremap = true, silent = true})
vim.api.nvim_set_keymap('n', '<leader>a', '<cmd>AerialToggle!<CR>', {})
vim.api.nvim_set_keymap('n', '<leader>t', '<cmd>NvimTreeToggle<CR>', {})
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
vim.api.nvim_set_keymap('n', '<C-Right>', ':tabnext<CR>', {noremap = true})
vim.api.nvim_set_keymap('n', '<C-Left>', ':tabprevious<CR>', {noremap = true})
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

-- Telescope
vim.api.nvim_set_keymap('n', '<leader>lf', '<cmd>lua require("telescope.builtin").find_files()<CR>', {noremap = true, silent = true})
vim.api.nvim_set_keymap('n', '<leader>lb', '<cmd>lua require("telescope.builtin").buffers()<CR>', {noremap = true, silent = true})
vim.api.nvim_set_keymap('n', '<leader>ls', '<cmd>lua require("telescope").extensions.aerial.aerial()<CR>', {noremap = true, silent = true})
vim.api.nvim_set_keymap('n', '<leader>lr', '<cmd>lua require("telescope.builtin").oldfiles()<CR>', {noremap = true, silent = true})
vim.api.nvim_set_keymap('n', '<leader>lg', '<cmd>lua require("telescope.builtin").live_grep()<CR>', {noremap = true, silent = true})
vim.api.nvim_set_keymap('n', '<leader>lc', '<cmd>lua require("telescope.builtin").git_commits()<CR>', {noremap = true, silent = true})
vim.api.nvim_set_keymap('n', '<leader>le', '<cmd>lua require("telescope").extensions.emoji.emoji()<CR>', {noremap = true, silent = true})
vim.api.nvim_set_keymap('n', '<leader>lt', '<cmd>lua require("telescope.builtin").builtin()<CR>', {noremap = true, silent = true})

-- LSP
vim.api.nvim_set_keymap('n', 'K', '<cmd>Lspsaga hover_doc<CR>', {noremap = true, silent = true})
vim.api.nvim_set_keymap('n', '<C-k>', '<cmd>Lspsaga signature_help<CR>', {noremap = true, silent = true})
vim.api.nvim_set_keymap('n', 'gD', '<cmd>lua vim.lsp.buf.declaration()<CR>', {noremap = true, silent = true})
vim.api.nvim_set_keymap('n', 'gd', '<cmd>lua vim.lsp.buf.definition()<CR>', {noremap = true, silent = true})
vim.api.nvim_set_keymap('n', 'gi', '<cmd>lua vim.lsp.buf.implementation()<CR>', {noremap = true, silent = true})
vim.api.nvim_set_keymap('n', 'gr', '<cmd>lua vim.lsp.buf.references()<CR>', {noremap = true, silent = true})
vim.api.nvim_set_keymap('n', 'gy', '<cmd>lua vim.lsp.buf.type_definition()<CR>', {noremap = true, silent = true})
vim.api.nvim_set_keymap('n', 'gh', '<cmd>Lspsaga lsp_finder<CR>', {noremap = true, silent = true})
vim.api.nvim_set_keymap('n', '<leader>rn', '<cmd>Lspsaga rename<CR>', {noremap = true, silent = true})
vim.api.nvim_set_keymap('n', '<leader>ca', '<cmd>Lspsaga code_action<CR>', {noremap = true, silent = true})
vim.api.nvim_set_keymap('v', '<leader>ca', ':<c-u>Lspsaga range_code_action<CR>', {noremap = true, silent = true})
vim.api.nvim_set_keymap('n', '<leader>f', '<cmd>lua vim.lsp.buf.formatting()<CR>', {noremap = true, silent = true})
vim.api.nvim_set_keymap('v', '<leader>f', '<cmd>lua vim.lsp.buf.range_formatting()<CR>', {noremap = true, silent = true})

-- Diagnostics
vim.api.nvim_set_keymap('n', '<leader>lp', '<cmd>Lspsaga diagnostic_jump_prev<CR>', {noremap = true, silent = true})
vim.api.nvim_set_keymap('n', '<leader>ln', '<cmd>Lspsaga diagnostic_jump_next<CR>', {noremap = true, silent = true})
vim.api.nvim_set_keymap('n', '<leader>d', '<cmd>Lspsaga show_line_diagnostics<CR>', {noremap = true, silent = true})

-- Diff navigation
if vim.opt.diff:get() then
    vim.api.nvim_set_keymap('n', '<leader>n', ']c', {noremap = true, expr = true})
    vim.api.nvim_set_keymap('n', '<leader>p', '[c', {noremap = true, expr = true})
    vim.api.nvim_set_keymap('n', '<leader>gl', ':diffg LOCAL<CR>', {noremap = true, silent = true})
    vim.api.nvim_set_keymap('n', '<leader>gb', ':diffg BASE<CR>', {noremap = true, silent = true})
    vim.api.nvim_set_keymap('n', '<leader>gr', ':diffg REMOTE<CR>', {noremap = true, silent = true})
    vim.api.nvim_set_keymap('n', '<leader>du', ':diffupdate<CR>', {noremap = true, silent = true})
end
