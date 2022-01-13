local function is_available_gps()
  local ok, _ = pcall(require, 'nvim-gps')
  if not ok then
    return false
  end
  return require("nvim-gps").is_available()
end

local sections_1 = {
  lualine_a = {'mode'},
  lualine_b = {{'filetype', icon_only = true}, {'filename', path = 1}},
  lualine_c = {{'require("nvim-gps").get_location()', cond = is_available_gps}},
  lualine_x = {'g:coc_status', 'diagnostics'},
  lualine_y = {'branch', 'diff'},
  lualine_z = {'location'}
}

local sections_2 = {
  lualine_a = {'mode'},
  lualine_b = {''},
  lualine_c = {{'filetype', icon_only = true}, {'filename', path = 1}},
  lualine_x = {'encoding', 'fileformat', 'filetype'},
  lualine_y = {'filesize', 'progress'},
  lualine_z = {'location'}
}

function LualineToggle()
  local lualine_require = require('lualine_require')
  local modules = lualine_require.lazy_require({config_module = 'lualine.config'})
  local utils = require('lualine.utils.utils')

  local current_config = modules.config_module.get_config()
  if vim.inspect(current_config.sections) == vim.inspect(sections_1) then
    current_config.sections = utils.deepcopy(sections_2)
  else
    current_config.sections = utils.deepcopy(sections_1)
  end
  require('lualine').setup(current_config)
end

vim.api.nvim_set_keymap('n', '!', '<Cmd>lua LualineToggle()<CR>', {noremap = true, silent = true})

local my_extension = {
  sections = {lualine_b = {'filetype'}},
  filetypes = {'packager', 'vista', 'NvimTree', 'coc-explorer'}
}

require('lualine').setup {
  options = {
    icons_enabled = true,
    theme = 'onedark',
    component_separators = {left = '', right = ''},
    section_separators = {left = '', right = ''},
    disabled_filetypes = {},
    always_divide_middle = true
  },
  sections = sections_1,
  inactive_sections = {
    lualine_a = {'mode'},
    lualine_b = {},
    lualine_c = {'filename'},
    lualine_x = {'location'},
    lualine_y = {},
    lualine_z = {}
  },
  tabline = {},
  extensions = {'quickfix', 'toggleterm', 'symbols-outline', my_extension}
}
