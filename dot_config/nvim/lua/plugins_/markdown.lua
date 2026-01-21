return {
  'MeanderingProgrammer/render-markdown.nvim',
  -- enabled = false,
  dependencies = {
    'nvim-treesitter/nvim-treesitter',
    -- 'nvim-tree/nvim-web-devicons'
  },
  config = function()
    require('render-markdown').setup({
      file_types = { "markdown", "codecompanion" },
      sign = { enabled = false },
      heading = {
        icons = {
          '󰎦 ', '󰎩 ', '󰎬 ', '󰎮 ', '󰎰 ', '󰎵 ',
        },
      },
      latex = { enabled = false },
      checkbox = {
        checked = { icon = '󰗡' },
        unchecked = { icon = '󰄰' },
        custom = {
          todo = {},
          in_progress = { raw = '[/]', rendered = '󱎖', highlight = 'RenderMarkdownTodo' },
          strike = { raw = '[-]', rendered = '󱃓', highlight = 'RenderMarkdownError', scope_highlight = 'RenderMarkdownStrike' },
        },
      },
      completions = {
        lsp = {
          enabled = true,
        },

        blink = {
          enabled = true,
        },
      },
      pipe_table = {
        -- render_modes = true,
        border_virtual = true,
      },
    })
  end,
}
