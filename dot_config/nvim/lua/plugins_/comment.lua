return {
  'numToStr/Comment.nvim',
  config = function()
    require('Comment').setup({
      ignore = '^$',
    })
    local ft = require('Comment.ft')
    ft.set('hcl', ft.get('terraform'))
  end
}
