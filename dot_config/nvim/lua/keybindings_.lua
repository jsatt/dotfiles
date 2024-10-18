local utils = require('utils_')

vim.keymap.set('n', ';', ':')
vim.keymap.set('n', ':qt', ':tabc', { silent = true, desc = 'Close Tab' })
vim.keymap.set('n', '<leader>ld', ':Linediff<CR>', { silent = true, desc = 'Linediff' })
vim.keymap.set('v', '<leader>ld', ":'<,'>Linediff<CR>", { silent = true, desc = 'Linediff' })
vim.keymap.set('n', '<leader>a', '<cmd>AerialToggle!<CR>', { desc = 'Toggle Aerial' })
vim.keymap.set('n', '<leader>t', '<cmd>Neotree toggle filesystem<CR>', { desc = 'Toggle File Tree' })
vim.keymap.set('n', '<leader>hg', ':Inspect<CR>', { desc = 'Inspect' })
vim.keymap.set('n', '<leader>hc', ':Coverage<CR>', { desc = 'Show test coverage' })
vim.keymap.set('n', '<leader>hcc', ':CoverageClear<CR>', { desc = 'Clear test coverage' })
vim.keymap.set('n', '<leader>/', ':let @/ = ""<CR>', { desc = 'Clear search' })
vim.keymap.set('n', '<leader>gb', ':BlameToggle<CR>', { desc = 'Toggle Git Blame' })

vim.keymap.set('n', '<C-c>', '<C-a>') -- remap increment to avoid clash with screen/tmux
utils.prepare_module('dial.map', function(dial)
  vim.keymap.set('n', '<C-c>', dial.inc_normal(), { noremap = true, desc = 'Increment' }) -- remap increment to avoid clash with screen/tmux
  vim.keymap.set('n', '<C-x>', dial.dec_normal(), { noremap = true, desc = 'Decrement' }) -- remap increment to avoid clash with screen/tmux
  vim.keymap.set('v', '<C-c>', dial.inc_visual(), { noremap = true, desc = 'Increment' }) -- remap increment to avoid clash with screen/tmux
  vim.keymap.set('v', '<C-x>', dial.dec_visual(), { noremap = true, desc = 'Decrement' }) -- remap increment to avoid clash with screen/tmux
  vim.keymap.set('v', 'g<C-c>', dial.inc_gvisual(), { noremap = true, desc = 'Increment' }) -- remap increment to avoid clash with screen/tmux
  vim.keymap.set('v', 'g<C-x>', dial.dec_gvisual(), { noremap = true, desc = 'Decrement' }) -- remap increment to avoid clash with screen/tmux
end)

-- remap home and ending keys
vim.keymap.set({ 'n', 'v' }, 'H', '^', { desc = 'Goto start of line' })
vim.keymap.set('n', 'L', '$', { desc = 'Goto end of line' })
vim.keymap.set('v', 'L', 'g_', { desc = 'Goto end of line' })

-- navigation on wrapped lines
vim.keymap.set('n', 'k', 'v:count == 0 ? "gk": "k"', { expr = true })
vim.keymap.set('n', 'j', 'v:count == 0 ? "gj": "j"', { expr = true })
vim.keymap.set('n', '<Up>', 'v:count == 0 ? "gk": "k"', { expr = true })
vim.keymap.set('n', '<Down>', 'v:count == 0 ? "gj": "j"', { expr = true })

-- navigation between tabs
vim.keymap.set('n', '<C-Right>', ':tabnext<CR>', { desc = 'Navigate tabs - right' })
vim.keymap.set('n', '<C-Left>', ':tabprevious<CR>', { desc = 'Navigate tabs - left' })
vim.keymap.set('i', '<C-Right>', '<Esc>:tabnext<CR>', { silent = true, desc = 'Navigate tabs - right' })
vim.keymap.set('i', '<C-Left>', '<Esc>:tabprevious<CR>', { silent = true, desc = 'Navigate tabs - left' })
vim.keymap.set('n', '<A-Right>', ':tabm +1<CR>', { desc = 'Move tab right' })
vim.keymap.set('n', '<A-Left>', ':tabm -1<CR>', { desc = 'Move tab right' })
vim.keymap.set('i', '<A-Right>', '<Esc>:tabm +1<CR>', { silent = true, desc = 'Move tab right' })
vim.keymap.set('i', '<A-Left>', '<Esc>:tabim -1<CR>', { silent = true, desc = 'Move tab left' })

