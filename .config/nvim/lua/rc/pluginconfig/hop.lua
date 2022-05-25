require("hop").setup({})

vim.api.nvim_set_keymap("n", "S", "<cmd>lua require'hop'.hint_words()<CR>", {})
vim.api.nvim_set_keymap("x", "S", "<cmd>lua require'hop'.hint_words()<CR>", {})
