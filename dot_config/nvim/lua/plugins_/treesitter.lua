local ensure_installed = {
  'bash',
  'comment',
  'css',
  'diff',
  'dockerfile',
  'gitcommit',
  'gitignore',
  'git_config',
  'git_rebase',
  'glimmer', -- handlebars/mustache/etc
  'graphql',
  'hcl',
  'html',
  'htmldjango',
  'ini',
  'javascript',
  'json',
  'kotlin',
  'lua',
  'make',
  'markdown',
  'markdown_inline',
  'passwd',
  'pem',
  'python',
  'query',
  'regex',
  'sql',
  'terraform',
  'toml',
  'typescript',
  'vim',
  'vimdoc',
  'yaml',
}

return {
  'nvim-treesitter/nvim-treesitter',
  dependencies = {
    {
      'nvim-treesitter/nvim-treesitter-textobjects',
      branch = 'main',
    },
    'hiphish/rainbow-delimiters.nvim',
  },
  lazy = false,
  branch = 'main',
  build = ':TSUpdate',
  config = function()
    local treesitter = require('nvim-treesitter')

    treesitter.setup()
    treesitter.install(ensure_installed)
    -- local installed = require('nvim-treesitter.config').get_installed()
    -- local not_installed = vim.tbl_filter(
    --   function(parser) return not vim.tbl_contains(installed, parser) end,
    --   ensure_installed
    -- )
    -- if #not_installed > 0 then require('nvim-treesitter').install(not_installed) end

    vim.api.nvim_create_autocmd('FileType', {
      pattern = ensure_installed,
      callback = function()
        vim.treesitter.start()
        vim.wo.foldexpr = 'v:lua.vim.treesitter.foldexpr()'
        vim.bo.indentexpr = "v:lua.require'nvim-treesitter'.indentexpr()"
      end,
    })

    require('nvim-treesitter-textobjects').setup({
      select = {
        lookahead = true,
      },
      move = {
        set_jumps = true, -- whether to set jumps in the jumplist
      },
    })

    require('rainbow-delimiters.setup').setup {
      strategy = {
        [''] = 'rainbow-delimiters.strategy.local',
      },
    }
  end,
}
