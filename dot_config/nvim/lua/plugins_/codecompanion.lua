return {
  "olimorris/codecompanion.nvim",
  dependencies = {
    "nvim-lua/plenary.nvim",
    "nvim-treesitter/nvim-treesitter",
    {
      'zbirenbaum/copilot.lua',
      cmd = "CopilotLua",
      event = "InsertEnter",
      config = function()
        require("copilot").setup({
          suggestion = { enabled = false },
          panel = { enabled = false },
          -- filetypes = { ['*'] = false },
        })
      end,
    },
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
      prompt_library = {
        ['research'] = {
          stratgegy = 'chat',
          description = 'does web research',
          prompts = {
            {
              role = 'system',
              content = [[
                  A guided research prompt that helps neovim conduct thorough web research. The prompt instructs neovim to:
                  • Start with broad searches to understand the topic landscape
                  • Prioritize high-quality, authoritative sources
                  • Iteratively refine the research direction based on findings
                  • Keep you informed and let you guide the research interactively
                  • Always cite sources with URLs
              ]]
            },
          },
        }
      }
    })


    -- https://gist.github.com/itsfrank/942780f88472a14c9cbb3169012a3328
    local Path = require("plenary.path")
    local data_path = vim.fn.stdpath("data")
    local save_folder = Path:new(data_path, "cc_saves")
    if not save_folder:exists() then
      save_folder:mkdir({ parents = true })
    end

    -- telescope picker for our saved chats
    vim.api.nvim_create_user_command("CodeCompanionLoad", function()
      local t_builtin = require("telescope.builtin")
      local t_actions = require("telescope.actions")
      local t_action_state = require("telescope.actions.state")

      local function start_picker()
        t_builtin.find_files({
          prompt_title = "Saved CodeCompanion Chats | <c-d>: delete",
          cwd = save_folder:absolute(),
          attach_mappings = function(_, map)
            map("i", "<c-d>", function(prompt_bufnr)
              local selection = t_action_state.get_selected_entry()
              local filepath = selection.path or selection.filename
              os.remove(filepath)
              t_actions.close(prompt_bufnr)
              start_picker()
            end)
            return true
          end,
        })
      end
      start_picker()
    end, {})

    -- save current chat, `CodeCompanionSave foo bar baz` will save as 'foo-bar-baz.md'
    vim.api.nvim_create_user_command("CodeCompanionSave", function(opts)
      local codecompanion = require("codecompanion")
      local success, chat = pcall(function()
        return codecompanion.buf_get_chat(0)
      end)
      if not success or chat == nil then
        vim.notify(
          "CodeCompanionSave should only be called from CodeCompanion chat buffers",
          vim.log.levels.ERROR
        )
        return
      end
      if #opts.fargs == 0 then
        vim.notify("CodeCompanionSave requires at least 1 arg to make a file name", vim.log.levels.ERROR)
      end
      local save_name = table.concat(opts.fargs, "-") .. ".md"
      local save_path = Path:new(save_folder, save_name)
      local lines = vim.api.nvim_buf_get_lines(0, 0, -1, false)
      save_path:write(table.concat(lines, "\n"), "w")
    end, { nargs = "*" })
  end
}
