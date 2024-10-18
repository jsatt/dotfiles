local theme = require('theme_')
return {
  'nvim-neo-tree/neo-tree.nvim',
  branch = "v3.x",
  dependencies = {
    "nvim-lua/plenary.nvim",
    "nvim-tree/nvim-web-devicons",
    "MunifTanjim/nui.nvim",
    {
      's1n7ax/nvim-window-picker',
      tag = "v1.5",
      opts = {
        autoselect_one = true,
        include_current = false,
        selection_chars = 'ABCDEFGHIJKLMNOPQRSTUVWXYZ',
        filter_rules = {
          bo = {
            filetype = { 'neo-tree', "neo-tree-popup", "notify" },
            buftype = { 'terminal', "quickfix" },
          },
        },
        other_win_hl_color = '#e35e4f',
      },
    }
  },
  opts = {
    filesystem = {
      group_empty_dirs = true,
      bind_to_cwd = false,
      filtered_items = {
        hide_dotfiles = false,
      },
      commands = {
        set_cwd = function(state)
          local manager = require("neo-tree.sources.manager")
          manager.set_cwd(state)
        end
      },
      window = {
        mappings = {
          ["S"] = "split_with_window_picker",
          ["s"] = "vsplit_with_window_picker",
          ["!"] = "set_cwd",
        },
      },
    },
    default_component_configs = {
      git_status = {
        symbols = {
          added = theme.icons.vcs_add,
          modified = theme.icons.vcs_change,
          deleted = theme.icons.vcs_delete,
          renamed = theme.icons.vcs_rename,
          untracked = theme.icons.vcs_untracked,
        },
      },
      name = {
        highlight_opened_files = true,
      },
    },
    source_selector = {winbar = true},
  },
}
