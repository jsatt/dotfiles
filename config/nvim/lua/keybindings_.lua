vim.keymap.set('n', ';', ':', {noremap = true})
vim.keymap.set('n', ':qt', ':tabc', {silent = true})
vim.keymap.set('n', '<leader>ld', ':Linediff<CR>', {noremap = true, silent = true})
vim.keymap.set('v', '<leader>ld', ":'<,'>Linediff<CR>", {noremap = true, silent = true})
vim.keymap.set('n', '<C-z>', ':UndotreeToggle<CR>', {noremap = true, silent = true})
vim.keymap.set('n', '<leader>a', '<cmd>AerialToggle!<CR>', {})
vim.keymap.set('n', '<leader>t', '<cmd>NvimTreeToggle<CR>', {})
vim.keymap.set('n', '<leader>hg', ':TSHighlightCapturesUnderCursor<CR>', {noremap = true})
vim.keymap.set('n', '<leader>hc', ':Coverage<CR>', {noremap = true})
vim.keymap.set('n', '<leader>hcc', ':CoverageClear<CR>', {noremap = true})

vim.keymap.set('n', '<C-c>', '<C-a>', {}) -- remap increment to avoid clash with screen/tmux

-- remap home and ending keys
vim.keymap.set({'n', 'v'}, 'H', '^', {noremap = true})
vim.keymap.set('n', 'L', '$', {noremap = true})
vim.keymap.set('v', 'L', 'g_', {noremap = true})

-- navigation on wrapped lines
vim.keymap.set('n', 'k', 'v:count == 0 ? "gk": "k"', {noremap = true, expr = true})
vim.keymap.set('n', 'j', 'v:count == 0 ? "gj": "j"', {noremap = true, expr = true})
vim.keymap.set('n', '<Up>', 'v:count == 0 ? "g<Up>": "<Up>"', {noremap = true, expr = true})
vim.keymap.set('n', '<Down>', 'v:count == 0 ? "g<Down>": "<Down>"', {noremap = true, expr = true})

-- navigation between tabs
vim.keymap.set('n', '<C-Right>', ':tabnext<CR>', {noremap = true})
vim.keymap.set('n', '<C-Left>', ':tabprevious<CR>', {noremap = true})
vim.keymap.set('i', '<C-Right>', '<Esc>:tabnext<CR>', {noremap = true, silent = true})
vim.keymap.set('i', '<C-Left>', '<Esc>:tabprevious<CR>', {noremap = true, silent = true})

-- navigation between splits
vim.keymap.set({'n', 'i'}, '<S-Left>', '<C-w>h', {noremap = true})
vim.keymap.set({'n', 'i'}, '<S-Right>', '<C-w>l', {noremap = true})
vim.keymap.set({'n', 'i'}, '<S-Up>', '<C-w>k', {noremap = true})
vim.keymap.set({'n', 'i'}, '<S-Down>', '<C-w>j', {noremap = true})

-- copy to terminal hosts clipboard
vim.keymap.set('v', '<leader>y', 'y:OSCYank<CR>', {noremap = true, silent = true})

-- Telescope
vim.keymap.set('n', '<leader>lf', '<cmd>lua require("telescope.builtin").find_files()<CR>', {noremap = true, silent = true})
vim.keymap.set('n', '<leader>lb', '<cmd>lua require("telescope.builtin").buffers()<CR>', {noremap = true, silent = true})
vim.keymap.set('n', '<leader>ls', '<cmd>lua require("telescope").extensions.aerial.aerial()<CR>', {noremap = true, silent = true})
vim.keymap.set('n', '<leader>lr', '<cmd>lua require("telescope.builtin").oldfiles()<CR>', {noremap = true, silent = true})
vim.keymap.set('n', '<leader>lg', '<cmd>lua require("telescope.builtin").live_grep()<CR>', {noremap = true, silent = true})
vim.keymap.set('n', '<leader>lc', '<cmd>lua require("telescope.builtin").git_commits()<CR>', {noremap = true, silent = true})
vim.keymap.set('n', '<leader>le', '<cmd>lua require("telescope").extensions.emoji.emoji()<CR>', {noremap = true, silent = true})
vim.keymap.set('n', '<leader>lt', '<cmd>lua require("telescope.builtin").builtin({include_extensions = true})<CR>', {noremap = true, silent = true})

-- LSP
vim.keymap.set('n', 'K', '<cmd>Lspsaga hover_doc<CR>', {noremap = true, silent = true})
vim.keymap.set('n', '<C-k>', '<cmd>Lspsaga signature_help<CR>', {noremap = true, silent = true})
vim.keymap.set('n', 'gD', '<cmd>lua vim.lsp.buf.declaration()<CR>', {noremap = true, silent = true})
vim.keymap.set('n', 'gd', '<cmd>lua vim.lsp.buf.definition()<CR>', {noremap = true, silent = true})
vim.keymap.set('n', 'gi', '<cmd>lua vim.lsp.buf.implementation()<CR>', {noremap = true, silent = true})
vim.keymap.set('n', 'gr', '<cmd>lua vim.lsp.buf.references()<CR>', {noremap = true, silent = true})
vim.keymap.set('n', 'gy', '<cmd>lua vim.lsp.buf.type_definition()<CR>', {noremap = true, silent = true})
vim.keymap.set('n', 'gh', '<cmd>Lspsaga lsp_finder<CR>', {noremap = true, silent = true})
vim.keymap.set('n', '<leader>rn', '<cmd>Lspsaga rename<CR>', {noremap = true, silent = true})
vim.keymap.set('n', '<leader>ca', '<cmd>Lspsaga code_action<CR>', {noremap = true, silent = true})
vim.keymap.set('v', '<leader>ca', ':<c-u>Lspsaga range_code_action<CR>', {noremap = true, silent = true})
vim.keymap.set('n', '<leader>f', '<cmd>lua vim.lsp.buf.formatting()<CR>', {noremap = true, silent = true})
vim.keymap.set('v', '<leader>f', '<cmd>lua vim.lsp.buf.range_formatting()<CR>', {noremap = true, silent = true})

