local lualine_theme = require('theme_').lualine_theme

return {
  'loctvl842/monokai-pro.nvim',
  config = function()
    require('monokai-pro').setup({
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

          LuaLineDiagnosticsError = { bg = lualine_theme.normal.c.bg, fg = colorscheme.inputValidation.errorForeground },
          LuaLineDiagnosticsWarn = { bg = lualine_theme.normal.c.bg, fg = colorscheme.inputValidation.warningForeground },
          LuaLineDiagnosticsInfo = { bg = lualine_theme.normal.c.bg, fg = colorscheme.inputValidation.infoForeground },
          LuaLineDiagnosticsHint = { bg = lualine_theme.normal.c.bg, fg = colorscheme.base.green },

          DiagnosticHint = { fg = colorscheme.base.green },
          DiagnosticSignHint = { fg = colorscheme.base.green },
          DiagnosticVirtualTextHint = { fg = colorscheme.base.green },
          DiagnosticUnderlineHint = { sp = colorscheme.base.green, undercurl = true },

          HighlightedyankRegion = { link = 'IncSearch' },

          CoverageCovered = { link = 'GreenSign' },
          CoverageUncovered = { link = 'RedSign' },
        }
      end
    })
    vim.cmd [[colorscheme monokai-pro]]
  end,
}
