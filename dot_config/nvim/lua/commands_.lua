local utils = require('utils_')

vim.api.nvim_create_autocmd('TextYankPost', {
    group = vim.api.nvim_create_augroup('highlight_yank', {clear = true}),
    callback = function()
       vim.highlight.on_yank { higroup='HighlightedyankRegion', timeout=500 }
    end
})
vim.api.nvim_create_autocmd('BufWritePre', {
    group = vim.api.nvim_create_augroup('clear_trailing_whitespace', {clear = true}),
    command = [[%s/\s\+$//e]]
})
vim.api.nvim_create_autocmd('BufEnter', {  -- check for changes more often for autoread
    group = vim.api.nvim_create_augroup('check_for_changes', {clear = true}),
    command = 'checkt'
})
vim.api.nvim_create_autocmd('FileType', { -- don't automatically wrap long lines in INSERT
    group = vim.api.nvim_create_augroup('no_wrap_in_insert', {clear = true}),
    command = 'setlocal formatoptions-=t formatoptions+=l'
        -- vim.bo.formatoptions:remove('t')
        -- vim.bo.formatoptions:append('l')
})

vim.api.nvim_create_autocmd('BufWritePost', { -- auto-apply files managed by chezmoi
  group = vim.api.nvim_create_augroup('chezmoi', {clear = true}),
  pattern = vim.fn.expand('~') .. '/.local/share/chezmoi/*',
  command = '!chezmoi apply --source-path "%"',
})

vim.api.nvim_create_autocmd('FileType', { -- add completion in DAP Repl
  group = vim.api.nvim_create_augroup('dap', {clear = true}),
  pattern = 'dap-repl',
  callback = function ()
    require('dap.ext.autocompl').attach()
  end,
})

local function delete_inactive_bufs()
  local tablist = {}
  for i = 1, vim.fn.tabpagenr('$') do
    for _, t in ipairs(vim.fn.tabpagebuflist(i)) do
      table.insert(tablist, t)
    end
  end

  local closed_tabs = 0
  for _, i in ipairs(vim.api.nvim_list_bufs()) do
    local buf_modified = vim.fn.getbufvar(i, '&mod') == 1
    local buf_in_tab = utils.table_contains(tablist, i)
    if not buf_modified and not buf_in_tab then
      vim.fn.execute('bwipeout ' .. i)
      closed_tabs = closed_tabs + 1
    end
  end
  print(closed_tabs .. ' buffers closed')
end

vim.api.nvim_create_user_command('Bdi', delete_inactive_bufs, {})
vim.api.nvim_create_user_command('CloseBuffers', delete_inactive_bufs, {})
vim.api.nvim_create_user_command('CloseOthers', ':%bd|e#', {})
