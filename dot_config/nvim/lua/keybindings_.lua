local utils = require('utils_')

vim.keymap.set('n', ';', ':')
vim.keymap.set('n', ':qt', ':tabc', { silent = true, desc = 'Close Tab' })
vim.keymap.set('n', '<leader>ld', ':Linediff<CR>', { silent = true, desc = 'Linediff' })
vim.keymap.set('v', '<leader>ld', ":'<,'>Linediff<CR>", { silent = true, desc = 'Linediff' })
vim.keymap.set('n', '<leader>a', '<cmd>AerialToggle!<CR>', { desc = 'Toggle Aerial' })
vim.keymap.set('n', '<leader>t', '<cmd>Neotree toggle filesystem<CR>', { desc = 'Toggle File Tree' })
vim.keymap.set('n', '<leader>hg', ':Inspect<CR>', { silent = true, desc = 'Inspect' })
vim.keymap.set('n', '<leader>hc', ':Coverage<CR>', { silent = true, desc = 'Show test coverage' })
vim.keymap.set('n', '<leader>hcc', ':CoverageClear<CR>', { silent = true, desc = 'Clear test coverage' })
vim.keymap.set('n', '<leader>/', ':let @/ = ""<CR>', { silent = true, desc = 'Clear search' })
vim.keymap.set('n', '<leader>gb', ':BlameToggle<CR>', { silent = true, desc = 'Toggle Git Blame' })

vim.keymap.set('n', '<C-c>', '<C-a>') -- remap increment to avoid clash with screen/tmux
if utils.has_plugin('dial.nvim') then
  vim.keymap.set('n', '<C-c>', function() return require('dial.map').inc_normal() end, { expr = true, desc = 'Increment' }) -- remap increment to avoid clash with screen/tmux
  vim.keymap.set('n', '<C-x>', function() return require('dial.map').dec_normal() end, { expr = true, desc = 'Decrement' }) -- remap increment to avoid clash with screen/tmux
  vim.keymap.set('v', '<C-c>', function() return require('dial.map').inc_visual() end, { expr = true, desc = 'Increment' }) -- remap increment to avoid clash with screen/tmux
  vim.keymap.set('v', '<C-x>', function() return require('dial.map').dec_visual() end, { expr = true, desc = 'Decrement' }) -- remap increment to avoid clash with screen/tmux
  vim.keymap.set('v', 'g<C-c>', function() return require('dial.map').inc_gvisual() end, { expr = true, desc = 'Increment' }) -- remap increment to avoid clash with screen/tmux
  vim.keymap.set('v', 'g<C-x>', function() return require('dial.map').dec_gvisual() end, { expr = true, desc = 'Decrement' }) -- remap increment to avoid clash with screen/tmux
end

-- remap home and ending keys
vim.keymap.set({ 'n', 'v' }, 'H', '^', { desc = 'Goto start of line' })
vim.keymap.set('n', 'L', '$', { desc = 'Goto end of line' })
vim.keymap.set('v', 'L', 'g_', { desc = 'Goto end of line' })

-- navigation on wrapped lines
vim.keymap.set({'n', 'v'}, 'k', 'v:count == 0 ? "gk": "k"', { expr = true })
vim.keymap.set({'n', 'v'}, 'j', 'v:count == 0 ? "gj": "j"', { expr = true })
vim.keymap.set({'n', 'v'}, '<Up>', 'v:count == 0 ? "gk": "k"', { expr = true })
vim.keymap.set({'n', 'v'}, '<Down>', 'v:count == 0 ? "gj": "j"', { expr = true })
vim.keymap.set('i', '<Up>', 'v:count == 0 ? "<C-o>gk": "<C-o>k"', { expr = true })
vim.keymap.set('i', '<Down>', 'v:count == 0 ? "<C-o>gj": "<C-o>j"', { expr = true })

