local theme = require('theme_')
return {
  'stevearc/aerial.nvim',
  opts = {
    layout = {
      default_direction = 'prefer_left',
    },
    icons = theme.kind_icons,
    nerd_font = true,
  },
}
