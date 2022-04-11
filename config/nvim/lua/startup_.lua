local utils = require('utils_')
utils.prepare_module('impatient', utils.noop) -- optimize lua plugins
vim.opt.termguicolors = vim.fn.has("termguicolors") == 1 and true or false -- enable RGB colors if available
