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
  'gotmpl',
  'graphql',
  'hcl',
  'helm',
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
    {
      'MeanderingProgrammer/treesitter-modules.nvim',
      opts = {
        ensure_installed = ensure_installed,
        auto_install = true,
        fold = {
          enabled = true,
        },
        highlight = {
          enabled = true,
        },
        indent = {
          enabled = true,
        },
      },
    }
  },
  lazy = false,
  branch = 'main',
  build = ':TSUpdate',
  config = function()
    local treesitter = require('nvim-treesitter')

    treesitter.setup()
    treesitter.install(ensure_installed)

    vim.api.nvim_create_autocmd('FileType', {
      pattern = ensure_installed,
      callback = function(args)
        local lang = vim.treesitter.language.get_lang(args.match)
        if not lang then
          return
        end
        if not vim.treesitter.language.add(lang) then
          return
        end

        vim.treesitter.start(args.buf, lang)
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

    -- local strategy breaks after upgrade to nvim 0.12, test later to see if fixed
    -- require('rainbow-delimiters.setup').setup {
    --   strategy = {
    --     [''] = 'rainbow-delimiters.strategy.local',
    --   },
    -- }
  end,
}
