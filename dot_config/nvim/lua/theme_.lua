local M = {}

M.colors = {
    black = {gui = '#000000', term = 16},
    near_black = {gui = '#141413', term = 232},
    darker_grey = {gui = '#242321', term = 235},
    dark_grey = {gui = '#45413b', term = 238},
    grey = {gui = '#5f5f5f', term = 59},
    light_yellow = {gui = '#f4cf86', term = 222},
    dim_yellow = {gui = '#756532', term = 3},
    blue = {gui = '#005fff', term = 21},
    light_blue = {gui = '#0a9dff', term = 39},
    dim_blue = {gui = '#345f69', term = 6},
    red = {gui = '#ff0000', term = 9},
    dark_red = {gui = '#5f0000', term = 52},
    dim_red = {gui = '#802d3d', term = 1},
    pink = {gui = '#ff9eb8', term = 211},
    yellow = {gui = '#fade3e', term = 221},
    dark_yellow = {gui = '#5f5f00', 58},
    green = {gui = '#aeee00', term = 154},
    dark_green = {gui = '#005f00', term = 22},
    dim_green = {gui = '#496134', term = 2},
    orange = {gui = '#ffa724', term = 214},
    seafoam = {gui = '#8cffba', term = 121},
    pale_orange = {gui = '#b88853', term = 137},
}

M.lualine_theme = {
  normal = {
    a = { fg = M.colors.near_black.gui , bg = M.colors.green.gui, gui = 'bold' },
    b = { fg = M.colors.light_yellow.gui, bg = M.colors.dark_grey.gui },
    c = { fg = M.colors.seafoam.gui, bg = M.colors.darker_grey.gui },
  },
  insert = {
    a = { fg = M.colors.near_black.gui , bg = M.colors.light_blue.gui, gui = 'bold' },
    b = { fg = M.colors.light_yellow.gui, bg = M.colors.blue.gui },
    c = { fg = M.colors.light_blue.gui, bg = M.colors.darker_grey.gui },
  },
  visual = {
    a = { fg = M.colors.near_black.gui , bg = M.colors.orange.gui, gui = 'bold' },
    b = { fg = M.colors.black.gui, bg = M.colors.yellow.gui },
    c = { fg = M.colors.black.gui, bg = M.colors.pale_orange.gui },
  },
  replace = {
    a = { fg = M.colors.near_black.gui , bg = M.colors.pink.gui, gui = 'bold' },
    b = { fg = M.colors.light_yellow.gui, bg = M.colors.blue.gui },
    c = { fg = M.colors.light_blue.gui, bg = M.colors.darker_grey.gui },
  },
  inactive = {
    a = { fg = M.colors.darker_grey.gui, bg = M.colors.dark_grey.gui, gui = 'bold' },
    b = { fg = M.colors.darker_grey.gui, bg = M.colors.dark_grey.gui , gui = 'bold'},
    c = { fg = M.colors.darker_grey.gui, bg = M.colors.dark_grey.gui, gui = 'bold' },
  },
}

M.signs = {
  error = { name = "DiagnosticSignError", text = "✗", ll_name = 'LuaLineDiagnosticsError'},
  warn = { name = "DiagnosticSignWarn", text = "", ll_name = 'LuaLineDiagnosticsWarn' },
  info = { name = "DiagnosticSignInfo", text = "", ll_name = 'LuaLineDiagnosticsInfo' },
  hint = { name = "DiagnosticSignHint", text = "", ll_name = 'LuaLineDiagnosticsHint' },
}

M.gitsigns = {
  add = {text = '', hl = 'GitSignsAdd', numhl = 'GitSignsAddNr', linehl = 'GitSignsAddLn'},
  change = {text = '', hl = 'GitSignsChange', numhl = 'GitSignsChangeNr', linehl = 'GitSignsChangeLn'},
  changedelete = {text = '', hl = 'GitSignsChange', numhl = 'GitSignsChangeNr', linehl = 'GitSignsChangeLn'},
  delete = {text = '', hl = 'GitSignsDelete', numhl = 'GitSignsDeleteNr', linehl = 'GitSignsDeleteLn'},
  topdelete = {text = '', hl = 'GitSignsDelete', numhl = 'GitSignsDeleteNr', linehl = 'GitSignsDeleteLn'},
}

M.dap_signs = {
  breakpoint = {name = 'DapBreakpoint', text = '•', hl = 'DiagnosticError', numhl = '', linehl = ''},
  cond_breakpoint = {name = 'DapBreakpointCondition', text = '•', hl = 'DiagnosticWarn', numhl = '', linehl = ''},
  log_point = {name = 'DapLogPoint', text = '❏', hl = 'DiagnosticHint', numhl = '', linehl = ''},
  stopped = {name = 'DapStopped', text = '', hl = 'DiagnosticError', numhl = '', linehl = 'debugPC'},
  rejected = {name = 'DapBreakpoint', text = '🅧', hl = 'DiagnosticError', numhl = '', linehl = ''},
}

M.kind_icons = {
  Text = "",
  Method = "m",
  Function = "",
  Constructor = "",
  Field = "",
  Variable = "",
  Class = "",
  Interface = "",
  Module = "",
  Property = "",
  Unit = "",
  Value = "",
  Enum = "",
  Keyword = "",
  Snippet = "",
  Color = "",
  File = "",
  Reference = "",
  Folder = "",
  EnumMember = "",
  Constant = "",
  Struct = "",
  Event = "",
  Operator = "",
  TypeParameter = "",
}

return M
