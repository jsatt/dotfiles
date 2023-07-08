return {
  'numToStr/Comment.nvim',
  opts = {
    ignore = '^$',
  },
  config = function(_, opts)
    require('Comment').setup(opts)
    local ft = require('Comment.ft')
    ft.set('hcl', ft.get('terraform'))
  end
}
