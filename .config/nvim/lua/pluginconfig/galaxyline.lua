local gl = require('galaxyline')

local function is_buffer_empty()
  return vim.fn.empty(vim.fn.expand('%:t')) == 1
end

local function has_width_gt(cols)
  return vim.fn.winwidth(0) / 2 > cols
end

local gls = gl.section
gl.short_line_list = {'defx', 'packager', 'vista', 'NvimTree'}

local colors = {
  bg = '#282c34',
  fg = '#aab2bf',
  section_bg = '#38393f',
  blue = '#61afef',
  green = '#98c379',
  purple = '#c678dd',
  orange = '#e5c07b',
  red1 = '#e06c75',
  red2 = '#be5046',
  yellow = '#e5c07b',
  gray1 = '#5c6370',
  gray2 = '#2c323d',
  gray3 = '#3e4452',
  darkgrey = '#5c6370',
  grey = '#848586',
  middlegrey = '#8791A5'
}

-- Local helper functions
local buffer_not_empty = function() return not is_buffer_empty() end

local checkwidth = function()
  return has_width_gt(40) and buffer_not_empty()
end

local mode_color = function()
  local mode_colors = {
    n = colors.green,
    i = colors.blue,
    c = colors.green,
    V = colors.purple,
    [''] = colors.purple,
    v = colors.purple,
    R = colors.red1,
    t = colors.blue
  }

  if mode_colors[vim.fn.mode()] ~= nil then
    return mode_colors[vim.fn.mode()]
  else
    print(vim.fn.mode())
    return colors.purple
  end
end

local function file_readonly()
  if vim.bo.filetype == 'help' then return '' end
  if vim.bo.readonly == true then return '  ' end
  return ''
end

local function get_current_file_name()
  local file = vim.api.nvim_exec([[
    if winwidth(0) < 50
      echo expand('%:t')
    elseif winwidth(0) > 150
      echo expand('%')
    else
      echo pathshorten(expand('%'))
    endif
    ]], true)
  if vim.fn.empty(file) == 1 then return '' end
  if string.len(file_readonly()) ~= 0 then return file .. file_readonly() end
  if vim.bo.modifiable then
    if vim.bo.modified then return file .. '  ' end
  end
  return file .. ' '
end

local function lsp_status(status)
  shorter_stat = ''
  for match in string.gmatch(status, "[^%s]+")  do
    err_warn = string.find(match, "^[WE]%d+", 0)
    if not err_warn then
      shorter_stat = shorter_stat .. ' ' .. match
    end
  end
  return shorter_stat
end

local function get_coc_lsp()
  local status = vim.fn['coc#status']()
  if not status or status == '' then
    return ''
  end
  return lsp_status(status)
end

local function get_diagnostic_info()
  if vim.fn.exists('*coc#rpc#start_server') == 1 then
    return get_coc_lsp()
  end
  return ''
end

local function get_current_func()
  local has_func, func_name = pcall(vim.fn.nvim_buf_get_var,0,'coc_current_function')
  if not has_func then return end
  return func_name
end

local function get_function_info()
  if vim.fn.exists('*coc#rpc#start_server') == 1 then
    return get_current_func()
  end
  return ''
end

CocStatus = get_diagnostic_info
CocFunc = get_current_func


-- Left side
gls.left[1] = {
  ViMode = {
    provider = function()
      local alias = {
        n = 'NORMAL',
        i = 'INSERT',
        c = 'COMMAND',
        v = 'VISUAL',
        V = 'V-LINE',
        [''] = 'VISUAL',
        R = 'REPLACE',
        t = 'TERMINAL',
        s = 'SELECT',
        S = 'S-LINE'
      }
      vim.api.nvim_command('hi GalaxyViMode guibg=' .. mode_color())
      if alias[vim.fn.mode()] ~= nil then
        return '  ' .. alias[vim.fn.mode()] .. ' '
      else
        return '  V-BLOCK '
      end
    end,
    highlight = {colors.bg, colors.bg, 'bold'}
  }
}
gls.left[2] = {
  FileIcon = {
    provider = {function() return '  ' end, 'FileIcon'},
    condition = buffer_not_empty,
    highlight = {
      require('galaxyline.provider_fileinfo').get_file_icon,
      colors.section_bg
    }
  }
}
gls.left[3] = {
  FileName = {
    provider = get_current_file_name,
    condition = buffer_not_empty,
    highlight = {colors.fg, colors.section_bg},
  }
}
gls.left[4] = {
  CocFunc = {
    provider = CocFunc,
    icon = '  λ ',
    highlight = {colors.yellow,colors.section_bg},
  }
}
gls.left[5] = {
  Space = {
    provider = function() return ' ' end,
    highlight = {colors.section_bg, colors.bg}
  }
}
gls.left[9] = {
  DiagnosticError = {
    provider = 'DiagnosticError',
    icon = '  ',
    highlight = {colors.red1, colors.bg}
  }
}
gls.left[10] = {
  Space = {
    provider = function() return ' ' end,
    highlight = {colors.section_bg, colors.bg}
  }
}
gls.left[11] = {
  DiagnosticWarn = {
    provider = 'DiagnosticWarn',
    icon = '  ',
    highlight = {colors.orange, colors.bg}
  }
}
gls.left[12] = {
  Space = {
    provider = function() return ' ' end,
    highlight = {colors.section_bg, colors.bg}
  }
}
gls.left[13] = {
  DiagnosticInfo = {
    provider = 'DiagnosticInfo',
    icon = '  ',
    highlight = {colors.blue, colors.bg},
  }
}
gls.left[14] = {
  Space = {
    provider = function() return ' ' end,
    highlight = {colors.section_bg, colors.bg}
  }
}
gls.left[15] = {
  CocStatus = {
    provider = CocStatus,
    highlight = {colors.green,colors.bg},
    icon = '  🗱'
  }
}

