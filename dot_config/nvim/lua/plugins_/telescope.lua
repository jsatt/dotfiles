local theme = require('theme_')
local utils = require('utils_')
return {
  'nvim-telescope/telescope.nvim',
  dependencies = {
    'nvim-lua/plenary.nvim',
    'xiyaowong/telescope-emoji.nvim',
    'nvim-telescope/telescope-dap.nvim',
    "debugloop/telescope-undo.nvim",
  },
  config = function(_, opts)
    local telescope = require('telescope')
    telescope.setup({
      defaults = {
        mappings = {
          i = {
            ["<C-Down>"] = require('telescope.actions').cycle_history_next,
            ["<C-Up>"] = require('telescope.actions').cycle_history_prev,
          },
        },
        vimgrep_arguments = {
          'rg',
          '--color', 'never',
          '--no-heading',
          '--with-filename',
          '--line-number',
          '--column',
          '--smart-case',
          '--hidden',
          "--glob=!.git/",
        }
      },
      extensions = {
        undo = {
          side_by_side = true,
          layout_strategy = "vertical",
          layout_config = {
            preview_height = 0.8,
          },
        },
      },
    })
    telescope.load_extension('undo')
    utils.prepare_module('aerial', function() telescope.load_extension('aerial') end)
    utils.prepare_module('telescope._extensions.dap', function() telescope.load_extension('dap') end)
    utils.prepare_module('notify', function() telescope.load_extension('notify') end)
    utils.prepare_module('possession', function() telescope.load_extension('possession') end)
  end,
}
