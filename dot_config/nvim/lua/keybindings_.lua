local utils = require('utils_')

vim.keymap.set('n', ';', ':')
vim.keymap.set('n', ':qt', ':tabc', {silent = true})
vim.keymap.set('n', '<leader>ld', ':Linediff<CR>', {silent = true})
vim.keymap.set('v', '<leader>ld', ":'<,'>Linediff<CR>", {silent = true})
vim.keymap.set('n', '<C-z>', ':UndotreeToggle<CR>', {silent = true})
vim.keymap.set('n', '<leader>a', '<cmd>AerialToggle!<CR>', {})
vim.keymap.set('n', '<leader>t', '<cmd>NvimTreeToggle<CR>', {})
vim.keymap.set('n', '<leader>hg', ':TSHighlightCapturesUnderCursor<CR>')
vim.keymap.set('n', '<leader>hc', ':Coverage<CR>')
vim.keymap.set('n', '<leader>hcc', ':CoverageClear<CR>')

vim.keymap.set('n', '<C-c>', '<C-a>', {}) -- remap increment to avoid clash with screen/tmux

-- remap home and ending keys
vim.keymap.set({'n', 'v'}, 'H', '^')
vim.keymap.set('n', 'L', '$')
vim.keymap.set('v', 'L', 'g_')

-- navigation on wrapped lines
vim.keymap.set('n', 'k', 'v:count == 0 ? "gk": "k"', {expr = true})
vim.keymap.set('n', 'j', 'v:count == 0 ? "gj": "j"', {expr = true})
vim.keymap.set('n', '<Up>', 'v:count == 0 ? "g<Up>": "<Up>"', {expr = true})
vim.keymap.set('n', '<Down>', 'v:count == 0 ? "g<Down>": "<Down>"', {expr = true})

-- navigation between tabs
vim.keymap.set('n', '<C-Right>', ':tabnext<CR>')
vim.keymap.set('n', '<C-Left>', ':tabprevious<CR>')
vim.keymap.set('i', '<C-Right>', '<Esc>:tabnext<CR>', {silent = true})
vim.keymap.set('i', '<C-Left>', '<Esc>:tabprevious<CR>', {silent = true})

-- navigation between splits
vim.keymap.set({'n', 'i'}, '<S-Left>', '<C-w>h')
vim.keymap.set({'n', 'i'}, '<S-Right>', '<C-w>l')
vim.keymap.set({'n', 'i'}, '<S-Up>', '<C-w>k')
vim.keymap.set({'n', 'i'}, '<S-Down>', '<C-w>j')

-- copy to terminal hosts clipboard
-- vim.keymap.set('v', '<leader>y', 'y:OSCYank<CR>', {silent = true})
utils.prepare_module('osc52', function(osc52)
  vim.keymap.set('n', '<leader>y', osc52.copy_operator, {expr = true})
  vim.keymap.set('n', '<leader>yy', '<leader>y_', {remap = true})
  vim.keymap.set('x', '<leader>y', osc52.copy_visual)
end)

-- Telescope
utils.prepare_module('telescope', function(telescope)
local telescope_builtin = require('telescope.builtin')
  vim.keymap.set('n', '<leader>lf', telescope_builtin.find_files, {silent = true})
  vim.keymap.set('n', '<leader>lb', telescope_builtin.buffers, {silent = true})
  vim.keymap.set('n', '<leader>ls', telescope.extensions.aerial.aerial, {silent = true})
  vim.keymap.set('n', '<leader>lr', telescope_builtin.oldfiles, {silent = true})
  vim.keymap.set('n', '<leader>lg', telescope_builtin.live_grep, {silent = true})
  vim.keymap.set('n', '<leader>lc', telescope_builtin.git_commits, {silent = true})
  vim.keymap.set('n', '<leader>le', telescope.extensions.emoji.emoji, {silent = true})
  vim.keymap.set('n', '<leader>lt', function() telescope_builtin.builtin({include_extensions = true}) end, {silent = true})
end)

-- LSP
vim.keymap.set('n', 'gD', vim.lsp.buf.declaration, {silent = true})
vim.keymap.set('n', 'gi', vim.lsp.buf.implementation, {silent = true})
vim.keymap.set('n', 'gr', vim.lsp.buf.references, {silent = true})
vim.keymap.set('n', 'gy', vim.lsp.buf.type_definition, {silent = true})
vim.keymap.set("n", "gs", vim.lsp.buf.signature_help, {silent = true })
vim.keymap.set('n', '<leader>f', vim.lsp.buf.formatting, {silent = true})
vim.keymap.set('v', '<leader>f', vim.lsp.buf.range_formatting, {silent = true})

