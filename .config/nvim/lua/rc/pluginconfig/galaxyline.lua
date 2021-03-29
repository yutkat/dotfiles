local gl = require('galaxyline')

local function is_buffer_empty()
  return vim.fn.empty(vim.fn.expand('%:t')) == 1
end

local function has_width_gt(cols)
  return vim.fn.winwidth(0) / 2 > cols
end

local gls = gl.section
gl.short_line_list = {'defx', 'packager', 'vista', 'NvimTree', 'coc-explorer'}

local colors = {
  bg = '#32302f',
  -- bg = '#282c34',
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
local function hasvalue( tbl, str )
    local f = false
    for i = 1, #tbl do
        if type( tbl[i] ) == "table" then
            f = hasvalue( tbl[i], str )
            if f then break end
        elseif tbl[i] == str then
            return true
        end
    end
    return f
end

local inactive_statusline = function()
  return buffer_not_empty() and not hasvalue(gl.short_line_list, vim.bo.filetype)
end

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

local function get_current_file_name_short()
  if hasvalue(gl.short_line_list, vim.bo.filetype) then
    return vim.bo.filetype
  else
    return get_current_file_name()
  end
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
  local has_func, func_name = pcall(vim.api.nvim_buf_get_var,0,'coc_current_function')
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
gls.left = {
  {
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
  },
  {
    FileIcon = {
      provider = {function() return '  ' end, 'FileIcon'},
      condition = buffer_not_empty,
      highlight = {
        require('galaxyline.provider_fileinfo').get_file_icon,
        colors.section_bg
      }
    }
  },
  {
    FileName = {
      provider = get_current_file_name,
      condition = buffer_not_empty,
      highlight = {colors.fg, colors.section_bg},
    }
  },
  {
    CocFunc = {
      provider = CocFunc,
      icon = ' λ',
      highlight = {colors.yellow,colors.section_bg},
    }
  },
  {
    Space = {
      provider = function() return ' ' end,
      highlight = {colors.bg, colors.bg}
    }
  },
  {
    DiagnosticError = {
      provider = 'DiagnosticError',
      icon = '  ',
      highlight = {colors.red1, colors.bg}
    }
  },
  {
    DiagnosticWarn = {
      provider = 'DiagnosticWarn',
      icon = '  ',
      highlight = {colors.orange, colors.bg}
    }
  },
  {
    DiagnosticInfo = {
      provider = 'DiagnosticInfo',
      icon = '  ',
      highlight = {colors.blue, colors.bg},
    }
  },
  {
    DiagnosticHint = {
      provider = 'DiagnosticHint',
      icon = '  ',
      highlight = {colors.grey,colors.bg},
    }
  }
}

-- Mid section
gls.mid = {
  {
    CocStatus = {
      provider = CocStatus,
      highlight = {colors.green, colors.bg},
      icon = '  '
    }
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

local function get_basename(file)
  return file:match("^.+/(.+)$")
end

local GetGitRoot = function()
  local git_dir = require('galaxyline.provider_vcs').get_git_dir()
  if not git_dir then return '' end

  local git_root = git_dir:gsub('/.git/?$','')
  return get_basename(git_root)
end

local GetGitBranch = function()
  local git_branch = require('galaxyline.provider_vcs').get_git_branch()
  if not git_branch then
    return ''
  end
  return string.gsub(git_branch, "%s+", "")
end

-- Right side
local right_1 = {
  {
    DiffAdd = {
      provider = CocDiffAdd,
      condition = checkwidth,
      icon = '+',
      highlight = {colors.green, colors.bg}
    }
  },
  {
    DiffModified = {
      provider = CocDiffModified,
      condition = checkwidth,
      icon = '~',
      highlight = {colors.orange, colors.bg}
    }
  },
  {
    DiffRemove = {
      provider = CocDiffRemove,
      condition = checkwidth,
      icon = '-',
      highlight = {colors.red1, colors.bg}
    }
  },
  {
    Space = {
      provider = function() return ' ' end,
      highlight = {colors.bg, colors.bg}
    }
  },
  {
    GitRoot = {
      provider = {function() return '  ' end, GetGitRoot, function() return ' ' end},
      condition = buffer_not_empty and require('galaxyline.condition').check_git_workspace,
      highlight = {colors.fg, colors.section_bg},
    }
  },
  {
    GitIcon = {
      provider = function() return '   ' end,
      condition = buffer_not_empty and require('galaxyline.condition').check_git_workspace,
      highlight = {colors.fg, colors.line_bg},
    }
  },
  {
    GitBranch = {
      provider = {GetGitBranch, function() return ' ' end},
      condition = buffer_not_empty and require('galaxyline.condition').check_git_workspace,
      highlight = {colors.fg, colors.line_bg},
    }
  },
  {
    LineInfo = {
      provider = {'LineColumn', function() return ' ' end},
      highlight = {colors.gray2, colors.blue},
      separator = ' ',
      separator_highlight = {colors.gray2, colors.blue},
    }
  },
}

local right_2 = {
  {
    FileFormat = {
      provider = {function() return '  ' end, 'FileFormat', function() return ' ' end},
      highlight = {colors.fg, colors.section_bg},
      separator = '',
      separator_highlight = {colors.section_fg, colors.section_bg},
    }
  },
  {
    FileEncode = {
      provider = {'FileEncode', function() return ' ' end},
      highlight = {colors.fg, colors.section_bg},
      separator = '',
      separator_highlight = {colors.section_fg, colors.section_bg},
    }
  },
  {
    BufferType = {
      provider = {'FileTypeName', function() return ' ' end},
      highlight = {colors.fg, colors.section_bg},
      separator = '',
      separator_highlight = {colors.section_fg, colors.section_bg},
    }
  },
  {
    FileSize = {
      provider = {function() return '  ' end, 'FileSize'},
      highlight = {colors.fg, colors.line_bg},
      separator = '',
      separator_highlight = {colors.section_fg, colors.section_bg},
    }
  },
  {
    PerCent = {
      provider = {function() return ' ' end, 'LinePercent'},
      highlight = {colors.gray2, colors.blue},
      separator = '',
      separator_highlight = {colors.gray2, colors.blue},
    }
  }
}

gls.right = right_1

function ToggleGalaxyline()
  gl.disable_galaxyline()
  if gls.right == right_1 then
    gls.right = right_2
  else
    gls.right = right_1
  end
  gl.load_galaxyline()
end

vim.api.nvim_set_keymap('n', '!', ':lua ToggleGalaxyline()<CR>', { noremap = true, silent = true })

-- Short status line
gls.short_line_left = {
  -- {
  --   SBufferType = {
  --     provider = 'FileTypeName',
  --     highlight = {colors.fg, colors.section_bg},
  --     separator = ' ',
  --     separator_highlight = {colors.section_fg, colors.section_bg},
  --   }
  -- },
  {
    SFileIcon = {
      provider = {function() return '  ' end, 'FileIcon'},
      condition = inactive_statusline,
      highlight = {
        require('galaxyline.provider_fileinfo').get_file_icon,
        colors.section_bg
      }
    }
  },
  {
    SFileName = {
      provider = get_current_file_name_short,
      condition = buffer_not_empty,
      highlight = {colors.fg, colors.bg},
    }
  }
}

gls.short_line_right = {
  {
    SBufferIcon = {
      provider= 'BufferIcon',
      highlight = {colors.fg,colors.bg}
    }
  }
  -- {
  --   SGitIcon = {
  --     provider = function() return '  ' end,
  --     condition = buffer_not_empty and
  --     require('galaxyline.condition').check_git_workspace,
  --     highlight = {colors.middlegrey, colors.bg}
  --   }
  -- },
  -- {
  --   SGitBranch = {
  --     provider = 'GitBranch',
  --     condition = buffer_not_empty,
  --     highlight = {colors.middlegrey, colors.bg}
  --   }
  -- }
}

-- Force manual load so that nvim boots with a status line
gl.load_galaxyline()



