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

function M.table_contains(value, tbl)
  for _, v in pairs(tbl) do
    if v == value then
      return true
    end
  end
  return false
end

function M.filter(tbl, filter_func)
  local ret = {}
  for _, item in ipairs(tbl) do
    if filter_func(item) then
      table.insert(ret, item)
    end
  end
  return ret
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

function M.dec2hex(n)
    return string.format("#%06x", n)
end

function M.get_hl(name)
  local hl = vim.api.nvim_get_hl(0, {name = name})
  for k, v in pairs(hl) do
    if M.table_contains(k, {'fg', 'bg'}) then
      hl[k] = M.dec2hex(v)
    end
  end
  return hl
end

return M
