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

require('telescope').setup {
  defaults = {
    vimgrep_arguments = {
      'rg', '--color=never', '--no-heading', '--with-filename', '--line-number', '--column',
      '--smart-case'
    },
    prompt_position = "top",
    prompt_prefix = "> ",
    selection_caret = "> ",
    entry_prefix = "  ",
    initial_mode = "insert",
    selection_strategy = "reset",
    sorting_strategy = "ascending",
    -- layout_strategy = "horizontal",
    -- layout_defaults = {
    --   horizontal = {
    --     mirror = false,
    --   },
    --   vertical = {
    --     mirror = false,
    --   },
    -- },
    layout_defaults = {flex = {flip_columns = 130}},
    -- cannot scroll in preview
    -- layout_strategy = 'flex',
    layout_strategy = 'horizontal',
    file_sorter = require'telescope.sorters'.get_fuzzy_file,
    file_ignore_patterns = {},
    generic_sorter = require'telescope.sorters'.get_generic_fuzzy_sorter,
    shorten_path = true,
    winblend = 0,
    width = 0.75,
    preview_cutoff = 120,
    results_height = 1,
    results_width = 0.8,
    border = {},
    borderchars = {
      {'─', '│', '─', '│', '┌', '┐', '┘', '└'},
      -- prompt = {"─", "│", " ", "│", '┌', '┐', "│", "│"},
      -- results = {"─", "│", "─", "│", "├", "┤", "┘", "└"},
      -- preview = { '─', '│', '─', '│', '┌', '┐', '┘', '└'},
      -- fzf-preview style
      prompt = {"─", "│", " ", "│", '┌', '┬', "│", "│"},
      results = {"─", "│", "─", "│", "├", "┤", "┴", "└"},
      preview = {'─', '│', '─', ' ', '─', '┐', '┘', '─'}
    },
    color_devicons = true,
    use_less = true,
    scroll_strategy = "cycle",
    set_env = {['COLORTERM'] = 'truecolor'}, -- default { }, currently unsupported for shells like cmd.exe / powershell.exe
    -- file_previewer = require'telescope.previewers'.cat.new, -- For buffer previewer use `require'telescope.previewers'.vim_buffer_cat.new`
    -- grep_previewer = require'telescope.previewers'.vimgrep.new, -- For buffer previewer use `require'telescope.previewers'.vim_buffer_vimgrep.new`
    -- qflist_previewer = require'telescope.previewers'.qflist.new, -- For buffer previewer use `require'telescope.previewers'.vim_buffer_qflist.new`

    -- Developer configurations: Not meant for general override
    buffer_previewer_maker = require'telescope.previewers'.buffer_previewer_maker,
    mappings = {
      i = {
        ["<c-x>"] = false,
        ["<c-s>"] = actions.select_horizontal,
        ["<Tab>"] = actions.toggle_selection + actions.move_selection_next,
        ['<C-q>'] = actions.send_selected_to_qflist,
        ["<CR>"] = actions.select_default + actions.center
      }
    }
  },
  extensions = {
    media_files = {
      filetypes = {"png", "webp", "jpg", "jpeg"}, -- filetypes whitelist
      find_cmd = "rg" -- find command
    },
    arecibo = {
      ["selected_engine"] = 'google',
      ["url_open_command"] = 'xdg-open',
      ["show_http_headers"] = false,
      ["show_domain_icons"] = false
    }
  }
}

