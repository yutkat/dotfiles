local actions = require('telescope.actions')
local config = require('telescope.config')
local pickers = require('telescope.pickers')
local finders = require('telescope.finders')
local make_entry = require('telescope.make_entry')
local previewers = require('telescope.previewers')
local utils = require('telescope.utils')
local conf = require('telescope.config').values
local telescope_builtin = require 'telescope.builtin'
local path = require('telescope.path')

require('telescope').setup{
  defaults = {
    vimgrep_arguments = {
      'rg',
      '--color=never',
      '--no-heading',
      '--with-filename',
      '--line-number',
      '--column',
      '--smart-case'
    },
    prompt_position = "bottom",
    prompt_prefix = ">",
    selection_strategy = "reset",
    sorting_strategy = "descending",
    layout_strategy = "horizontal",
    layout_defaults = {
      -- TODO add builtin options.
    },
    file_sorter =  require'telescope.sorters'.get_fuzzy_file,
    file_ignore_patterns = {},
    generic_sorter =  require'telescope.sorters'.get_generic_fuzzy_sorter,
    shorten_path = true,
    winblend = 0,
    width = 0.75,
    preview_cutoff = 120,
    results_height = 1,
    results_width = 0.8,
    border = {},
    borderchars = { '─', '│', '─', '│', '╭', '╮', '╯', '╰'},
    color_devicons = true,
    use_less = true,
    set_env = { ['COLORTERM'] = 'truecolor' }, -- default { }, currently unsupported for shells like cmd.exe / powershell.exe
    file_previewer = require'telescope.previewers'.cat.new, -- For buffer previewer use `require'telescope.previewers'.vim_buffer_cat.new`
    grep_previewer = require'telescope.previewers'.vimgrep.new, -- For buffer previewer use `require'telescope.previewers'.vim_buffer_vimgrep.new`
    qflist_previewer = require'telescope.previewers'.qflist.new, -- For buffer previewer use `require'telescope.previewers'.vim_buffer_qflist.new`

    -- Developer configurations: Not meant for general override
    buffer_previewer_maker = require'telescope.previewers'.buffer_previewer_maker,
    mappings = {
      i = {
        ["<c-x>"] = false,
        ["<c-s>"] = actions.goto_file_selection_split,
        ["<Tab>"] = actions.toggle_selection,
        ['<C-q>'] = actions.send_selected_to_qflist,
      }
    }
  },
  extensions = {
    media_files = {
      filetypes = {"png", "webp", "jpg", "jpeg"}, -- filetypes whitelist
      find_cmd = "rg" -- find command
    }
  }
}

function remove_duplicate_paths(tbl, cwd)
  local res = {}
  local hash = {}
  for _,v in ipairs(tbl) do
    local v1 = path.make_relative(v, cwd)
    if (not hash[v1]) then
      res[#res+1] = v1
      hash[v1] = true
    end
  end
  return res
end

local function requiref(module)
  require(module)
end

telescope_builtin.my_mru = function(opts)
  get_mru = function(opts)
    local res = pcall(requiref, 'telescope._extensions.frecency')
    if not(res) then
      return vim.tbl_filter(function(val)
        return 0 ~= vim.fn.filereadable(val)
      end, vim.v.oldfiles)
    else
      local db_client = require("telescope._extensions.frecency.db_client")
      db_client.init()
      local tbl = db_client.get_file_scores(opts)
      local get_filename_table = function(tbl)
        local res = {}
        for _, v in pairs(tbl) do
          res[#res + 1] = v["filename"]
        end
        return res
      end
      return get_filename_table(tbl)
    end
  end
  local results = get_mru(opts)

  local show_untracked = utils.get_default(opts.show_untracked, true)
  local recurse_submodules = utils.get_default(opts.recurse_submodules, false)
  if show_untracked and recurse_submodules then
    error("Git does not suppurt both --others and --recurse-submodules")
  end
  local cmd = {"git", "ls-files", "--exclude-standard", "--cached", show_untracked and "--others" or nil, recurse_submodules and "--recurse-submodules" or nil}
  local results2 = utils.get_os_command_output(cmd)
  for k,v in pairs(results2) do table.insert(results, v) end

  pickers.new(opts, {
    prompt_title = 'MRU',
    finder = finders.new_table{
      results = remove_duplicate_paths(results, vim.loop.cwd()),
      entry_maker = opts.entry_maker or make_entry.gen_from_file(opts),
    },
    sorter = conf.file_sorter(opts),
    previewer = conf.file_previewer(opts),
  }):find()
end

telescope_builtin.grep_prompt = function(opts)
  opts.search = vim.fn.input("Grep String > ")
  telescope_builtin.my_grep(opts)
end

telescope_builtin.my_grep = function(opts)
  require'telescope.builtin'.grep_string{
    prompt_title = "grep_string: " .. opts.search,
    search = opts.search
  }
end

