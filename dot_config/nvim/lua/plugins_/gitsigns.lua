local theme = require('theme_')
return {
  'lewis6991/gitsigns.nvim',
  opts = {
    signs = {
      add = {
        text = theme.signs.vcs.add.statuscolumn_text,
        hl = theme.signs.vcs.add.statuscolumn_hl,
        numhl = theme.signs.vcs.add.statuscolumn_numhl,
        linehl = theme.signs.vcs.add.statuscolumn_linehl,
      },
      change = {
        text = theme.signs.vcs.change.statuscolumn_text,
        hl = theme.signs.vcs.change.statuscolumn_hl,
        numhl = theme.signs.vcs.change.statuscolumn_numhl,
        linehl = theme.signs.vcs.change.statuscolumn_linehl,
      },
      changedelete = {
        text = theme.signs.vcs.changedelete.statuscolumn_text,
        hl = theme.signs.vcs.changedelete.statuscolumn_hl,
        numhl = theme.signs.vcs.changedelete.statuscolumn_numhl,
        linehl = theme.signs.vcs.changedelete.statuscolumn_linehl,
      },
      delete = {
        text = theme.signs.vcs.delete.statuscolumn_text,
        hl = theme.signs.vcs.delete.statuscolumn_hl,
        numhl = theme.signs.vcs.delete.statuscolumn_numhl,
        linehl = theme.signs.vcs.delete.statuscolumn_linehl,
      },
      topdelete = {
        text = theme.signs.vcs.changedelete.statuscolumn_text,
        hl = theme.signs.vcs.changedelete.statuscolumn_hl,
        numhl = theme.signs.vcs.changedelete.statuscolumn_numhl,
        linehl = theme.signs.vcs.changedelete.statuscolumn_linehl,
      },
      untracked = {
        text = theme.signs.vcs.untracked.statuscolumn_text,
      },
    },
    numhl = true,
    word_diff = true,
    preview_config = {
      border = theme.opts.border_style,
    },
  },
}