local function remove_duplicate_paths(tbl, cwd)
  local res = {}
  local hash = {}
  for _, v in ipairs(tbl) do
    local v1 = path.make_relative(v, cwd)
    if (not hash[v1]) then
      res[#res + 1] = v1
      hash[v1] = true
    end
  end
  return res
end

local function filter_by_cwd_paths(tbl, cwd)
  local res = {}
  local hash = {}
  for _, v in ipairs(tbl) do
    local v1 = path.make_relative(v, cwd)
    if v:find(cwd, 1, true) then
      if (not hash[v1]) then
        res[#res + 1] = v1
        hash[v1] = true
      end
    end
  end
  return res
end

local function requiref(module) require(module) end

telescope_builtin.my_mru = function(opts)
  get_mru = function(opts)
    local res = pcall(requiref, 'telescope._extensions.frecency')
    if not (res) then
      return vim.tbl_filter(function(val) return 0 ~= vim.fn.filereadable(val) end, vim.v.oldfiles)
    else
      local db_client = require("telescope._extensions.frecency.db_client")
      db_client.init()
      -- too slow
      -- local tbl = db_client.get_file_scores(opts, vim.fn.getcwd())
      local tbl = db_client.get_file_scores(opts)
      local get_filename_table = function(tbl)
        local res = {}
        for _, v in pairs(tbl) do res[#res + 1] = v["filename"] end
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
  local cmd = {
    "git", "ls-files", "--exclude-standard", "--cached", show_untracked and "--others" or nil,
    recurse_submodules and "--recurse-submodules" or nil
  }
  local results2 = utils.get_os_command_output(cmd)
  for k, v in pairs(results2) do table.insert(results, v) end

  pickers.new(opts, {
    prompt_title = 'MRU',
    finder = finders.new_table {
      -- results = remove_duplicate_paths(results, vim.loop.cwd()),
      results = results,
      entry_maker = opts.entry_maker or make_entry.gen_from_file(opts)
    },
    -- default_text = vim.fn.getcwd(),
    sorter = conf.file_sorter(opts),
    previewer = conf.file_previewer(opts)
  }):find()
end

telescope_builtin.grep_prompt = function(opts)
  opts.search = vim.fn.input("Grep String > ")
  telescope_builtin.my_grep(opts)
end

telescope_builtin.my_grep = function(opts)
  require'telescope.builtin'.grep_string {
    opts = opts,
    prompt_title = "grep_string: " .. opts.search,
    search = opts.search
  }
end

telescope_builtin.my_grep_in_dir = function(opts)
  opts.search = vim.fn.input("Grep String > ")
  opts.search_dirs = {}
  opts.search_dirs[1] = vim.fn.input("Target Directory > ")
  require'telescope.builtin'.grep_string {
    opts = opts,
    prompt_title = "grep_string(dir): " .. opts.search,
    search = opts.search,
    search_dirs = opts.search_dirs
  }
end

telescope_builtin.memo = function(opts)
  require'telescope.builtin'.find_files {
    opts = opts,
    prompt_title = "MemoList",
    find_command = {"find", vim.g.memolist_path, "-type", "f", "-exec", "ls", "-1ta", "{}", "+"}
  }
end

vim.api.nvim_set_keymap('n', '<fuzzy-finder>', '<Nop>', {noremap = true, silent = true})
vim.api.nvim_set_keymap('v', '<fuzzy-finder>', '<Nop>', {noremap = true, silent = true})
vim.api.nvim_set_keymap('n', 'z', '<fuzzy-finder>', {})
vim.api.nvim_set_keymap('v', 'z', '<fuzzy-finder>', {})
vim.api.nvim_set_keymap('n', '<Leader>p', '<Cmd>Telescope my_mru<CR>',
                        {noremap = true, silent = true})
vim.api.nvim_set_keymap('n', '<fuzzy-finder>p', '<Cmd>Telescope find_files<CR>',
                        {noremap = true, silent = true})
vim.api.nvim_set_keymap('n', '<Leader>;', '<Cmd>Telescope git_files<CR>',
                        {noremap = true, silent = true})
vim.api.nvim_set_keymap('n', '<fuzzy-finder>;', '<Cmd>Telescope git_files<CR>',
                        {noremap = true, silent = true})
vim.api.nvim_set_keymap('n', '<Leader>.', '<Cmd>Telescope find_files<CR>',
                        {noremap = true, silent = true})
vim.api.nvim_set_keymap('n', '<fuzzy-finder>.', '<Cmd>Telescope my_mru<CR>',
                        {noremap = true, silent = true})
vim.api.nvim_set_keymap('n', '<Leader>,', '<Cmd>Telescope grep_prompt<CR>',
                        {noremap = true, silent = true})
vim.api.nvim_set_keymap('n', '<fuzzy-finder>,', ':<C-u>Telescope grep_prompt<CR>', {noremap = true})
vim.api.nvim_set_keymap('n', '<fuzzy-finder>>', '<Cmd>Telescope my_grep_in_dir<CR>',
                        {noremap = true, silent = true})
vim.api.nvim_set_keymap('v', '<fuzzy-finder>,',
                        'y:Telescope my_grep search=<C-r>=escape(@", \'\\.*$^[] \')<CR>',
                        {noremap = true})
vim.api.nvim_set_keymap('n', '<Leader>/',
                        ":<C-u>Telescope my_grep search=<C-r>=expand('<cword>')<CR>",
                        {noremap = true})
vim.api.nvim_set_keymap('n', '<fuzzy-finder>/',
                        ":<C-u>Telescope my_grep search=<C-r>=expand('<cword>')<CR>",
                        {noremap = true})
vim.api.nvim_set_keymap('n', '<fuzzy-finder>s', '<Cmd>Telescope live_grep<CR>',
                        {noremap = true, silent = true})
vim.api.nvim_set_keymap('n', '<fuzzy-finder>b', '<Cmd>Telescope buffers<CR>',
                        {noremap = true, silent = true})
vim.api.nvim_set_keymap('n', '<fuzzy-finder>h', '<Cmd>Telescope help_tags<CR>',
                        {noremap = true, silent = true})
vim.api.nvim_set_keymap('n', '<fuzzy-finder>c', '<Cmd>Telescope commands<CR>',
                        {noremap = true, silent = true})
vim.api.nvim_set_keymap('n', '<fuzzy-finder>t', '<Cmd>Telescope treesitter<CR>',
                        {noremap = true, silent = true})
vim.api.nvim_set_keymap('n', '<fuzzy-finder>q', '<Cmd>Telescope quickfix<CR>',
                        {noremap = true, silent = true})
vim.api.nvim_set_keymap('n', '<fuzzy-finder>l', '<Cmd>Telescope loclist<CR>',
                        {noremap = true, silent = true})
vim.api.nvim_set_keymap('n', '<fuzzy-finder>m', '<Cmd>Telescope marks<CR>',
                        {noremap = true, silent = true})
vim.api.nvim_set_keymap('n', '<fuzzy-finder>r', '<Cmd>Telescope registers<CR>',
                        {noremap = true, silent = true})
vim.api.nvim_set_keymap('n', '<fuzzy-finder>*', '<Cmd>Telescope grep_string<CR>',
                        {noremap = true, silent = true})
vim.api.nvim_set_keymap('n', '<fuzzy-finder>f', '<Cmd>Telescope file_browser<CR>',
                        {noremap = true, silent = true})
-- git
vim.api.nvim_set_keymap('n', '<fuzzy-finder>gs',
                        "<Cmd>lua require('telescope.builtin').git_status()<CR>",
                        {noremap = true, silent = true})
vim.api.nvim_set_keymap('n', '<fuzzy-finder>gc',
                        "<Cmd>lua require('telescope.builtin').git_commits()<CR>",
                        {noremap = true, silent = true})
vim.api.nvim_set_keymap('n', '<fuzzy-finder>gC',
                        "<Cmd>lua require('telescope.builtin').git_bcommits()<CR>",
                        {noremap = true, silent = true})
vim.api.nvim_set_keymap('n', '<fuzzy-finder>gb',
                        "<Cmd>lua require('telescope.builtin').git_branches()<CR>",
                        {noremap = true, silent = true})
-- extension
vim.api.nvim_set_keymap('n', '<fuzzy-finder>S',
                        "<Cmd>lua require('telescope').extensions.arecibo.websearch()<CR>",
                        {noremap = true, silent = true})
-- coc
vim.api.nvim_set_keymap('n', '<fuzzy-finder>cd', '<Cmd>Telescope coc diagnostics<CR>',
                        {noremap = true, silent = true})
