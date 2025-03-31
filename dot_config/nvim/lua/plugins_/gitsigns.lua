local theme = require('theme_')
return {
  'lewis6991/gitsigns.nvim',
  opts = {
    signs = {
      add = {
        text = theme.signs.vcs.add.statuscolumn_text,
      },
      change = {
        text = theme.signs.vcs.change.statuscolumn_text,
      },
      changedelete = {
        text = theme.signs.vcs.changedelete.statuscolumn_text,
      },
      delete = {
        text = theme.signs.vcs.delete.statuscolumn_text,
      },
      topdelete = {
        text = theme.signs.vcs.changedelete.statuscolumn_text,
      },
      untracked = {
        text = theme.signs.vcs.untracked.statuscolumn_text,
      },
    },
    numhl = true,
  },
}
