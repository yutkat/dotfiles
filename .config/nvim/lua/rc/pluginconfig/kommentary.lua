require('kommentary.config').use_extended_mappings()
require('kommentary.config').configure_language("default", {prefer_single_line_comments = true})

vim.api.nvim_set_keymap("n", "<C-_>", "<Plug>kommentary_line_default", {})
vim.api.nvim_set_keymap("v", "<C-_>", "<Plug>kommentary_visual_default", {})
