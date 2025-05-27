local utils = require('utils_')
local theme = require('theme_')

local function window_number()
  return vim.api.nvim_win_get_number(0)
end

local function tabpage_window_count(tabnr)
  local win_count = 0
  for _, bufnr in ipairs(vim.fn.tabpagebuflist(tabnr)) do
    if vim.fn.getbufvar(bufnr, '&buftype') == '' then
      win_count = win_count + 1
    end
  end
  return win_count
end

local function buffer_number()
  return vim.api.nvim_get_current_buf()
end

local function tab_had_modified_bufs(tabnr)
  for _, v in ipairs(vim.fn.tabpagebuflist(tabnr)) do
    if vim.fn.getbufvar(v, '&mod') == 1 then
      return true
    end
  end
  return false
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
      return session.get_session_name() or ''
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

return {
  'nvim-lualine/lualine.nvim',
  dependencies = {
    'nvim-tree/nvim-web-devicons',
    lazy = true,
  },
  opts = {
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
      disabled_filetypes = {
        winbar = {
          'neo-tree',
        },
      },
    },
    sections = {
      lualine_a = { 'mode' },
      lualine_b = {
        cwd,
        { 'branch', icon = '' },
      },
      lualine_c = {
        {
          'diff',
          symbols = {
            added = theme.signs.vcs.add.statusline_text .. ' ',
            modified = theme.signs.vcs.change.statusline_text .. ' ',
            removed = theme.signs.vcs.delete.statusline_text .. ' ',
          },
          diff_color = {
            added = theme.signs.vcs.add.statusline_hl,
            modified = theme.signs.vcs.change.statusline_hl,
            removed = theme.signs.vcs.delete.statusline_hl,
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
          mode = 1,
          max_length = vim.o.columns,
          fmt = function(name, context)
            local win_count = tabpage_window_count(context.tabnr)
            return context.tabnr .. '•' .. win_count .. '  ' .. name
          end
        }
      },
    },
    winbar = {
      lualine_b = {
        buffer_number,
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
            error = theme.signs.diagnostics.error.statusline_hl,
            warn  = theme.signs.diagnostics.warn.statusline_hl,
            info  = theme.signs.diagnostics.info.statusline_hl,
            hint  = theme.signs.diagnostics.hint.statusline_hl,
          },
          symbols = {
            error = theme.signs.diagnostics.error.statusline_text .. ' ',
            warn = theme.signs.diagnostics.warn.statusline_text .. ' ',
            info = theme.signs.diagnostics.info.statusline_text .. ' ',
            hint = theme.signs.diagnostics.hint.statusline_text .. ' ',
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
        buffer_number,
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
      'lazy',
      'man',
      'neo-tree',
      'quickfix',
      {
        winbar = { lualine_b = { { 'filetype' } } },
        filetypes = {
          'aerial',
        }
      },
      {
        winbar = { lualine_b = { { 'filename', file_status = false } } },
        filetypes = {
          'dap-repl',
          'dapui_console',
          'dapui_watches',
          'dapui_stacks',
          'dapui_breakpoints',
          'dapui_scopes',
        }
      },
    },
  }
}
