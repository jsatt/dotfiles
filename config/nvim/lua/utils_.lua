local M = {}

function M.prepare_module(module_name, prepare_func)
  local status_ok, module = pcall(require, module_name)
  if not status_ok then
    return
  end
  return prepare_func(module)
end

function M.noop(...)
  return nil
end

return M
