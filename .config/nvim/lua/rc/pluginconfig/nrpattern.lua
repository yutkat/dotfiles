require("nrpattern").setup()
vim.g.nrpattern_no_mapping = 1

vim.api.nvim_set_keymap("n", "+", "<Plug>(PatternIncrement)", { silent = true })
vim.api.nvim_set_keymap("n", "_", "<Plug>(PatternDecrement)", { silent = true })
vim.api.nvim_set_keymap("v", "+", "<Plug>(PatternRangeIncrement)", { silent = true })
vim.api.nvim_set_keymap("v", "_", "<Plug>(PatternRangeDecrement)", { silent = true })
vim.api.nvim_set_keymap("v", "g+", "<Plug>(PatternMultIncrement)", { silent = true })
vim.api.nvim_set_keymap("v", "g_", "<Plug>(PatternMultDecrement)", { silent = true })
