return {
  'OXY2DEV/markview.nvim',
  -- enabled = false,
  lazy = false,
  config = function()
    local presets = require('markview.presets')
    require('markview').setup({
      markdown = {
        headings = presets.headings.glow,
        tables = presets.tables.single,
        list_items = {
          shift_width = 2,
        },
      },
      preview = {
        icon_provider = 'devicons',
        hybrid_modes = {'n', 'no', 'c'},
        linewise_hybrid_mode = true,
        filetypes = {'markdown', 'codecompanion'},
        ignore_buftypes = {},
      },
    })
  end
}
