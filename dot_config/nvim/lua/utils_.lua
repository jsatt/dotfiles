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

function M.noop(...)
  return nil
end

return M
