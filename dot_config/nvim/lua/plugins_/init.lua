return {
  'rbong/vim-flog',
  {
    'stevearc/dressing.nvim',
    config = function(_, opts) require('dressing').setup(opts) end,
  },
  'RRethy/vim-illuminate',
  'taybart/b64.nvim',

  -- VimScript
  'honza/vim-snippets', -- snippet pack
  'towolf/vim-helm',
  'tpope/vim-fugitive',
  'tpope/vim-eunuch',
  'AndrewRadev/linediff.vim',
  {
    'mg979/vim-visual-multi',
    branch = 'master',
    init = function()
      vim.g.VM_default_mappings = 0
    end,
  },
}
