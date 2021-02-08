require'hop'.jump_words()
vim.api.nvim_set_keymap('n', 'SS', "<cmd>lua require'hop'.jump_words()<cr>", {})
