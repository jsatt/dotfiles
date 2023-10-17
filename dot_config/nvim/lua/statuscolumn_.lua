local theme = require('theme_')
local M = {}
_G.Status = M

---@return {name:string, text:string, texthl:string}[]
function M.get_signs()
  local buf = vim.api.nvim_win_get_buf(vim.g.statusline_winid)
  return vim.tbl_map(function(sign)
    return vim.fn.sign_getdefined(sign.name)[1]
  end, vim.fn.sign_getplaced(buf, { group = "*", lnum = vim.v.lnum })[1].signs)
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
  local sign, git_sign
  for _, s in ipairs(M.get_signs()) do
    if s.name:find("GitSign") then
      git_sign = s
    else
      sign = s
    end
  end
  local components = {
    -- git sign
    -- git_sign and ("%#" .. git_sign.texthl .. "#" .. string.gsub(git_sign.text, '%s+', '') .. "%*") or "%#LineNr#" .. theme.icons.vertical_border .. "%*",
    M.get_gitsign(git_sign),
    -- [[%C]], -- fold column, TODO add custom foldline builder, use gitsigns texthl to color
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
  virtual_text = {
    source = 'always',
  },
  float = {
    focusable = false,
    -- style = "minimal",
    border = theme.opts.border_style,
    source = 'always',
    -- header = "",
    -- prefix = "",
  },
}

return M
