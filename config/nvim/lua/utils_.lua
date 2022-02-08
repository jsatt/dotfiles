local M = {}

function M.prepare_module(module_name, prepare_func)
  local status_ok, module = pcall(require, module_name)
  if not status_ok then
    return
  end
  return prepare_func(module)
end

function M.join_tables(table1, table2)
  local new_table = {}
  for _, value in ipairs(table1) do
    table.insert(new_table, value)
  end
  for _, value in ipairs(table2) do
    table.insert(new_table, value)
  end
  return new_table
end

return M
