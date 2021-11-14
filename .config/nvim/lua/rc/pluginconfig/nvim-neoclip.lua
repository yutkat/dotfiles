require('neoclip').setup({
  history = 10000,
  enable_persistant_history = true,
  db_path = vim.fn.stdpath("data") .. "/databases/neoclip.sqlite3",
  filter = nil,
  preview = true,
  default_register = '"',
  content_spec_column = false,
  on_paste = {set_reg = false},
  keys = {
    i = {select = '<cr>', paste = '<c-p>', paste_behind = '<c-k>', custom = {}},
    n = {select = '<cr>', paste = 'mp', paste_behind = 'mP', custom = {}}
  }
})

require('telescope').load_extension('neoclip')
vim.api.nvim_set_keymap('n', '<fuzzy-finder>p', '<Cmd>Telescope neoclip<CR>',
                        {noremap = true, silent = true})
