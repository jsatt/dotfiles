return {
  'OXY2DEV/markview.nvim',
  -- enabled = false,
  lazy = false,
  config = function()
    local presets = require('markview.presets')
    require('markview').setup({
      markdown = {
        headings = vim.tbl_deep_extend('force', presets.headings.glow, {
          heading_1 = { icon = '󰎦 ' },
          heading_2 = { icon = '󰎩 ' },
          heading_3 = { icon = '󰎬 ' },
          heading_4 = { icon = '󰎮 ' },
          heading_5 = { icon = '󰎰 ' },
          heading_6 = { icon = '󰎵 ' },

        }),
        tables = presets.tables.single,
        list_items = {
          shift_width = 2,
          marker_minus = {
            text = ""
          },
          marker_plus = {
            text = ""
          },
          marker_star = {
            text = ""
          },
        },
      },
      preview = {
        icon_provider = 'devicons',
        hybrid_modes = { 'n', 'no', 'c' },
        linewise_hybrid_mode = true,
        filetypes = { 'markdown', 'codecompanion' },
        ignore_buftypes = {},
      },
    })
  end
}
