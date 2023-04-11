local utils = require('utils_')
local theme = require('theme_')

utils.prepare_module('lualine', function(lualine)
  local function window_number()
    return vim.api.nvim_win_get_number(0)
  end

  local function search_count()
    local search = vim.fn.searchcount({ maxcount = 0 }) -- maxcount = 0 makes the number not be capped at 99
    local searchCurrent = search.current
    local searchTotal = search.total
    if searchCurrent > 0 then
      return "/" .. vim.fn.getreg("/") .. " [" .. searchCurrent .. "/" .. searchTotal .. "]"
    else
      return ""
    end
  end

  local function session_name()
    return utils.prepare_module(
      'possession.session',
      function(session)
        return session.session_name or ''
      end) or ''
  end

  local function cwd()
    return vim.fn.fnamemodify(vim.fn.getcwd(), ':~') or ''
  end

  local function show_macro_recording()
    local recording_register = vim.fn.reg_recording()
    if recording_register == "" then
      return ""
    else
      return "Recording @" .. recording_register
    end
  end

  lualine.setup {
    options = {
      theme = theme.lualine_theme,
      globalstatus = true,
      section_separators = {
        right = '',
        left = '',
      },
      component_separators = {
        right = '',
        left = '',
      },
    },
    sections = {
      lualine_a = { 'mode' },
      lualine_b = {
        cwd,
        { 'branch', icon = '' },
      },
      lualine_c = {
        { 'diff',
          symbols = {
            added = theme.statusline_gitsigns.add.text .. ' ',
            modified = theme.statusline_gitsigns.change.text .. ' ',
            removed = theme.statusline_gitsigns.delete.text .. ' ',
          },
          diff_color = {
            added = theme.statusline_gitsigns.add.hl,
            modified = theme.statusline_gitsigns.change.hl,
            removed = theme.statusline_gitsigns.delete.hl,
          }
        }
      },
      lualine_x = {
      },
      lualine_y = {
        session_name,
      },
      lualine_z = {
        search_count,
        show_macro_recording,
      },
    },
    inactive_sections = {},
    tabline = {
      lualine_a = {
        {
          'tabs',
          mode = 2,
          max_length = vim.o.columns,
          fmt = function(name) return ' ' .. name end
        }
      },
    },
    winbar = {
      lualine_b = {
        window_number,
        { 'filename', path = 1, symbols = { readonly = '' } },
      },
      lualine_c = {
        { 'aerial', colored = false },
      },
      lualine_x = {
        {
          'diagnostics',
          always_visible = true,
          diagnostics_color = {
            error = theme.signs.error.ll_name,
            warn  = theme.signs.warn.ll_name,
            info  = theme.signs.info.ll_name,
            hint  = theme.signs.hint.ll_name,
          },
          symbols = {
            error = theme.signs.error.text .. ' ',
            warn = theme.signs.warn.text .. ' ',
            info = theme.signs.info.text .. ' ',
            hint = theme.signs.hint.text .. ' ',
          },
        },
        'filetype',
        'encoding',
        'fileformat'
      },
      lualine_y = {
        'progress',
        { function() return ':%3l/%3L☰ :%-2v' end }, -- full file location
      },
      lualine_z = {}
    },
    inactive_winbar = {
      lualine_b = {
        window_number,
        { 'filename', path = 1, symbols = { readonly = '' } },
      },
      lualine_x = {
        'filetype',
        'encoding',
        'fileformat'
      },
      lualine_y = {
        'progress',
        { function() return ':%3l/%3L☰ :%-2v' end }, -- full file location
      },
    },
    extensions = {
      'fugitive',
      'nvim-tree',
      'aerial',
      'nvim-dap-ui',
    },
  }
end)
