local utils = require('utils_')

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
-- vim.keymap.set('v', '<leader>y', 'y:OSCYank<CR>', {noremap = true, silent = true})
utils.prepare_module('osc52', function(osc52)
  vim.keymap.set('n', '<leader>y', osc52.copy_operator, {expr = true})
  vim.keymap.set('n', '<leader>yy', '<leader>y_', {remap = true})
  vim.keymap.set('x', '<leader>y', osc52.copy_visual)
end)

-- Telescope
utils.prepare_module('telescope', function(telescope)
local telescope_builtin = require('telescope.builtin')
  vim.keymap.set('n', '<leader>lf', telescope_builtin.find_files, {noremap = true, silent = true})
  vim.keymap.set('n', '<leader>lb', telescope_builtin.buffers, {noremap = true, silent = true})
  vim.keymap.set('n', '<leader>ls', telescope.extensions.aerial.aerial, {noremap = true, silent = true})
  vim.keymap.set('n', '<leader>lr', telescope_builtin.oldfiles, {noremap = true, silent = true})
  vim.keymap.set('n', '<leader>lg', telescope_builtin.live_grep, {noremap = true, silent = true})
  vim.keymap.set('n', '<leader>lc', telescope_builtin.git_commits, {noremap = true, silent = true})
  vim.keymap.set('n', '<leader>le', telescope.extensions.emoji.emoji, {noremap = true, silent = true})
  vim.keymap.set('n', '<leader>lt', function() telescope_builtin.builtin({include_extensions = true}) end, {noremap = true, silent = true})
end)

-- LSP
vim.keymap.set('n', 'gD', vim.lsp.buf.declaration, {noremap = true, silent = true})
-- vim.keymap.set('n', 'gd', vim.lsp.buf.definition, {noremap = true, silent = true})
vim.keymap.set('n', 'gi', vim.lsp.buf.implementation, {noremap = true, silent = true})
vim.keymap.set('n', 'gr', vim.lsp.buf.references, {noremap = true, silent = true})
vim.keymap.set('n', 'gy', vim.lsp.buf.type_definition, {noremap = true, silent = true})
vim.keymap.set('n', '<leader>f', vim.lsp.buf.formatting, {noremap = true, silent = true})
vim.keymap.set('v', '<leader>f', vim.lsp.buf.range_formatting, {noremap = true, silent = true})
utils.prepare_module('lspsaga', function(lspsaga)
  vim.keymap.set("n", "K", require("lspsaga.hover").render_hover_doc, {noremap = true, silent = true })

  local action = require("lspsaga.action")
  vim.keymap.set("n", "<C-f>", function() action.smart_scroll_with_saga(1) end, {noremap=true, silent = true })
  vim.keymap.set("n", "<C-b>", function() action.smart_scroll_with_saga(-1) end, {noremap = true, silent = true })

  vim.keymap.set("n", "gs", require("lspsaga.signaturehelp").signature_help, {noremap = true, silent = true })
  vim.keymap.set("n", "gd", require("lspsaga.definition").preview_definition, {noremap = true, silent = true })

  vim.keymap.set('n', 'gh', function() require('lspsaga.finder'):lsp_finder() end, {noremap = true, silent = true})
  vim.keymap.set('n', '<leader>rn', require('lspsaga.rename').lsp_rename, {noremap = true, silent = true})

  local lspsaga_codeaction = require('lspsaga.codeaction')
  vim.keymap.set('n', '<leader>ca', lspsaga_codeaction.code_action, {noremap = true, silent = true})
  vim.keymap.set('v', '<leader>ca', function()
      vim.fn.feedkeys(vim.api.nvim_replace_termcodes("<C-U>", true, false, true))
      lspsaga_codeaction.range_code_action()
  end, {noremap = true, silent = true})

  local lspsaga_diag = require('lspsaga.diagnostic')
  vim.keymap.set('n', '<leader>lp', lspsaga_diag.goto_prev, {noremap = true, silent = true})
  vim.keymap.set('n', '<leader>ln', lspsaga_diag.goto_next, {noremap = true, silent = true})
  vim.keymap.set('n', '<leader>d', lspsaga_diag.show_line_diagnostics, {noremap = true, silent = true})
  -- vim.keymap.set('n', '<leader>d', vim.diagnostic.open_float, {noremap = true, silent = true})
end, function()  -- fallback
  vim.keymap.set("n", "K", vim.lsp.buf.hover, {noremap = true, silent = true })
  vim.keymap.set('n', '<leader>lp', vim.diagnostic.goto_prev, {noremap = true, silent = true})
  vim.keymap.set('n', '<leader>ln', vim.diagnostic.goto_next, {noremap = true, silent = true})
  vim.keymap.set('n', '<leader>d', vim.diagnostic.open_float, {noremap = true, silent = true})

  vim.keymap.set('n', '<leader>rn', vim.lsp.buf.rename, {noremap = true, silent = true})
  vim.keymap.set("n", "gs", vim.lsp.buf.signature_help, {noremap = true, silent = true })
  vim.keymap.set("n", "gd", vim.lsp.buf.definition, {noremap = true, silent = true })
  vim.keymap.set('n', '<leader>ca', vim.lsp.buf.code_action, {noremap = true, silent = true})
  vim.keymap.set('v', '<leader>ca', function()
      vim.fn.feedkeys(vim.api.nvim_replace_termcodes("<C-U>", true, false, true))
      vim.lsp.buf.range_code_action()
  end, {noremap = true, silent = true})
end)

