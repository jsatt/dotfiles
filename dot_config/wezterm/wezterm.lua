local wezterm                       = require("wezterm")
local config                        = wezterm.config_builder()

config.term                         = 'xterm-256color'

-- Interface
config.audible_bell                 = "Disabled"
config.default_cursor_style         = 'BlinkingBlock'
config.hide_tab_bar_if_only_one_tab = true
config.unicode_version              = 14
config.window_close_confirmation    = 'NeverPrompt'
config.window_padding               = {
  left = 3,
  right = 3,
  top = 0,
  bottom = 0,
}
config.unzoom_on_switch_pane        = false
config.use_fancy_tab_bar            = false
config.tab_max_width                = 50
require('tabline').setup()

--- Font
config.font                             = wezterm.font("Anonymous Pro")
config.font_size                        = 11
config.allow_square_glyphs_to_overflow_width = "Always"
config.line_height                      = 1.1
config.cell_width                       = 1.1
-- Update this after any wezterm relase in 2025
-- config.cell_widths = {
--   { first = 0xe000, last = 0xf8ff, width = 2 },
--   { first = 0xf0000, last = 0xf1fff, width = 2 },
-- }
config.freetype_load_target             = "Light"
config.freetype_load_flags              = 'NO_BITMAP|NO_HINTING'

--- Colors
config.color_scheme                     = '3024 (dark) (terminal.sexy)'
config.window_background_opacity        = .85
config.inactive_pane_hsb                = {
  brightness = 0.5,
}

-- Domains
local domains                           = require('domains')
config.exec_domains                     = domains.compute_exec_domains()
config.default_domain                   = domains.select_domain('docker:devbox-devbox-1', 'local', config.exec_domains)

-- Bindings
local bindings                          = require('bindings')
config.disable_default_key_bindings     = true
config.keys                             = bindings.keys
config.key_tables                       = bindings.key_tables
config.mouse_bindings                   = bindings.mouse
config.bypass_mouse_reporting_modifiers = "SHIFT|CTRL"

return config
