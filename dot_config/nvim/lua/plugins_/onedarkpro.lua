local theme = require('theme_')
local utils = require('utils_')

return {
  'olimorris/onedarkpro.nvim',
  priority = 1000, -- Ensure it loads first
  config = function(plugin, opts)
    opts['colors'] = {
      dark_green = theme.colors.dark_green.gui,
      dark_yellow = theme.colors.dark_yellow.gui,
      dark_red = theme.colors.dark_red.gui,
    }
    require('onedarkpro').setup(opts)
  end,
  opts = {
    options = {
      transparency = true,
      cursorline = true,
    },
    highlights = {
      ['@variable'] = { fg = '${fg}' },
      DiffAdd = { bg = '${dark_green}', bold = true },
      DiffChange = { bg = '${dark_yellow}', bold = true },
      DiffText = { fg = '${black}', bg = '${yellow}', bold = true },
      DiffDelete = { bg = '${dark_red}', bold = true },
      GitSignsChange = { fg = '${orange}', bold = true },
      GitSignsChangeLn = { fg = '${orange}', bold = true },
      GitSignsChangeNr = { fg = '${orange}', bold = true },

      -- DiagnosticError = { fg = '${diagnostic_error}' },
      -- DiagnosticWarn = { fg = '${diagnostic_warn}' },
      -- DiagnosticInfo = { fg = '${diagnostic_info}' },
      -- DiagnosticHint = { fg = '${diagnostic_hint}' },
      --
      -- DiagnosticSignError = { fg = '${diagnostic_error}', bg = utils.get_hl('SignColumn').bg },
      -- DiagnosticSignWarn = { fg = '${diagnostic_warn}', bg = utils.get_hl('SignColumn').bg },
      -- DiagnosticSignInfo = { fg = '${diagnostic_info}', bg = utils.get_hl('SignColumn').bg },
      -- DiagnosticSignHint = { fg = '${diagnostic_hint}', bg = utils.get_hl('SignColumn').bg },

      LuaLineDiagnosticsError = { bg = theme.lualine_theme.normal.c.bg, fg = '${red}' },
      LuaLineDiagnosticsWarn = { bg = theme.lualine_theme.normal.c.bg, fg = '${yellow}' },
      LuaLineDiagnosticsInfo = { bg = theme.lualine_theme.normal.c.bg, fg = '${blue}' },
      LuaLineDiagnosticsHint = { bg = theme.lualine_theme.normal.c.bg, fg = '${green}' },

      LuaLineDiffAdd = { bg = theme.lualine_theme.normal.c.bg, fg = '${green}' },
      LuaLineDiffChange = { bg = theme.lualine_theme.normal.c.bg, fg = '${yellow}' },
      LuaLineDiffDelete = { bg = theme.lualine_theme.normal.c.bg, fg = '${red}' },

      TelescopeTitle = { fg = '${red}' },
      TelescopeBorder = { fg = '${cyan}' },

      HighlightedyankRegion = { fg = '${yellow}', reverse = true },

      -- IblIndent = { link = 'IndentBlanklineChar' },
      -- IblWhitespace = { link = 'IndentBlanklineSpaceChar' },
      -- IblScope = { link = 'IndentBlanklineContextChar' },

      NeoTreeDirectoryIcon = { fg = '${blue}' },
      RenderMarkdownStrike = { strikethrough = true },
    },
  },
}
