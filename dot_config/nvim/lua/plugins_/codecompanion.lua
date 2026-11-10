local utils = require('utils_')

return {
  "olimorris/codecompanion.nvim",
  dependencies = {
    "nvim-lua/plenary.nvim",
    "nvim-treesitter/nvim-treesitter",
    "ravitemer/codecompanion-history.nvim",
    {
      "ravitemer/mcphub.nvim",
      dependencies = {
        "nvim-lua/plenary.nvim",
      },
      -- build = "bundled_build.lua", -- Bundles `mcp-hub` binary along with the neovim plugin
      -- config = function()
      --   local mcphub = require("mcphub")
      --   mcphub.setup({
      --     use_bundled_binary = true, -- Use local `mcp-hub` binary
      --   })
      -- end,
    },
    -- {
    --   "Davidyz/VectorCode",
    --   dependencies = { "nvim-lua/plenary.nvim" },
    --   config = function()
    --     require('vectorcode').setup({
    --       async_backend = 'lsp',
    --     })
    --   end,
    -- }
    -- {  -- May be needed to setup Copliot Auth
    --   "zbirenbaum/copilot.lua",
    --   cmd = "Copilot",
    --   event = "InsertEnter",
    --   config = function()
    --     require("copilot").setup({})
    --   end,
    -- }
  },
  -- init = function()
  --   require("plugins_.utils.codecompanion.fidget-spinner"):init()
  -- end,
  config = function()
    require('codecompanion').setup({
      display = {
        -- diff = {
        --   enabled = false,
        -- },
        chat = {
          show_header_separator = true,
          -- show_settings = true,
          -- start_in_insert_mode = false,
          input = {
            layout = "split",
            height = 8,
          },
        },
      },
      interactions = {
        chat = {
          adapter = {
            name = "claude_code",
            model = "sonnet",
          },
          keymaps = {
            send = {
              modes = { n = "<CR><CR>", i = "<CR><CR>" },
            },
            close = {
              condition = function() return false end,
            },
          },
          sessions = {
            enabled = true,
            autosave = true,
            continuous_save = true,
            save_dir = vim.fs.joinpath(vim.fn.stdpath("data"), "codecompanion", "sessions"),
          },
        },
        background = {
          adapter = {
            name = "docker_model_runner",
            model = "qwen3-coder",
          },
          chat = {
            opts = {
              enabled = true,
            },
            callbacks = {
              ["on_ready"] = {
                actions = {
                  {
                    path = "interactions.background.builtin.chat_make_title",
                  },
                },
              },
            },
          },
        },
      },
      adapters = {
        acp = {
          opts = {
            show_presets = false,
          },
          claude_code = function()
            return require("codecompanion.adapters").extend("claude_code", {})
          end,
          codex = function()
            return require("codecompanion.adapters").extend("codex", {
              defaults = {
                auth_method = "chat-gpt",
              },
            })
          end,
        },
        http = {
          opts = {
            show_presets = false,
          },
          openai = function()
            return require('codecompanion.adapters').extend('openai', {})
          end,
          copilot = function()
            return require('codecompanion.adapters').extend('copilot', {
              schema = {
                model = {
                  default = "claude-haiku-4.5",
                }
              }
            })
          end,
          docker_model_runner = function()
            return require('codecompanion.adapters').extend('openai_compatible', {
              name = "docker_model_runner",
              formatted_name = "Docker Model Runner",
              env = {
                url = "http://localhost:12434/engines",
                api_key = "docker", -- not checked by Model Runner, but a value is required
              },
            })
          end,
        },
      },
      rules = {
        opts = {
          chat = {
            enabled = function(chat) return chat.adapter.type == "http" end,
          },
        },
      },
      extensions = {
        history = {
          enabled = true,
          opts = {
            title_generation_opts = {
              adapter = "docker_model_runner",
              model = "qwen3-coder",
            },
          }
        },
        mcphub = {
          callback = "mcphub.extensions.codecompanion",
          opts = {
            show_result_in_chat = true, -- Show mcp tool results in chat
            make_vars = true,           -- Convert resources to #variables
            make_slash_commands = true, -- Add prompts as /slash commands
          }
        },
        -- vectorcode = {
        --   opts = {
        --     tool_group = {
        --       enabled = true,
        --     }
        --   },
        -- }
      },
    })
    utils.prepare_module('telescope', function(telescope) telescope.load_extension('codecompanion') end)
  end
}
