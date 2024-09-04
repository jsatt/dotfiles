local wezterm      = require("wezterm")
local tabline      = wezterm.plugin.require("https://github.com/michaelbrusegard/tabline.wez")

local pane_title = function(tab)
  return tab.active_pane.title
end

local tab_hostname = function(tab)
  local cwd_uri = tab.active_pane.current_working_dir
  local hostname = ''

  if cwd_uri == nil then
    hostname = wezterm.hostname()
  elseif type(cwd_uri) == 'userdata' then
    hostname = cwd_uri.host or wezterm.hostname()
  else
    cwd_uri = cwd_uri:sub(8)
    local slash = cwd_uri:find('/')
    if slash then
      hostname = cwd_uri:sub(1, slash - 1)
    end
  end

  local dot = hostname:find('[.]')
  if dot then
    hostname = hostname:sub(1, dot - 1)
  end

  return hostname
end

return {
  setup = function()
    tabline.setup({
      options = {
        color_overrides = {
          normal_mode = {
            a = { fg = '#141413', bg = '#aeee00' },
            b = { fg = '#f4cf86', bg = '#45413b' },
            c = { fg = '#8cffba', bg = '#242321' },
          },
          copy_mode = {
            a = { fg = '#141413', bg = '#0a9dff' },
            b = { fg = '#f4cf86', bg = '#005fff' },
            c = { fg = '#0a9dff', bg = '#242321' },
          },
          search_mode = {
            a = { fg = '#141413', bg = '#ffa724' },
            b = { fg = '#000000', bg = '#fade3e' },
            c = { fg = '#000000', bg = '#b88853' },
          },
          tab = {
            active = { fg = '#141413', bg = '#aeee00' },
            inactive = { fg = '#242321', bg = '#45413b' },
          },
        },
        section_separators = {
          left = wezterm.nerdfonts.ple_right_half_circle_thick,
          right = wezterm.nerdfonts.ple_left_half_circle_thick,
        },
        component_separators = {
          left = wezterm.nerdfonts.ple_right_half_circle_thin,
          right = wezterm.nerdfonts.ple_left_half_circle_thin,
        },
        tab_separators = {
          left = wezterm.nerdfonts.ple_right_half_circle_thick,
          right = wezterm.nerdfonts.ple_left_half_circle_thick,
        },
      },
      sections = {
        tabline_a = { 'mode' },
        tabline_b = { '' },
        tabline_c = { '' },
        tab_active = { { Attribute = { Intensity = "Bold" } }, 'tab_index', wezterm.nerdfonts.ple_right_half_circle_thin, ' ', tab_hostname, ':', pane_title },
        tab_inactive = { { Attribute = { Intensity = "Bold" } }, 'tab_index', wezterm.nerdfonts.ple_right_half_circle_thin, ' ', tab_hostname, ':', pane_title },
        tabline_x = { '' },
        tabline_y = { 'workspace' },
        tabline_z = { 'hostname' },
      },
      --   extensions = {},
    })
  end
}
