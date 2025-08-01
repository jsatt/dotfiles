local theme = require('theme_')

vim.diagnostic.config {
  signs = {
    text = {
      [vim.diagnostic.severity.ERROR] = theme.signs.diagnostics.error.statuscolumn_text,
      [vim.diagnostic.severity.WARN] = theme.signs.diagnostics.warn.statuscolumn_text,
      [vim.diagnostic.severity.INFO] = theme.signs.diagnostics.info.statuscolumn_text,
      [vim.diagnostic.severity.HINT] = theme.signs.diagnostics.hint.statuscolumn_text,
    },
    texthl = {
      [vim.diagnostic.severity.ERROR] = theme.signs.diagnostics.error.statuscolumn_hl,
      [vim.diagnostic.severity.WARN] = theme.signs.diagnostics.warn.statuscolumn_hl,
      [vim.diagnostic.severity.INFO] = theme.signs.diagnostics.info.statuscolumn_hl,
      [vim.diagnostic.severity.HINT] = theme.signs.diagnostics.hint.statuscolumn_hl,
    },
    numhl = {
      [vim.diagnostic.severity.ERROR] = theme.signs.diagnostics.error.statuscolumn_numhl,
      [vim.diagnostic.severity.WARN] = theme.signs.diagnostics.warn.statuscolumn_numhl,
      [vim.diagnostic.severity.INFO] = theme.signs.diagnostics.info.statuscolumn_numhl,
      [vim.diagnostic.severity.HINT] = theme.signs.diagnostics.hint.statuscolumn_numhl,
    },
  },
  update_in_insert = false,
  underline = true,
  severity_sort = true,
  virtual_text = {
    prefix = function (diagnostic)
      if diagnostic.source then
        return diagnostic.source .. ": "
      else
        return ""
      end
    end,
    suffix = function (diagnostic)
      if diagnostic.code then
        return " [" .. diagnostic.code .. "]"
      else
        return ""
      end
    end,
    format = function (diagnostic)
      return diagnostic.message
    end,
  },
  -- virtual_lines = {
  --   current_line = true,
  --   format = function (diagnostic)
  --     local message = ""
  --     if diagnostic.source then
  --       message = diagnostic.source .. ": "
  --     end
  --     message = message .. diagnostic.message
  --     if diagnostic.code then
  --       message = message .. " [" .. diagnostic.code .. "]"
  --     end
  --     return message
  --   end,
  -- },
  float = {
    focusable = false,
    -- style = "minimal",
    source = true,
    -- header = "",
    -- prefix = "",
  },
}

-- local og_virt_text
-- local og_virt_line
-- vim.api.nvim_create_autocmd({ 'CursorMoved', 'DiagnosticChanged' }, {
--   group = vim.api.nvim_create_augroup('diagnostic_only_virtlines', {}),
--   callback = function()
--     if og_virt_line == nil then
--       og_virt_line = vim.diagnostic.config().virtual_lines
--     end
--
--     -- ignore if virtual_lines.current_line is disabled
--     if not (og_virt_line and og_virt_line.current_line) then
--       if og_virt_text then
--         vim.diagnostic.config({ virtual_text = og_virt_text })
--         og_virt_text = nil
--       end
--       return
--     end
--
--     if og_virt_text == nil then
--       og_virt_text = vim.diagnostic.config().virtual_text
--     end
--
--     local lnum = vim.api.nvim_win_get_cursor(0)[1] - 1
--
--     if vim.tbl_isempty(vim.diagnostic.get(0, { lnum = lnum })) then
--       vim.diagnostic.config({ virtual_text = og_virt_text })
--     else
--       vim.diagnostic.config({ virtual_text = false })
--     end
--   end
-- })
