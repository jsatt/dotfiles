local theme = require('theme_')
local utils = require('utils_')

local overrides = {
  DiagnosticError = { fg = '$red' },
  DiagnosticWarn = { fg = '$orange' },
  DiagnosticInfo = { fg = '$blue' },
  DiagnosticHint = { fg = '$green' },
}


return {
  'navarasu/onedark.nvim',
  -- enabled = false,
  priority = 1000, -- Ensure it loads first
  lazy = false,
  opts = {
    style = 'darker',
    transparent = true,

    code_style = {
      keywords = 'bold,italic',
      variable = 'italic',
    },

    diagnostics = {
      background = false,
    },

    highlights = {
      DiffAdd = { bg = theme.colors.dark_green.gui, bold = true },
      DiffChange = { bg = theme.colors.dark_yellow.gui, bold = true },
      DiffText = { fg = '$black', bg = theme.colors.yellow.gui, bold = true },
      DiffDelete = { bg = theme.colors.dark_red.gui, bold = true },
      GitSignsChange = { fg = theme.colors.orange.gui, bold = true },
      GitSignsChangeLn = { fg = theme.colors.orange.gui, bold = true },
      GitSignsChangeNr = { fg = theme.colors.orange.gui, bold = true },

      DiagnosticError = overrides.DiagnosticError,
      DiagnosticWarn = overrides.DiagnosticWarn,
      DiagnosticInfo = overrides.DiagnosticInfo,
      DiagnosticHint = overrides.DiagnosticHint,

      DiagnosticSignError = { fg = overrides.DiagnosticError.fg, bg = utils.get_hl('SignColumn').bg },
      DiagnosticSignWarn = { fg = overrides.DiagnosticWarn.fg, bg = utils.get_hl('SignColumn').bg },
      DiagnosticSignInfo = { fg = overrides.DiagnosticInfo.fg, bg = utils.get_hl('SignColumn').bg },
      DiagnosticSignHint = { fg = overrides.DiagnosticHint.fg, bg = utils.get_hl('SignColumn').bg },

      LuaLineDiagnosticsError = { bg = theme.lualine_theme.normal.c.bg, fg = overrides.DiagnosticError.fg },
      LuaLineDiagnosticsWarn = { bg = theme.lualine_theme.normal.c.bg, fg = overrides.DiagnosticWarn.fg },
      LuaLineDiagnosticsInfo = { bg = theme.lualine_theme.normal.c.bg, fg = overrides.DiagnosticInfo.fg },
      LuaLineDiagnosticsHint = { bg = theme.lualine_theme.normal.c.bg, fg = overrides.DiagnosticHint.fg },

      TelescopeNormal = { bg = utils.get_hl('TelescopeBorder').bg, fg = utils.get_hl('Normal').fg },
    }
  },
  config = function(_, opts)
    local onedark = require('onedark')
    onedark.setup(opts)
    -- onedark.load()
    vim.api.nvim_create_autocmd('ColorScheme', {
      callback = function()
        vim.api.nvim_set_hl(0, 'HighlightedyankRegion', { link = 'IncSearch' })

        vim.api.nvim_set_hl(0, 'IblIndent', { link = 'IndentBlanklineChar' })
        vim.api.nvim_set_hl(0, 'IblWhitespace', { link = 'IndentBlanklineSpaceChar' })
        vim.api.nvim_set_hl(0, 'IblScope', { link = 'IndentBlanklineContextChar' })
      end,
    })
  end
}
