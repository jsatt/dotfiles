local theme = require('theme_')
return {
  'rcarriga/nvim-notify',
  opts = {
    stages = 'slide',
    icons = {
      TRACE = theme.icons.error,
      DEBUG = theme.icons.hint,
      INFO = theme.icons.info,
      WARN = theme.icons.warn,
      ERROR = theme.icons.error,
    }
  },
  init = function()
    vim.notify = require('notify')
  end
}
