return {
    'MeanderingProgrammer/render-markdown.nvim',
    dependencies = { 'nvim-treesitter/nvim-treesitter' },
    config = function()
        require('render-markdown').setup({})
    end,
}
