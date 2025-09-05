return {
  "olimorris/codecompanion.nvim",
  dependencies = {
    "nvim-lua/plenary.nvim",
    "nvim-treesitter/nvim-treesitter",
    {
      "ravitemer/mcphub.nvim",
      dependencies = {
        "nvim-lua/plenary.nvim",
      },
      build = "bundled_build.lua", -- Bundles `mcp-hub` binary along with the neovim plugin
      config = function()
        local mcphub = require("mcphub")
        mcphub.setup({
          use_bundled_binary = true, -- Use local `mcp-hub` binary
        })
      end,
    },
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
        http = {
          copilot = function()
            return require('codecompanion.adapters').extend('copilot', {
              schema = {
                model = {
                  default = "claude-sonnet-4",
                }
              }
            })
          end,
        },
      },
      extensions = {
        mcphub = {
          callback = "mcphub.extensions.codecompanion",
          opts = {
            show_result_in_chat = true, -- Show mcp tool results in chat
            make_vars = true,           -- Convert resources to #variables
            make_slash_commands = true, -- Add prompts as /slash commands
          }
        }
      },
    })
  end
}
