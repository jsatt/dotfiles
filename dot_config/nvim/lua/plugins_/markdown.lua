return {
  'MeanderingProgrammer/render-markdown.nvim',
  enabled = false,
  dependencies = { 'nvim-treesitter/nvim-treesitter' },
  config = function()
    require('render-markdown').setup({
      ft = { "markdown", "codecompanion" },
    })
  end,
}