-- DAP
-- vim.keymap.set('n', '<leader>dct', '<cmd>lua require"dap".continue()<CR>', {noremap = true, silent = true})
-- vim.keymap.set('n', '<leader>dsv', '<cmd>lua require"dap".step_over()<CR>', {noremap = true, silent = true})
-- vim.keymap.set('n', '<leader>dsi', '<cmd>lua require"dap".step_into()<CR>', {noremap = true, silent = true})
-- vim.keymap.set('n', '<leader>dso', '<cmd>lua require"dap".step_out()<CR>', {noremap = true, silent = true})
-- vim.keymap.set('n', '<leader>dtb', '<cmd>lua require"dap".toggle_breakpoint()<CR>', {noremap = true, silent = true})

-- vim.keymap.set('n', '<leader>dsc', '<cmd>lua require"dap.ui.variables".scopes()<CR>', {noremap = true, silent = true})
-- vim.keymap.set('n', '<leader>dhh', '<cmd>lua require"dap.ui.variables".hover()<CR>', {noremap = true, silent = true})
-- vim.keymap.set('v', '<leader>dhv', '<cmd>lua require"dap.ui.variables".visual_hover()<CR>', {noremap = true, silent = true})

-- vim.keymap.set('n', '<leader>duh', '<cmd>lua require"dap.ui.widgets".hover()<CR>', {noremap = true, silent = true})
-- vim.keymap.set('n', '<leader>duf', '<cmd>lua local widgets=require"dap.ui.widgets";widgets.centered_float(widgets.scopes)<CR>', {noremap = true, silent = true})

-- vim.keymap.set('n', '<leader>dsbr', '<cmd>lua require"dap".set_breakpoint(vim.fn.input("Breakpoint condition: "))<CR>', {noremap = true, silent = true})
-- vim.keymap.set('n', '<leader>dsbm', '<cmd>lua require"dap".set_breakpoint(nil, nil, vim.fn.input("Log point message: "))<CR>', {noremap = true, silent = true})
-- vim.keymap.set('n', '<leader>dro', '<cmd>lua require"dap".repl.open()<CR>', {noremap = true, silent = true})
-- vim.keymap.set('n', '<leader>drl', '<cmd>lua require"dap".repl.run_last()<CR>', {noremap = true, silent = true})
-- vim.keymap.set('n', '<leader>dui', '<cmd>lua require"dapui".toggle()<CR>', {noremap = true, silent = true})


-- -- telescope-dap
-- vim.keymap.set('n', '<leader>dcc', '<cmd>lua require"telescope".extensions.dap.commands{}<CR>', {noremap = true, silent = true})
-- vim.keymap.set('n', '<leader>dco', '<cmd>lua require"telescope".extensions.dap.configurations{}<CR>', {noremap = true, silent = true})
-- vim.keymap.set('n', '<leader>dlb', '<cmd>lua require"telescope".extensions.dap.list_breakpoints{}<CR>', {noremap = true, silent = true})
-- vim.keymap.set('n', '<leader>dv', '<cmd>lua require"telescope".extensions.dap.variables{}<CR>', {noremap = true, silent = true})
-- vim.keymap.set('n', '<leader>df', '<cmd>lua require"telescope".extensions.dap.frames{}<CR>', {noremap = true, silent = true})

-- Diagnostics
vim.keymap.set('n', '<leader>lp', '<cmd>Lspsaga diagnostic_jump_prev<CR>', {noremap = true, silent = true})
vim.keymap.set('n', '<leader>ln', '<cmd>Lspsaga diagnostic_jump_next<CR>', {noremap = true, silent = true})
vim.keymap.set('n', '<leader>d', '<cmd>Lspsaga show_line_diagnostics<CR>', {noremap = true, silent = true})

-- Diff navigation
if vim.opt.diff:get() then
    vim.keymap.set('n', '<leader>n', ']c', {noremap = true, expr = true})
    vim.keymap.set('n', '<leader>p', '[c', {noremap = true, expr = true})
    vim.keymap.set('n', '<leader>gl', ':diffg LOCAL<CR>', {noremap = true, silent = true})
    vim.keymap.set('n', '<leader>gb', ':diffg BASE<CR>', {noremap = true, silent = true})
    vim.keymap.set('n', '<leader>gr', ':diffg REMOTE<CR>', {noremap = true, silent = true})
    vim.keymap.set('n', '<leader>du', ':diffupdate<CR>', {noremap = true, silent = true})
end