-- navigation between tabs
vim.keymap.set('n', '<C-Right>', ':tabnext<CR>', { silent = true, desc = 'Navigate tabs - right' })
vim.keymap.set('n', '<C-Left>', ':tabprevious<CR>', { silent = true, desc = 'Navigate tabs - left' })
vim.keymap.set('i', '<C-Right>', '<Esc>:tabnext<CR>', { silent = true, desc = 'Navigate tabs - right' })
vim.keymap.set('i', '<C-Left>', '<Esc>:tabprevious<CR>', { silent = true, desc = 'Navigate tabs - left' })
vim.keymap.set('n', '<A-Right>', ':tabm +1<CR>', { silent = true, desc = 'Move tab right' })
vim.keymap.set('n', '<A-Left>', ':tabm -1<CR>', { silent = true, desc = 'Move tab left' })
vim.keymap.set('i', '<A-Right>', '<Esc>:tabm +1<CR>', { silent = true, desc = 'Move tab right' })
vim.keymap.set('i', '<A-Left>', '<Esc>:tabm -1<CR>', { silent = true, desc = 'Move tab left' })

-- navigation between splits
vim.keymap.set({ 'n', 'i' }, '<S-Left>', '<C-w>h', { desc = 'Navigate splits - left' })
vim.keymap.set({ 'n', 'i' }, '<S-Right>', '<C-w>l', { desc = 'Navigate splits - right' })
vim.keymap.set({ 'n', 'i' }, '<S-Up>', '<C-w>k', { desc = 'Navigate splits - up' })
vim.keymap.set({ 'n', 'i' }, '<S-Down>', '<C-w>j', { desc = 'Navigate splits - down' })

-- copy to terminal hosts clipboard
vim.keymap.set({'n', 'v'}, '<leader>y', '"+y', { desc = 'Copy to system clipboard' })
vim.keymap.set('n', '<leader>yy', '"+yy', { desc = 'Copy line to system clipboard' })

-- Telescope
if utils.has_plugin('telescope.nvim') then
  local function builtin(picker, opts)
    return function() require('telescope.builtin')[picker](opts) end
  end
  local function ext(name, picker)
    return function() require('telescope').extensions[name][picker]() end
  end
  vim.keymap.set('n', '<C-z>', ext('undo', 'undo'), { silent = true, desc = 'Toggle Undotree' })
  vim.keymap.set('n', '<leader>lf', builtin('find_files'), { silent = true, desc = 'Find Files' })
  vim.keymap.set('n', '<leader>lb', builtin('buffers'), { silent = true, desc = 'Find Buffers' })
  vim.keymap.set('n', '<leader>lr', builtin('oldfiles'), { silent = true, desc = 'Find Recently Opened Files' })
  vim.keymap.set('n', '<leader>lg', builtin('live_grep'), { silent = true, desc = 'Live Grep' })
  vim.keymap.set('n', '<leader>lc', builtin('git_commits'), { silent = true, desc = 'Search Commits' })
  vim.keymap.set('n', '<leader>lfc', ext('git_file_history', 'git_file_history'), { silent = true, desc = 'Search File History' })
  vim.keymap.set('n', '<leader>le', ext('emoji', 'emoji'), { silent = true, desc = 'Find Emoji' })
  vim.keymap.set('n', '<leader>lt', builtin('builtin', { include_extensions = true }), { silent = true, desc = 'Fine Telescope Picker' })
  if utils.has_plugin('aerial.nvim') then
    vim.keymap.set('n', '<leader>ls', ext('aerial', 'aerial'), { silent = true, desc = 'Find Symbols' })
  end

  -- Git Worktrees
  if utils.has_plugin('git-worktree.nvim') then
    vim.keymap.set("n", "<leader>wt", ext('git_worktree', 'git_worktrees'), { desc = "Switch git worktree" })

    vim.keymap.set("n", "<leader>wn", ext('git_worktree', 'create_git_worktree'), { desc = "Create git worktree" })
  end
end

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
vim.keymap.set('n', '<leader>sd', vim.diagnostic.open_float, { silent = true, desc = 'Show Diagnostics' })

if utils.has_plugin('nvim-scissors') then
  vim.keymap.set('n', '<leader>se', function() require('scissors').editSnippet() end, { desc = 'Edit Snippet' })
  vim.keymap.set('n', '<leader>sa', function() require('scissors').addNewSnippet() end, { desc = 'Add New Snippet' })
  vim.keymap.set('v', '<leader>sa', ':ScissorsAddNewSnippet<CR>', { desc = 'Add New Snippet from selection' })
