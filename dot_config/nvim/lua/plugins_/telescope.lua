local utils = require('utils_')
return {
  'nvim-telescope/telescope.nvim',
  dependencies = {
    'nvim-lua/plenary.nvim',
    'xiyaowong/telescope-emoji.nvim',
    'nvim-telescope/telescope-dap.nvim',
  },
  config = function()
    local telescope = require('telescope')
    telescope.setup({
      defaults = {
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
    })
    utils.prepare_module('aerial', function() telescope.load_extension('aerial') end)
    utils.prepare_module('telescope._extensions.dap', function() telescope.load_extension('dap') end)
    utils.prepare_module('notify', function() telescope.load_extension('notify') end)
    utils.prepare_module('possession', function() telescope.load_extension('possession') end)
  end,
}
