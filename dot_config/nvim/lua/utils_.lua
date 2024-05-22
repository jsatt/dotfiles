local M = {}

function M.prepare_module(module_name, prepare_func, fallback_func)
  if fallback_func == nil then
    fallback_func = function() end
  end
  local status_ok, module = pcall(require, module_name)
  if not status_ok then
    return fallback_func()
  end
  return prepare_func(module)
end

function M.key_in_table(key, tbl)
  if tbl == nil then
    return false
  end
  return tbl[key] ~= nil
end

function M.open_in(target, callback)
  local cmd = ''
  if target == 'tab' then
    cmd = 'tab split'
  elseif target == 'split' then
    cmd = 'split'
  elseif target == 'vsplit' then
    cmd = 'vsplit'
  end

  vim.cmd(cmd)
  callback()
end

function M.range(start_pos, end_pos)
  local ret = {}
  for i = start_pos, end_pos do
    table.insert(ret, i)
  end
  return ret
end

function M.set_column_width_color(start_pos, end_pos)
  vim.opt.textwidth = end_pos
  vim.opt.colorcolumn = table.concat(M.range(start_pos, end_pos), ',')
end

return M
