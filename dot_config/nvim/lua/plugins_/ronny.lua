local theme = require('theme_')

return {
'judaew/ronny.nvim',
  lazy = false,
  priority = 1000,
  config = function()

    local ronny = require('ronny')
    local colors = require('ronny.colors')
    local utils = require('ronny.utils')
    colors.builtin.Normal.bg = 'NONE'
    colors.diagnostic.DiagnosticInfo.fg = colors.palette.blue
    colors.diagnostic.DiagnosticHint.fg = colors.palette.green
    colors.builtin.DiffAdd = { bg=theme.colors.dark_green.gui, bold=true }
    colors.builtin.DiffChange = { bg=theme.colors.dark_yellow.gui, bold=true }
    colors.builtin.DiffDelete = { bg=theme.colors.dark_red.gui, bold=true }
    colors.builtin.DiffText = { fg = colors.builtin.DiffChange.bg, bg = colors.builtin.DiffChange.fg, bold=true }

    utils.apply_syntax({
      FloatBorder = { link = 'SPNormalFloat' },

      DiagnosticSignError = {fg = colors.diagnostic.DiagnosticError.fg, bg = colors.builtin.SignColumn.bg},
      DiagnosticSignWarn = {fg = colors.diagnostic.DiagnosticWarn.fg, bg = colors.builtin.SignColumn.bg},
      DiagnosticSignInfo = {fg = colors.diagnostic.DiagnosticInfo.fg, bg = colors.builtin.SignColumn.bg},
      DiagnosticSignHint = {fg = colors.diagnostic.DiagnosticHint.fg, bg = colors.builtin.SignColumn.bg},

      LuaLineDiagnosticsError = { bg = theme.lualine_theme.normal.c.bg, fg = colors.diagnostic.DiagnosticError.fg },
      LuaLineDiagnosticsWarn = { bg = theme.lualine_theme.normal.c.bg, fg = colors.diagnostic.DiagnosticWarn.fg },
      LuaLineDiagnosticsInfo = { bg = theme.lualine_theme.normal.c.bg, fg = colors.diagnostic.DiagnosticInfo.fg },
      LuaLineDiagnosticsHint = { bg = theme.lualine_theme.normal.c.bg, fg = colors.diagnostic.DiagnosticHint.fg },

      IblIndent = { link = 'IndentBlanklineChar' },
      IblWhitespace = { link = 'IndentBlanklineSpaceChar' },
      IblScope = { link = 'IndentBlanklineContextChar' },

      HighlightedyankRegion = { link = 'IncSearch' },
    })
    ronny.setup({
      colors = colors,
      display = {
        monokai_original = false
      },
    })
  end
}
