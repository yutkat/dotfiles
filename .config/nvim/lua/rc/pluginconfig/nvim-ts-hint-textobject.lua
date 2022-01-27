vim.api.nvim_set_keymap("o", "m", "<Cmd>lua require('tsht').nodes()<CR>", { noremap = false, silent = false })
vim.api.nvim_set_keymap("x", "m", "<Cmd>lua require('tsht').nodes()<CR>", { noremap = true, silent = false })
