return {
  'OXY2DEV/markview.nvim',
  -- enabled = false,
  lazy = false,
  config = function()
    local presets = require('markview.presets')
    require('markview').setup({
      markdown = {
        headings = vim.tbl_deep_extend('force', presets.headings.glow, {
          heading_1 = { icon = '𝟭 ' },
          heading_2 = { icon = '𝟮 ' },
          heading_3 = { icon = '𝟯 ' },
          heading_4 = { icon = '𝟰 ' },
          heading_5 = { icon = '𝟱 ' },
          heading_6 = { icon = '𝟲 ' },

        }),
        tables = presets.tables.single,
        list_items = {
          shift_width = 2,
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
