-- Automatically install packer
local install_path = vim.fn.stdpath 'data' .. '/site/pack/packer/start/packer.nvim'
if vim.fn.empty(vim.fn.glob(install_path)) > 0 then
  PACKER_BOOTSTRAP = vim.fn.system {
    'git',
    'clone',
    '--depth',
    '1',
    'https://github.com/wbthomason/packer.nvim',
    install_path,
  }
  print 'Installing packer close and reopen Neovim...'
  vim.cmd [[packadd packer.nvim]]
end

-- Autocommand that reloads neovim whenever you save the plugins.lua file
vim.cmd [[
  augroup packer_user_config
    autocmd!
    autocmd BufWritePost plugins.lua source <afile> | PackerSync
  augroup end
]]

-- Use a protected call so we don't error out on first use
local status_ok, packer = pcall(require, 'packer')
if not status_ok then
  return
end

-- Have packer use a popup window
packer.init {
  display = {
    open_fn = function()
      return require('packer.util').float { border = 'rounded' }
    end,
  },
}

-- Install your plugins here
packer.startup(function(use)
  use 'wbthomason/packer.nvim' -- Have packer manage itself

  -- Treesitter
  use {'nvim-treesitter/nvim-treesitter', run = ':TSUpdate'}
  use 'nvim-treesitter/playground'
  use 'p00f/nvim-ts-rainbow'

  -- VCS
  use 'tpope/vim-fugitive'
  use 'rbong/vim-flog'

  -- Sidebars
  use 'mbbill/undotree'
  use {
    'kyazdani42/nvim-tree.lua',
    requires = {
      'kyazdani42/nvim-web-devicons', -- optional, for file icon
    },
  }

  -- Code Completion
  use 'tpope/vim-surround'
  use 'mattn/emmet-vim'
  use {
    'numToStr/Comment.nvim',
  }
  use {'neoclide/coc.nvim', branch = 'release'}

  -- Commands
  use 'AndrewRadev/switch.vim'
  use 'tpope/vim-eunuch'
  use 'tpope/vim-speeddating'
  use 'AndrewRadev/linediff.vim'
  use {'mg979/vim-visual-multi', branch = 'master'}
  use 'RRethy/vim-illuminate'
  use {'ojroques/vim-oscyank', branch = 'main'}

  -- Vim Config
  use 'LucHermitte/lh-vim-lib'
  use 'LucHermitte/local_vimrc'
  use 'editorconfig/editorconfig-vim'
  -- use 'vim-airline/vim-airline'
  -- use 'vim-airline/vim-airline-themes'
  use 'nvim-lualine/lualine.nvim'
  use 'sainnhe/sonokai'

  -- Python
  use 'klen/python-mode'
  use 'jeetsukumaran/vim-pythonsense'
  use 'mgedmin/coverage-highlight.vim'

  -- Automatically set up your configuration after cloning packer.nvim
  -- Put this at the end after all plugins
  if PACKER_BOOTSTRAP then
    require('packer').sync()
  end
end)

--require'lspconfig'.gopls.setup {
  --on_attach = function(client)
    ---- [[ other on_attach code ]]
    --require 'illuminate'.on_attach(client)
  --end,
--}
local tree_cb = require'nvim-tree.config'.nvim_tree_callback
require'nvim-tree'.setup {
  view = {
    mappings = {
      list = {
        {key = 'S', cb = tree_cb('system_open')},
        {key = 's', cb = tree_cb('split')},
        {key = 'v', cb = tree_cb('vsplit')},
        {key = 't', cb = tree_cb('tabnew')},
      }
    }
  }
}

require('Comment').setup {
  ignore='^$',
}

require'nvim-treesitter.configs'.setup {
    ensure_installed = {
        'bash',
        'css',
        'dockerfile',
        'html',
        'javascript',
        'json',
        'lua',
        'query',
        'python',
        'vim',
        'yaml',
    },
    highlight = {
        enable = true
    },
    indent = {
        enable = true,
        disable = {'python'},
    },
    rainbow = {
        enable = true
    },
    --incremental_selection = {
    --    enable = true,
    --    keymaps = {
    --        init_selection = 'gnn',
    --        node_incremental = 'grn',
    --        scope_incremental = 'grc',
    --        node_decremental = 'grm',
    --    },
    --},
    playground = {
        enable = true,
        disable = {},
        updatetime = 25,
        persist_queries = false,
        keybindings = {
            toggle_query_editor = 'o',
            toggle_hl_groups = 'i',
            toggle_injected_languages = 't',
            toggle_anonymous_nodes = 'a',
            toggle_language_display = 'I',
            focus_language = 'f',
            unfocus_language = 'F',
            update = 'R',
            goto_node = '<cr>',
            show_help = '?',
            },
    }

}

-- OSC52
vim.g.oscyank_max_length = 1000000

-- ZenCoding
vim.g.user_emmet_expandabbr_key='<c-e>' -- expand w/ Ctrl-e

-- Lualine
require('lualine').setup {
  options = {
    theme = 'molokai',
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
    lualine_a = {'mode'},
    lualine_b = {
      {'branch', icon=''},
      {'diff', symbols={added=' ', modified=' ', removed=' '}}
    },
    lualine_c = {
      {'filename', symbols={readonly=''}},
    },
    lualine_x = {
      'filetype',
      {
        'diagnostics',
        always_visible=true,
        sources={'coc'},
        symbols = {error = "✗ ", warn = " ", info = " ", hint = " "},
      },
    },
    lualine_y = {'encoding', 'fileformat'},
    lualine_z = {
    'progress',
     {function() return ':%3l/%3L☰ :%-2v' end},  -- full file location
    },
  },
  tabline = {
    lualine_a = {{'tabs', mode=2, max_length = vim.o.columns}},
  },
  extensions = {'fugitive', 'nvim-tree'},
}

-- Python Mode
vim.g.pymode_options_max_line_length = 89
vim.g.pymode_options_colorcolumn = 0
vim.g.pymode_lint = 0
vim.g.pymode_rope = 0
vim.g.pymode_virtualenv = 1
vim.g.pymode_breakpoint_cmd = 'import ipdb; ipdb.set_trace()  # XXX BREAKPOINT'
vim.g.pymode_python = 'python3'
vim.g.pymode_doc = 0
vim.g.pymode_doc_bind = ''

-- CoC
vim.g.coc_global_extensions = {
  'coc-css',
  'coc-git',
  'coc-github',
  'coc-jira-complete',
  'coc-json',
  'coc-lists',
  'coc-marketplace',
  'coc-pyright',
  'coc-yank',
}

vim.cmd [[
function! _COC_check_back_space() abort
    let col = col('.') - 1
    return !col || getline('.')[col - 1]  =~# '\s'
endfunction

function! _COC_show_documentation()
  if (index(['vim','help'], &filetype) >= 0)
    execute 'h '.expand('<cword>')
  else
    call CocActionAsync('doHover')
  endif
endfunction
]]