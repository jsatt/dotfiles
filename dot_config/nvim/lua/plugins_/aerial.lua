local theme = require('theme_')
return {
  'stevearc/aerial.nvim',
  opts = {
    layout = {
      default_direction = 'prefer_left',
    },
    icons = theme.kind_icons,
    link_folds_to_tree = true,
    link_tree_to_folds = true,
    manage_folds = true,
    nerd_font = true,
  },
}
