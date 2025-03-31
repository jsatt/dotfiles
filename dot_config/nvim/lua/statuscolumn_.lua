local theme = require('theme_')
local M = {}
_G.Status = M

local exclude_filetypes = {
  'aerial',
  'neo-tree',
}

---@return {name:string, text:string, texthl:string}[]
function M.get_signs()
  local buf = vim.api.nvim_win_get_buf(vim.g.statusline_winid)
  return vim.iter(vim.fn.sign_getplaced(buf, { group = "*", lnum = vim.v.lnum })[1].signs):map(function(sign)
    return vim.fn.sign_getdefined(sign.name)[1]
  end):totable()
end

function M.get_lnum()
  local v
  if vim.v.virtnum > 0 then
    v = theme.icons.wrap .. " "
  elseif vim.v.virtnum < 0 then
    v = theme.icons.virtual_line .. " "
  else
    v = [[%{&nu?(&rnu&&v:relnum?v:relnum:v:lnum):''} ]]
  end
  return v
end

function M.get_gitsign(git_sign)
  local s
  if git_sign then
    s = "%#" .. git_sign.texthl .. "#" .. string.gsub(git_sign.text, '%s+', '') .. "%*"
  else
    local hi = vim.v.lnum == vim.api.nvim_win_get_cursor(0)[1] and "CursorStatusColumn" or "StatusColumn"
    s = "%#" .. hi .. "#" .. theme.icons.vertical_border .. "%*"
  end
  return s
end

function M.column()
  local buf = vim.api.nvim_win_get_buf(vim.g.statusline_winid)
  local ft = vim.api.nvim_get_option_value('filetype', {buf = buf})
  if vim.list_contains(exclude_filetypes, ft) then
    return ''
  end

  local sign, git_sign
  for _, s in ipairs(M.get_signs()) do
    if s.name:find("GitSign") then
      git_sign = s
    else
      sign = s
    end
  end
  local components = {
    M.get_gitsign(git_sign),
    -- diagnostics, uses 2 columns
    sign and ("%#" .. sign.texthl .. "#" .. sign.text .. "%*") or " ",
    [[%=]], -- right align numbers
    M.get_lnum(), -- line numbers
  }
  return table.concat(components, "")
end

vim.opt.statuscolumn = [[%!v:lua.Status.column()]]

-- Diagnostics

local diagnostic_signs = {}
for name, sign in pairs(theme.signs.diagnostics) do
  vim.fn.sign_define(sign.statuscolumn_hl, { texthl = sign.statuscolumn_hl, text = sign.statuscolumn_text, numhl = sign.statuscolumn_numhl })
  diagnostic_signs[name] = { name = sign.statuscolumn_hl, text = sign.statuscolumn_text }
end

vim.diagnostic.config {
  signs = {
    active = diagnostic_signs,
  },
  update_in_insert = false,
  underline = true,
  severity_sort = true,
  virtual_text = true,
  virtual_lines = {
    current_line = true,
  },
  float = {
    focusable = false,
    -- style = "minimal",
    source = true,
    -- header = "",
    -- prefix = "",
  },
}

return M
