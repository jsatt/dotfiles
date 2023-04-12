return {
  'jedrzejboczar/possession.nvim',
  dependencies = { 'nvim-lua/plenary.nvim' },
  opts = {
    autosave = {
      current = true,
      on_quit = true,
    },
    commands = {
      save = 'SSave',
      load = 'SLoad',
      close = 'SClose',
      delete = 'SDelete',
      show = 'SShow',
      list = 'SList',
      migrate = 'SMigrate',
    },
  },
}
