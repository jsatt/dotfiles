return {
  'monaqa/dial.nvim',
  config = function()
    local dial_config = require('dial.config')
    local augend = require('dial.augend')
    dial_config.augends:register_group({
      default = {
        augend.constant.new({ elements = { "true", "false" }, word = true, cyclic = true, preserve_case = true }),
        augend.integer.alias.decimal_int,
        augend.integer.alias.binary,
        augend.integer.alias.hex,
        augend.integer.alias.octal,
        augend.date.alias["%m/%d/%Y"],
        augend.date.alias["%Y-%m-%d"],
        augend.date.alias["%m/%d"],
        augend.date.alias["%H:%M"],
        augend.date.alias["%H:%M:%S"],
        augend.semver.alias.semver,
        augend.constant.new({ elements = { "and", "or" }, word = true, cyclic = true, preserve_case = true }),
        augend.constant.new({ elements = { "&&", "||" }, word = false, cyclic = true }),
        augend.constant.new({ elements = { "on", "off" }, word = true, cyclic = true, preserve_case = true }),
        augend.constant.new({ elements = { "yes", "no" }, word = true, cyclic = true, preserve_case = true }),
        augend.constant.new({ elements = { "is not", "is" }, word = true, cyclic = true, preserve_case = true }),
      },
    })
  end
}
