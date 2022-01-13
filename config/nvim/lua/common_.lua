local M = {}

M.signs = {
  error = { name = "DiagnosticSignError", text = "✗" },
  warn = { name = "DiagnosticSignWarn", text = "" },
  info = { name = "DiagnosticSignInfo", text = "" },
  hint = { name = "DiagnosticSignHint", text = "" },
}

M.gitsigns = {
  add = {text = '', hl = 'GitSignsAdd', numhl = 'GitSignsAddNr', linehl = 'GitSignsAddLn'},
  change = {text = '', hl = 'GitSignsChange', numhl = 'GitSignsChangeNr', linehl = 'GitSignsChangeLn'},
  changedelete = {text = '', hl = 'GitSignsChange', numhl = 'GitSignsChangeNr', linehl = 'GitSignsChangeLn'},
  delete = {text = '', hl = 'GitSignsDelete', numhl = 'GitSignsDeleteNr', linehl = 'GitSignsDeleteLn'},
  topdelete = {text = '', hl = 'GitSignsDelete', numhl = 'GitSignsDeleteNr', linehl = 'GitSignsDeleteLn'},
}

function M.prepare_module(module_name, prepare_func)
  local status_ok, module = pcall(require, module_name)
  if not status_ok then
    return
  end
  return prepare_func(module)
end

return M