utils.prepare_module('lspsaga', function(lspsaga)
  vim.keymap.set("n", "K", require("lspsaga.hover").render_hover_doc, {silent = true })
  vim.keymap.set("n", "gd", '<cmd>Lsapsaga preview_definition<CR>', {silent = true })
  vim.keymap.set('n', 'gh', '<cmd>Lspsaga lsp_finder<CR>', {silent = true})
  vim.keymap.set('n', '<leader>d', '<cmd>Lspsaga show_line_diagnostics<CR>', {silent = true})
  vim.keymap.set('n', '<leader>rn', '<cmd>Lspsaga rename<CR>', {silent = true})
  vim.keymap.set('n', '<leader>ca', '<cmd>Lspsaga code_action<CR>', {silent = true})
  vim.keymap.set('n', '<leader>ca', '<cmd>Lspsaga code_action<CR>', {silent = true})
  vim.keymap.set('v', '<leader>ca', '<cmd><C-U>Lspsaga range_code_action<CR>', {silent = true})
  vim.keymap.set('n', '<leader>lp', '<cmd>Lspsaga diagnostic_jump_prev<CR>', {silent = true})
  vim.keymap.set('n', '<leader>ln', "<cmd>Lspsaga diagnostic_jump_next<CR>", {silent = true})

  local action = require("lspsaga.action")
  vim.keymap.set("n", "<C-f>", function() action.smart_scroll_with_saga(1) end, {noremap=true, silent = true })
  vim.keymap.set("n", "<C-b>", function() action.smart_scroll_with_saga(-1) end, {silent = true })

end, function()  -- fallback
  vim.keymap.set("n", "K", vim.lsp.buf.hover, {silent = true })
  vim.keymap.set('n', '<leader>lp', vim.diagnostic.goto_prev, {silent = true})
  vim.keymap.set('n', '<leader>ln', vim.diagnostic.goto_next, {silent = true})
  vim.keymap.set('n', '<leader>d', vim.diagnostic.open_float, {silent = true})

  vim.keymap.set('n', '<leader>rn', vim.lsp.buf.rename, {silent = true})
  vim.keymap.set("n", "gd", vim.lsp.buf.definition, {silent = true })
  vim.keymap.set('n', '<leader>ca', vim.lsp.buf.code_action, {silent = true})
  vim.keymap.set('v', '<leader>ca', function()
      vim.fn.feedkeys(vim.api.nvim_replace_termcodes("<C-U>", true, false, true))
      vim.lsp.buf.range_code_action()
  end, {silent = true})
end)

-- DAP
utils.prepare_module('dap', function(dap)
  vim.keymap.set('n', '<leader>dd', dap.disconnect, {silent = true})
  vim.keymap.set('n', '<leader>dc', dap.continue, {silent = true})
  vim.keymap.set('n', '<leader>dn', dap.step_over, {silent = true})
  vim.keymap.set('n', '<leader>ds', dap.step_into, {silent = true})
  vim.keymap.set('n', '<leader>du', dap.step_out, {silent = true})
  vim.keymap.set('n', '<leader>db', dap.toggle_breakpoint, {silent = true})
  vim.keymap.set('n', '<leader>dB', function() dap.set_breakpoint(vim.fn.input("Breakpoint condition: ")) end, {silent = true})
  vim.keymap.set('n', '<leader>dl', function() dap.set_breakpoint(nil, nil, vim.fn.input("Log point message: ")) end, {silent = true})
  vim.keymap.set('n', '<leader>dr', dap.repl.open, {silent = true})

  utils.prepare_module('dapui', function(dapui)
    vim.keymap.set('n', '<leader>di', dapui.toggle, {silent = true})
    vim.keymap.set('n', '<leader>de', dapui.eval, {silent = true})
    vim.keymap.set('n', '<leader>dhs', function() dapui.float_element('scopes') end, {silent = true})
    vim.keymap.set('n', '<leader>dhf', function() dapui.float_element('stacks') end, {silent = true})
    vim.keymap.set('n', '<leader>dhw', function() dapui.float_element('watched') end, {silent = true})
    vim.keymap.set('n', '<leader>dht', function() dapui.float_element('threads') end, {silent = true})
  end)

  -- telescope-dap
  vim.keymap.set('n', '<leader>dcc', '<cmd>lua require"telescope".extensions.dap.commands{}<CR>', {silent = true})
  vim.keymap.set('n', '<leader>dco', '<cmd>lua require"telescope".extensions.dap.configurations{}<CR>', {silent = true})
  vim.keymap.set('n', '<leader>dv', '<cmd>lua require"telescope".extensions.dap.variables{}<CR>', {silent = true})
  vim.keymap.set('n', '<leader>df', '<cmd>lua require"telescope".extensions.dap.frames{}<CR>', {silent = true})
end)

-- Diff navigation
if vim.opt.diff:get() then
    vim.keymap.set('n', '<leader>n', ']c', {expr = true})
    vim.keymap.set('n', '<leader>p', '[c', {expr = true})
    vim.keymap.set('n', '<leader>gl', ':diffg LOCAL<CR>', {silent = true})
    vim.keymap.set('n', '<leader>gb', ':diffg BASE<CR>', {silent = true})
    vim.keymap.set('n', '<leader>gr', ':diffg REMOTE<CR>', {silent = true})
    vim.keymap.set('n', '<leader>du', ':diffupdate<CR>', {silent = true})
end
