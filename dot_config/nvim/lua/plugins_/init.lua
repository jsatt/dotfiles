return {
  'honza/vim-snippets', -- snippet pack
  'towolf/vim-helm',
  'tpope/vim-fugitive',
  'rbong/vim-flog',
  'tpope/vim-eunuch',
  'AndrewRadev/linediff.vim',
  {
    'stevearc/dressing.nvim',
    config = function() require('dressing').setup({}) end,
  },
  {
    'mg979/vim-visual-multi',
    branch = 'master',
    init = function()
      vim.g.VM_default_mappings = 0
    end,
  },
  'RRethy/vim-illuminate',
  'taybart/b64.nvim',
}
