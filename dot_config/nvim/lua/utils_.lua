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

function M.get_keys(tbl)
  local keys = {}
  for key, _ in pairs(tbl) do
    table.insert(keys, key)
  end
  return keys
end

function M.key_in_table(key, tbl)
  return tbl[key] ~= nil
end

function M.table_contains(tbl, val)
  for i, v in ipairs(tbl) do
    if v == val then
      return true
    end
  end
  return false
end

function M.noop(...)
  return nil
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

return M