local get_coc_git_status = function()
  if vim.fn.exists('b:coc_git_status') ~= 1 then
    return ''
  end
  return vim.api.nvim_buf_get_var(0, 'coc_git_status')
end

local CocDiffAdd = function()
  local git_status = get_coc_git_status()
  local r = string.match(git_status, "%+(%d+)")
  return r == nil and "" or r
end

local CocDiffModified = function()
  local git_status = get_coc_git_status()
  local r =string.match(git_status, "~(%d+)")
  return r == nil and "" or r
end

local CocDiffRemove = function()
  local git_status = get_coc_git_status()
  local r = string.match(git_status, "%-(%d+)")
  return r == nil and "" or r
end

-- Right side
right_1 = {{
  DiffAdd = {
    provider = CocDiffAdd,
    condition = checkwidth,
    icon = '+',
    highlight = {colors.green, colors.bg}
  }},{
  DiffModified = {
    provider = CocDiffModified,
    condition = checkwidth,
    icon = '~',
    highlight = {colors.orange, colors.bg}
  }},{
  DiffRemove = {
    provider = CocDiffRemove,
    condition = checkwidth,
    icon = '-',
    highlight = {colors.red1, colors.bg}
  }},{
  Space = {
    provider = function() return ' ' end,
    highlight = {colors.fg, colors.bg},
  }},{
  LineInfo = {
    provider = 'LineColumn',
    highlight = {colors.fg, colors.line_bg},
    separator = ' ',
    separator_highlight = {colors.fg, colors.line_bg},
  }},{
  PerCent = {
    provider = 'LinePercent',
    highlight = {colors.gray2, colors.blue},
    separator = ' ',
    separator_highlight = {colors.fg, colors.line_bg},
  }}
}

right_2 = {{
  GitIcon = {
    provider = function() return '  ' end,
    condition = buffer_not_empty and
    require('galaxyline.provider_vcs').check_git_workspace,
    highlight = {colors.middlegrey, colors.bg}
  }},{
  GitBranch = {
    provider = 'GitBranch',
    condition = buffer_not_empty,
    highlight = {colors.middlegrey, colors.bg}
  }},{
  FileFormat = {
    provider = 'FileFormat',
    highlight = {colors.fg, colors.section_bg},
    separator = ' ',
    separator_highlight = {colors.section_fg, colors.section_bg},
  }},{
  FileEncode = {
    provider = 'FileEncode',
    highlight = {colors.fg, colors.section_bg},
    separator = ' ',
    separator_highlight = {colors.section_fg, colors.section_bg},
  }},{
  BufferType = {
    provider = 'FileTypeName',
    highlight = {colors.fg, colors.section_bg},
    separator = ' ',
    separator_highlight = {colors.section_fg, colors.section_bg},
  }}
}

gls.right = right_1

function ToggleGalaxyline()
  if gls.right == right_1 then
    gls.right = right_2
  else
    gls.right = right_1
  end
  gl.load_galaxyline()
end

vim.api.nvim_set_keymap('n', '!', ':lua ToggleGalaxyline()<CR>', { noremap = true, silent = true })

-- Short status line
gls.short_line_left[1] = {
  BufferType = {
    provider = 'FileTypeName',
    highlight = {colors.fg, colors.section_bg},
    separator = ' ',
    separator_highlight = {colors.section_bg, colors.bg}
  }
}

gls.short_line_right[1] = {
  BufferIcon = {
    provider = 'BufferIcon',
    highlight = {colors.yellow, colors.section_bg},
    separator = ' ',
    separator_highlight = {colors.section_bg, colors.bg}
  }
}

-- Force manual load so that nvim boots with a status line
gl.load_galaxyline()