-- navigation between splits
vim.keymap.set({ 'n', 'i' }, '<S-Left>', '<C-w>h', { desc = 'Navigate splits - left' })
vim.keymap.set({ 'n', 'i' }, '<S-Right>', '<C-w>l', { desc = 'Navigate splits - right' })
vim.keymap.set({ 'n', 'i' }, '<S-Up>', '<C-w>k', { desc = 'Navigate splits - up' })
vim.keymap.set({ 'n', 'i' }, '<S-Down>', '<C-w>j', { desc = 'Navigate splits - down' })

-- copy to terminal hosts clipboard
vim.keymap.set({'n', 'v'}, '<leader>y', '"+y', { desc = 'Copy to system clipboard' })
vim.keymap.set('n', '<leader>yy', '"+yy', { desc = 'Copy line to system clipboard' })

-- Telescope
utils.prepare_module('telescope', function(telescope)
  local telescope_builtin = require('telescope.builtin')
  vim.keymap.set('n', '<C-z>', telescope.extensions.undo.undo, { silent = true, desc = 'Toggle Undotree' })
  vim.keymap.set('n', '<leader>lf', telescope_builtin.find_files, { silent = true, desc = 'Find Files' })
  vim.keymap.set('n', '<leader>lb', telescope_builtin.buffers, { silent = true, desc = 'Find Buffers' })
  vim.keymap.set('n', '<leader>lr', telescope_builtin.oldfiles, { silent = true, desc = 'Find Recently Opened Files' })
  vim.keymap.set('n', '<leader>lg', telescope_builtin.live_grep, { silent = true, desc = 'Live Grep' })
  vim.keymap.set('n', '<leader>lc', telescope_builtin.git_commits, { silent = true, desc = 'Search Commits' })
  vim.keymap.set('n', '<leader>lfc', telescope.extensions.git_file_history.git_file_history, { silent = true, desc = 'Search Commits' })
  vim.keymap.set('n', '<leader>le', telescope.extensions.emoji.emoji, { silent = true, desc = 'Find Emoji' })
  vim.keymap.set('n', '<leader>lt', function() telescope_builtin.builtin({ include_extensions = true }) end, { silent = true, desc = 'Fine Telescope Picker' })
  utils.prepare_module('aerial', function(aerial)
    vim.keymap.set('n', '<leader>ls', telescope.extensions.aerial.aerial, { silent = true, desc = 'Find Symbols' })
  end)
end)

-- LSP
vim.keymap.set("n", "K", vim.lsp.buf.hover, { silent = true, desc = 'Show hover info' })
vim.keymap.set('n', 'gd', function() utils.open_in('vsplit', vim.lsp.buf.definition) end, { silent = true, desc = 'Goto definition' })
vim.keymap.set('n', 'gD', function() utils.open_in('tab', vim.lsp.buf.declaration) end, { silent = true, desc = 'Goto declaration' })
vim.keymap.set('n', 'gi', function() utils.open_in('tab', vim.lsp.buf.implementation) end, { silent = true, desc = 'Goto implementation' })
vim.keymap.set('n', 'gr', vim.lsp.buf.references, { silent = true, desc = 'Show references' })
vim.keymap.set('n', 'gy', function() utils.open_in('tab', vim.lsp.buf.type_definition) end, { silent = true, desc = 'Goto type definition' })
vim.keymap.set("n", "gs", vim.lsp.buf.signature_help, { silent = true, desc = 'Show signature' })
vim.keymap.set({ 'n', 'v' }, '<leader>f', function() vim.lsp.buf.format({ async = true }) end, { silent = true, desc = 'Format' })
vim.keymap.set('n', '<leader>rn', vim.lsp.buf.rename, { silent = true, desc = 'Rename' })
vim.keymap.set({ 'n', 'v' }, '<leader>ca', vim.lsp.buf.code_action, { silent = true, desc = 'Code Actions' })