-- DAP
utils.prepare_module('dap', function(dap)
  vim.keymap.set('n', '<leader>dd', dap.disconnect, {noremap = true, silent = true})
  vim.keymap.set('n', '<leader>dc', dap.continue, {noremap = true, silent = true})
  vim.keymap.set('n', '<leader>dn', dap.step_over, {noremap = true, silent = true})
  vim.keymap.set('n', '<leader>ds', dap.step_into, {noremap = true, silent = true})
  vim.keymap.set('n', '<leader>du', dap.step_out, {noremap = true, silent = true})
  vim.keymap.set('n', '<leader>db', dap.toggle_breakpoint, {noremap = true, silent = true})
  vim.keymap.set('n', '<leader>dB', function() dap.set_breakpoint(vim.fn.input("Breakpoint condition: ")) end, {noremap = true, silent = true})
  vim.keymap.set('n', '<leader>dl', function() dap.set_breakpoint(nil, nil, vim.fn.input("Log point message: ")) end, {noremap = true, silent = true})
  vim.keymap.set('n', '<leader>dr', dap.repl.open, {noremap = true, silent = true})

  utils.prepare_module('dapui', function(dapui)
    vim.keymap.set('n', '<leader>di', dapui.toggle, {noremap = true, silent = true})
    vim.keymap.set('n', '<leader>de', dapui.eval, {noremap = true, silent = true})
    vim.keymap.set('n', '<leader>dhs', function() dapui.float_element('scopes') end, {noremap = true, silent = true})
    vim.keymap.set('n', '<leader>dhf', function() dapui.float_element('stacks') end, {noremap = true, silent = true})
    vim.keymap.set('n', '<leader>dhw', function() dapui.float_element('watched') end, {noremap = true, silent = true})
    vim.keymap.set('n', '<leader>dht', function() dapui.float_element('threads') end, {noremap = true, silent = true})
  end)

  -- telescope-dap
  vim.keymap.set('n', '<leader>dcc', '<cmd>lua require"telescope".extensions.dap.commands{}<CR>', {noremap = true, silent = true})
  vim.keymap.set('n', '<leader>dco', '<cmd>lua require"telescope".extensions.dap.configurations{}<CR>', {noremap = true, silent = true})
  vim.keymap.set('n', '<leader>dv', '<cmd>lua require"telescope".extensions.dap.variables{}<CR>', {noremap = true, silent = true})
  vim.keymap.set('n', '<leader>df', '<cmd>lua require"telescope".extensions.dap.frames{}<CR>', {noremap = true, silent = true})
end)

-- Diff navigation
if vim.opt.diff:get() then
    vim.keymap.set('n', '<leader>n', ']c', {noremap = true, expr = true})
    vim.keymap.set('n', '<leader>p', '[c', {noremap = true, expr = true})
    vim.keymap.set('n', '<leader>gl', ':diffg LOCAL<CR>', {noremap = true, silent = true})
    vim.keymap.set('n', '<leader>gb', ':diffg BASE<CR>', {noremap = true, silent = true})
    vim.keymap.set('n', '<leader>gr', ':diffg REMOTE<CR>', {noremap = true, silent = true})
    vim.keymap.set('n', '<leader>du', ':diffupdate<CR>', {noremap = true, silent = true})
end
