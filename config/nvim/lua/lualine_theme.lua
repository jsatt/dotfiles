local colors = {
    black = '#000000' ,
    near_black = '#141413' ,
    darker_grey = '#242321' ,
    dark_grey = '#45413b' ,
    light_yellow = '#f4cf86' ,
    blue = '#005fff' ,
    light_blue = '#0a9dff' ,
    pink = '#ff9eb8' ,
    yellow = '#fade3e' ,
    green = '#aeee00',
    orange = '#ffa724' ,
    seafoam = '#8cffba' ,
    pale_orange = '#b88853' ,
}

return {
  normal = {
    a = { fg = colors.near_black , bg = colors.green, gui = 'bold' },
    b = { fg = colors.light_yellow, bg = colors.dark_grey },
    c = { fg = colors.seafoam, bg = colors.darker_grey },
  },
  insert = {
    a = { fg = colors.near_black , bg = colors.light_blue, gui = 'bold' },
    b = { fg = colors.light_yellow, bg = colors.blue },
    c = { fg = colors.light_blue, bg = colors.darker_grey },
  },
  visual = {
    a = { fg = colors.near_black , bg = colors.orange, gui = 'bold' },
    b = { fg = colors.black, bg = colors.yellow },
    c = { fg = colors.black, bg = colors.pale_orange },
  },
  replace = {
    a = { fg = colors.near_black , bg = colors.pink, gui = 'bold' },
    b = { fg = colors.light_yellow, bg = colors.blue },
    c = { fg = colors.light_blue, bg = colors.darker_grey },
  },
  inactive = {
    a = { fg = colors.darker_grey, bg = colors.dark_grey, gui = 'bold' },
    b = { fg = colors.darker_grey, bg = colors.dark_grey },
    c = { fg = colors.darker_grey, bg = colors.dark_grey },
  },
}
