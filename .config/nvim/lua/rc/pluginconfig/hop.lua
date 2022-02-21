require("hop").setup({})

vim.api.nvim_set_keymap("n", "SS", "<cmd>lua require'hop'.hint_words()<CR>", {})
vim.api.nvim_set_keymap("x", "SS", "<cmd>lua require'hop'.hint_words()<CR>", {})