end

-- Treesitter
if utils.has_plugin('nvim-treesitter-textobjects') then
  -- Select
  vim.keymap.set({ "x", "o" }, "af", function() require("nvim-treesitter-textobjects.select").select_textobject("@function.outer", "textobjects") end)
  vim.keymap.set({ "x", "o" }, "if", function() require("nvim-treesitter-textobjects.select").select_textobject("@function.inner", "textobjects") end)
  vim.keymap.set({ "x", "o" }, "ac", function() require("nvim-treesitter-textobjects.select").select_textobject("@class.outer", "textobjects") end)         -- class
  vim.keymap.set({ "x", "o" }, "ic", function() require("nvim-treesitter-textobjects.select").select_textobject("@class.inner", "textobjects") end)
  vim.keymap.set({ "x", "o" }, "ax", function() require("nvim-treesitter-textobjects.select").select_textobject("@block.outer", "textobjects") end)         -- function or class
  vim.keymap.set({ "x", "o" }, "ix", function() require("nvim-treesitter-textobjects.select").select_textobject("@block.inner", "textobjects") end)
  vim.keymap.set({ "x", "o" }, "ai", function() require("nvim-treesitter-textobjects.select").select_textobject("@conditional.outer", "textobjects") end)   -- if statment
  vim.keymap.set({ "x", "o" }, "ii", function() require("nvim-treesitter-textobjects.select").select_textobject("@conditional.inner", "textobjects") end)
  vim.keymap.set({ "x", "o" }, "al", function() require("nvim-treesitter-textobjects.select").select_textobject("@loop.outer", "textobjects") end)          -- loop, but not comprehensions
  vim.keymap.set({ "x", "o" }, "il", function() require("nvim-treesitter-textobjects.select").select_textobject("@loop.inner", "textobjects") end)

  -- Swap
  vim.keymap.set('n', 'ma', function() require('nvim-treesitter-textobjects.swap').swap_next("@parameter.inner") end)   -- single call arg
  vim.keymap.set('n', 'mf', function() require('nvim-treesitter-textobjects.swap').swap_next("@function.outer") end)
  vim.keymap.set('n', 'mc', function() require('nvim-treesitter-textobjects.swap').swap_next("@class.outer") end)
  vim.keymap.set('n', 'Ma', function() require('nvim-treesitter-textobjects.swap').swap_previous("@parameter.inner") end)
  vim.keymap.set('n', 'Mf', function() require('nvim-treesitter-textobjects.swap').swap_previous("@function.outer") end)
  vim.keymap.set('n', 'Mc', function() require('nvim-treesitter-textobjects.swap').swap_previous("@class.outer") end)

  -- Move
  vim.keymap.set({ 'n', 'x', 'o' }, ']m', function() require('nvim-treesitter-textobjects.move').goto_next_start("@function.outer") end)
  vim.keymap.set({ 'n', 'x', 'o' }, ']]', function() require('nvim-treesitter-textobjects.move').goto_next_start("@class.outer") end)
  vim.keymap.set({ 'n', 'x', 'o' }, ']M', function() require('nvim-treesitter-textobjects.move').goto_next_end("@function.outer") end)
  vim.keymap.set({ 'n', 'x', 'o' }, '][', function() require('nvim-treesitter-textobjects.move').goto_next_end("@class.outer") end)
  vim.keymap.set({ 'n', 'x', 'o' }, '[m', function() require('nvim-treesitter-textobjects.move').goto_previous_start("@function.outer") end)
  vim.keymap.set({ 'n', 'x', 'o' }, '[[', function() require('nvim-treesitter-textobjects.move').goto_previous_start("@class.outer") end)
  vim.keymap.set({ 'n', 'x', 'o' }, '[M', function() require('nvim-treesitter-textobjects.move').goto_previous_end("@function.outer") end)
  vim.keymap.set({ 'n', 'x', 'o' }, '[]', function() require('nvim-treesitter-textobjects.move').goto_previous_end("@class.outer") end)

end

