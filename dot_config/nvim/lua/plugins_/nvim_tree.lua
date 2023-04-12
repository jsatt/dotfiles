local theme = require('theme_')
return {
  'nvim-tree/nvim-tree.lua',
  dependencies = {
    {
      'nvim-tree/nvim-web-devicons',
      lazy = true,
    },
  },
  opts = {
    diagnostics = {
      enable = true,
      icons = {
        hint = theme.icons.hint,
        info = theme.icons.info,
        warning = theme.icons.warn,
        error = theme.icons.error,
      },
    },
    actions = {
      change_dir = {
        enable = false,
      },
    },
  }
}
