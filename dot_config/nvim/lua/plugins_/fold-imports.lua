return {
  "dmtrKovalenko/fold-imports.nvim",
  event = "BufRead",
  config = function()
    local fold_imports = require('fold_imports')
    fold_imports.setup({
      fold_level=vim.api.nvim_get_option_value('foldlevelstart', {}),
    })
  end,
}