-- CodeCompanion
if utils.has_plugin('codecompanion.nvim') then
  vim.keymap.set({'n', 'v'}, '<leader>cc', ':CodeCompanionActions<CR>', { silent = true, desc = 'CodeCompanion actions' })
end

-- DAP
if utils.has_plugin('nvim-dap') then
  vim.keymap.set('n', '<leader>dd', function() require('dap').disconnect() end, { silent = true, desc = 'Disconnect DAP' })
  vim.keymap.set('n', '<leader>dc', function() require('dap').continue() end, { silent = true, desc = 'DAP - Continue' })
  vim.keymap.set('n', '<leader>dn', function() require('dap').step_over() end, { silent = true, desc = 'DAP - Step over' })
  vim.keymap.set('n', '<leader>ds', function() require('dap').step_into() end, { silent = true, desc = 'DAP - Step into' })
  vim.keymap.set('n', '<leader>du', function() require('dap').step_out() end, { silent = true, desc = 'DAP - Step out' })
  vim.keymap.set('n', '<leader>db', function() require('dap').toggle_breakpoint() end, { silent = true, desc = 'DAP - toggle_breakpoint' })
  vim.keymap.set('n', '<leader>dB', function() require('dap').set_breakpoint(vim.fn.input("Breakpoint condition: ")) end, { silent = true, desc = 'DAP - Set conditional breakpoint' })
  vim.keymap.set('n', '<leader>dl', function() require('dap').set_breakpoint(nil, nil, vim.fn.input("Log point message: ")) end, { silent = true, desc = 'DAP - Set log point' })
  vim.keymap.set('n', '<leader>dr', function() require('dap').repl.open() end, { silent = true, desc = 'DAP - Open REPL' })

  if utils.has_plugin('nvim-dap-ui') then
    vim.keymap.set('n', '<leader>di', function() require('dapui').toggle() end, { silent = true, desc = 'DAP - Open UI' })
    vim.keymap.set('n', '<leader>de', function() require('dapui').eval() end, { silent = true, desc = 'DAP - Evaluate' })
    vim.keymap.set('n', '<leader>dhs', function() require('dapui').float_element('scopes') end, { silent = true, desc = 'Show DAP scopes' })
    vim.keymap.set('n', '<leader>dhf', function() require('dapui').float_element('stacks') end, { silent = true, desc = 'Show DAP stacks' })
    vim.keymap.set('n', '<leader>dhw', function() require('dapui').float_element('watched') end, { silent = true, desc = 'Show DAP watches' })
    vim.keymap.set('n', '<leader>dht', function() require('dapui').float_element('threads') end, { silent = true, desc = 'Show DAP threads' })
  end

  -- telescope-dap
  vim.keymap.set('n', '<leader>dcc', '<cmd>lua require"telescope".extensions.dap.commands{}<CR>', { silent = true, desc = 'Find DAP commands' })
  vim.keymap.set('n', '<leader>dco', '<cmd>lua require"telescope".extensions.dap.configurations{}<CR>', { silent = true, desc = 'Find DAP configurations' })
  vim.keymap.set('n', '<leader>dv', '<cmd>lua require"telescope".extensions.dap.variables{}<CR>', { silent = true, desc = 'Find DAP variables' })
  vim.keymap.set('n', '<leader>df', '<cmd>lua require"telescope".extensions.dap.frames{}<CR>', { silent = true, desc = 'Find DAP frames' })
end

-- Diff navigation
if vim.opt.diff:get() then
  vim.keymap.set('n', '<leader>n', ']c', { desc = 'Goto next diff conflict' })
  vim.keymap.set('n', '<leader>p', '[c', { desc = 'Goto previous diff conflict' })
  vim.keymap.set('n', '<leader>gl', ':diffget LOCAL<CR>', { silent = true, desc = 'Diff - select local' })
  vim.keymap.set('n', '<leader>gb', ':diffget BASE<CR>', { silent = true, desc = 'Diff - select base' })
  vim.keymap.set('n', '<leader>gr', ':diffget REMOTE<CR>', { silent = true, desc = 'Diff - select remote' })
  vim.keymap.set('n', '<leader>gu', ':diffupdate<CR>', { silent = true, desc = 'Diff - update' })
end
