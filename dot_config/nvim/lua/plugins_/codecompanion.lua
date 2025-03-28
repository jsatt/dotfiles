return {
  "olimorris/codecompanion.nvim",
  dependencies = {
    "nvim-lua/plenary.nvim",
    "nvim-treesitter/nvim-treesitter",
    {
      'zbirenbaum/copilot.lua',
      cmd = "CopilotLua",
      event = "InsertEnter",
      dependencies = {
      'zbirenbaum/copilot-cmp',
      },
      config = function()
        require("copilot").setup({
          suggestion = { enabled = false },
          panel = { enabled = false },
          -- filetypes = { ['*'] = false },
        })
        require("copilot_cmp").setup()
      end,
    }
  },
  init = function()
    require("plugins_.utils.codecompanion.fidget-spinner"):init()
  end,
  config = function()
    require('codecompanion').setup({
      display = {
        diff = {
          enabled = false,
        },
        chat = {
          show_header_separator = true,
          show_settings = true,
          -- start_in_insert_mode = false,
        },
      },
      strategies = {
        chat = {
          keymaps = {
            send = {
              modes = { n = "<CR><CR>", i = "<CR><CR>" },
            },
            close = {
              condition = function() return false end,
            },
          },
        },
      },
      adapters = {
        copilot = function()
          return require('codecompanion.adapters').extend('copilot', {
            schema = {
              model = {
                default = "claude-3.7-sonnet",
              }
            }
          })
        end,
      }
    })
  end
}
