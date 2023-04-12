local M = {}

M.opts = {
  border_style = 'rounded',
}

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

M.icons = {
  collapsed = "",
  expanded = "",
  wrap = "↵",
  virtual_line = " ",
  vertical_border = "│",
  vertical_border_dashed = "┆",
  error =  "✗",
  warn = "",
  info = "",
  hint = "",
  add = '',
  change = '',
  delete = '',
  scrollbar = '┃',
}

M.signs = {
  diagnostics = {
    error = {
      statuscolumn_text = M.icons.error,
      statuscolumn_hl = "DiagnosticSignError",
      statuscolumn_numhl = "DiagnosticSignError",
      statusline_text = M.icons.warn,
      statusline_hl = 'LuaLineDiagnosticsError',
    },
    warn = {
      statuscolumn_text = M.icons.warn,
      statuscolumn_hl = "DiagnosticSignWarn",
      statuscolumn_numhl = "DiagnosticSignWarn",
      statusline_text = M.icons.warn,
      statusline_hl = 'LuaLineDiagnosticsWarn',
    },
    info = {
      statuscolumn_text = M.icons.info,
      statuscolumn_hl = "DiagnosticSignInfo",
      statuscolumn_numhl = "DiagnosticSignInfo",
      statusline_text = M.icons.info,
      statusline_hl = 'LuaLineDiagnosticsInfo',
    },
    hint = {
      statuscolumn_text = M.icons.hint,
      statuscolumn_hl = "DiagnosticSignHint",
      statuscolumn_numhl = "DiagnosticSignHint",
      statusline_text = M.icons.hint,
      statusline_hl = 'LuaLineDiagnosticsHint',
    },
  },
  vcs = {
    add = {
      statuscolumn_text = M.icons.vertical_border,
      statusline_text = M.icons.add,
      statusline_hl = 'GitSignsAdd',
      statuscolumn_hl = 'GitSignsAdd',
      statuscolumn_numhl = 'GitSignsAddNr',
      statuscolumn_linehl = 'GitSignsAddLn'
    },
    change = {
      statuscolumn_text = M.icons.vertical_border,
      statusline_text = M.icons.change,
      statusline_hl = 'GitSignsChange',
      statuscolumn_hl = 'GitSignsChange',
      statuscolumn_numhl = 'GitSignsChangeNr',
      statuscolumn_linehl = 'GitSignsChangeLn'
    },
    changedelete = {
      statuscolumn_text = M.icons.vertical_border,
      statuscolumn_hl = 'GitSignsChangedelete',
      statuscolumn_numhl = 'GitSignsChangedeleteNr',
      statuscolumn_linehl = 'GitSignsChangedeleteLn'
    },
    delete = {
      statuscolumn_text = M.icons.vertical_border,
      statusline_text = M.icons.delete,
      statusline_hl = 'GitSignsDelete',
      statuscolumn_hl = 'GitSignsDelete',
      statuscolumn_numhl = 'GitSignsDeleteNr',
      statuscolumn_linehl = 'GitSignsDeleteLn'
    },
    topdelete = {
      statuscolumn_text = M.icons.vertical_border,
      statuscolumn_hl = 'GitSignsDelete',
      statuscolumn_numhl = 'GitSignsDeleteNr',
      statuscolumn_linehl = 'GitSignsDeleteLn'
    },
    untracked = {
      statuscolumn_text = M.icons.vertical_border_dashed
    },
  },
  dap = {
    breakpoint = {
      name = 'DapBreakpoint',
      text = '•',
      hl = 'DiagnosticError',
      numhl = '',
      linehl = ''
    },
    cond_breakpoint = {
      name = 'DapBreakpointCondition',
      text = '•',
      hl = 'DiagnosticWarn',
      numhl = '',
      linehl = ''
    },
    log_point = {
      name = 'DapLogPoint',
      text = '❏',
      hl = 'DiagnosticHint',
      numhl = '',
      linehl = ''
    },
    stopped = {
      name = 'DapStopped',
      text = '',
      hl = 'DiagnosticError',
      numhl = '',
      linehl = 'debugPC'
    },
    rejected = {
      name = 'DapBreakpoint',
      text = '🅧',
      hl = 'DiagnosticError',
      numhl = '',
      linehl = ''
    },
  },
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
