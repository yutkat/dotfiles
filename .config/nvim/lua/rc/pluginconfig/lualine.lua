local lualine = require('lualine')
lualine.status()
lualine.theme = 'gruvbox'

lualine.separator = '|'
lualine.sections = lualine.sections_1
lualine.inactive_sections = lualine.inactive_sections_1
lualine.sections_1 = {
  lualine_a = {'mode'},
  lualine_b = {'branch'},
  lualine_c = {'filename'},
  lualine_x = {'encoding', 'fileformat', 'filetype'},
  lualine_y = {'progress'},
  lualine_z = {'location'}
}
lualine.inactive_sections_1 = {
  lualine_a = {},
  lualine_b = {},
  lualine_c = {'filename'},
  lualine_x = {'location'},
  lualine_y = {},
  lualine_z = {}
}
lualine.extensions = {'fzf'}
lualine.status()

local function hello() return [[hello world]] end

