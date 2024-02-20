local lualine_theme = require('theme_').lualine_theme

return {
  'loctvl842/monokai-pro.nvim',
  lazy = false,
  enabled = false,
  priority = 1000,
  opts = {
    transparent_background = true,
    filter = 'spectrum',
    background_clear = {
      "telescope",
      "neo-tree",
    },
    override = function(colorscheme)
      return {
        StatusColumn = { link = 'LineNr' },
        CursorStatusColumn = { link = 'CursorLineNr' },
        ColorColumn = { link = 'CursorLine' },
        FloatBorder = { link = 'SPNormalFloat' },

        DiffText = { bg = colorscheme.diffEditorOverview.modifiedForeground, fg = colorscheme.diffEditor.modifiedLineBackground },

        LuaLineDiagnosticsError = { bg = lualine_theme.normal.c.bg, fg = colorscheme.inputValidation.errorForeground },
        LuaLineDiagnosticsWarn = { bg = lualine_theme.normal.c.bg, fg = colorscheme.inputValidation.warningForeground },
        LuaLineDiagnosticsInfo = { bg = lualine_theme.normal.c.bg, fg = colorscheme.inputValidation.infoForeground },
        LuaLineDiagnosticsHint = { bg = lualine_theme.normal.c.bg, fg = colorscheme.base.green },

        DiagnosticHint = { fg = colorscheme.base.green },
        DiagnosticSignHint = { fg = colorscheme.base.green },
        DiagnosticVirtualTextHint = { fg = colorscheme.base.green },
        DiagnosticUnderlineHint = { sp = colorscheme.base.green, undercurl = true },

        IblIndent = { link = 'IndentBlanklineChar' },
        IblWhitespace = { link = 'IndentBlanklineSpaceChar' },
        IblScope = { link = 'IndentBlanklineContextChar' },

        HighlightedyankRegion = { link = 'IncSearch' },
      }
    end,
  },
}

