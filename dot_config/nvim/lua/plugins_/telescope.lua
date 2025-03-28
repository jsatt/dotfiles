local theme = require('theme_')
local utils = require('utils_')

return {
  'nvim-telescope/telescope.nvim',
  dependencies = {
    'nvim-lua/plenary.nvim',
    'xiyaowong/telescope-emoji.nvim',
    'nvim-telescope/telescope-dap.nvim',
    'debugloop/telescope-undo.nvim',
    {
      'isak102/telescope-git-file-history.nvim',
      dependencies = { "tpope/vim-fugitive" },
    },
  },
  config = function(_, opts)
    local telescope = require('telescope')
    local actions = require('telescope.actions')
    local action_state = require('telescope.actions.state')

    local function _multiopen(prompt_bufnr, open_cmd)
      local picker = action_state.get_current_picker(prompt_bufnr)
      -- local selected_entry = action_state.get_selected_entry()
      local num_selections = #picker:get_multi_selection()
      if not num_selections or num_selections <= 1 then
        actions.add_selection(prompt_bufnr)
      end
      actions.send_selected_to_qflist(prompt_bufnr)
      vim.cmd("cdo " .. open_cmd)
      -- vim.cmd("q")  -- close last window because cdo runs twice on last quickfix entry for some reason
    end

    local function open_buffer_window(prompt_bufnr)
      local selected_bufnr = action_state.get_selected_entry().bufnr
      local buffound = false
      for _, tab in ipairs(vim.api.nvim_list_tabpages()) do
        for _, win in ipairs(vim.api.nvim_tabpage_list_wins(tab)) do
          if vim.api.nvim_win_get_buf(win) == selected_bufnr then
            buffound = true
            vim.api.nvim_set_current_win(win)
            break
          end
        end
        if buffound then
          break
        end
      end

      if not buffound then
        actions.file_tab(prompt_bufnr)
      end
    end

    local file_picker_mappings = {
      ["<TAB>"] = actions.toggle_selection,
      ["<C-TAB>"] = actions.toggle_selection + actions.move_selection_next,
      ["<S-TAB>"] = actions.toggle_selection + actions.move_selection_previous,
      -- ["<CR>"] = function(prompt_bufnr) _multiopen(prompt_bufnr, 'edit') end,
      -- ["<C-v>"] = function(prompt_bufnr) _multiopen(prompt_bufnr, 'vsplit') end,
      -- ["<C-s>"] = function(prompt_bufnr) _multiopen(prompt_bufnr, 'split') end,
      -- ["<C-t>"] = function(prompt_bufnr) _multiopen(prompt_bufnr, 'tabe') end,
    }

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
          '--follow',
          "--glob=!.git/",
        }
      },
      pickers = {
        buffers = {
          mappings = {
            i = {
              ["<CR>"] = open_buffer_window,
              ["<C-d>"] = actions.delete_buffer + actions.move_to_top,
            },
          }
        },
        find_files = {
          mappings = {
            i = file_picker_mappings,
            n = file_picker_mappings,
          }
        },
        old_files = {
          mappings = {
            i = file_picker_mappings,
            n = file_picker_mappings,
          }
        },
        live_grep = {
          mappings = {
            i = file_picker_mappings,
            n = file_picker_mappings,
          }
        },
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
    telescope.load_extension('git_file_history')
    utils.prepare_module('aerial', function() telescope.load_extension('aerial') end)
    utils.prepare_module('telescope._extensions.dap', function() telescope.load_extension('dap') end)
    utils.prepare_module('notify', function() telescope.load_extension('notify') end)
    utils.prepare_module('possession', function() telescope.load_extension('possession') end)
    utils.prepare_module('fidget', function() telescope.load_extension('fidget') end)
    utils.prepare_module('codecompanion', function() telescope.load_extension('codecompanion') end)
  end,
}