-- DAP
utils.prepare_module('dap', function(dap)
  vim.keymap.set('n', '<leader>dd', dap.disconnect, { silent = true, desc = 'Disconnect DAP' })
  vim.keymap.set('n', '<leader>dc', dap.continue, { silent = true, desc = 'DAP - Continue' })
  vim.keymap.set('n', '<leader>dn', dap.step_over, { silent = true, desc = 'DAP - Step over' })
  vim.keymap.set('n', '<leader>ds', dap.step_into, { silent = true, desc = 'DAP - Step into' })
  vim.keymap.set('n', '<leader>du', dap.step_out, { silent = true, desc = 'DAP - Step out' })
  vim.keymap.set('n', '<leader>db', dap.toggle_breakpoint, { silent = true, desc = 'DAP - toggle_breakpoint' })
  vim.keymap.set('n', '<leader>dB', function() dap.set_breakpoint(vim.fn.input("Breakpoint condition: ")) end, { silent = true, desc = 'DAP - Set conditional breakpoint' })
  vim.keymap.set('n', '<leader>dl', function() dap.set_breakpoint(nil, nil, vim.fn.input("Log point message: ")) end, { silent = true, desc = 'DAP - Set log point' })
  vim.keymap.set('n', '<leader>dr', dap.repl.open, { silent = true, desc = 'DAP - Open REPL' })

  utils.prepare_module('dapui', function(dapui)
    vim.keymap.set('n', '<leader>di', dapui.toggle, { silent = true, desc = 'DAP - Open UI' })
    vim.keymap.set('n', '<leader>de', dapui.eval, { silent = true, desc = 'DAP - Evaluate' })
    vim.keymap.set('n', '<leader>dhs', function() dapui.float_element('scopes') end, { silent = true, desc = 'Show DAP scopes' })
    vim.keymap.set('n', '<leader>dhf', function() dapui.float_element('stacks') end, { silent = true, desc = 'Show DAP stacks' })
    vim.keymap.set('n', '<leader>dhw', function() dapui.float_element('watched') end, { silent = true, desc = 'Show DAP watches' })
    vim.keymap.set('n', '<leader>dht', function() dapui.float_element('threads') end, { silent = true, desc = 'Show DAP threads' })
  end)

  -- telescope-dap
  vim.keymap.set('n', '<leader>dcc', '<cmd>lua require"telescope".extensions.dap.commands{}<CR>', { silent = true, desc = 'Find DAP commands' })
  vim.keymap.set('n', '<leader>dco', '<cmd>lua require"telescope".extensions.dap.configurations{}<CR>', { silent = true, desc = 'Find DAP configurations' })
  vim.keymap.set('n', '<leader>dv', '<cmd>lua require"telescope".extensions.dap.variables{}<CR>', { silent = true, desc = 'Find DAP variables' })
  vim.keymap.set('n', '<leader>df', '<cmd>lua require"telescope".extensions.dap.frames{}<CR>', { silent = true, desc = 'Find DAP frames' })
end)

-- Diff navigation
if vim.opt.diff:get() then
  vim.keymap.set('n', '<leader>n', ']c', { desc = 'Goto next diff conflict' })
  vim.keymap.set('n', '<leader>p', '[c', { desc = 'Goto previous diff conflict' })
  vim.keymap.set('n', '<leader>gl', ':diffget LOCAL<CR>', { silent = true, desc = 'Diff - select local' })
  vim.keymap.set('n', '<leader>gb', ':diffget BASE<CR>', { silent = true, desc = 'Diff - select base' })
  vim.keymap.set('n', '<leader>gr', ':diffget REMOTE<CR>', { silent = true, desc = 'Diff - select remote' })
  vim.keymap.set('n', '<leader>gu', ':diffupdate<CR>', { silent = true, desc = 'Diff - update' })
end
