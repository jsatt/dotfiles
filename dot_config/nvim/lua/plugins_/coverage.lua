return {
  'andythigpen/nvim-coverage',
  dependencies = { 'nvim-lua/plenary.nvim' },
  opts = {
    highlights = {
      covered = { link = 'GreenSign' }, -- supports style, fg, bg, sp (see :h highlight-gui)
      uncovered = { link = 'RedSign' },
    },
  }
}
