require("taskrun").setup()
vim.api.nvim_set_keymap("n", "<make>m", "<Cmd>TaskRunToggle<CR>", { noremap = true, silent = true })
vim.api.nvim_set_keymap("n", "<make>q", "<Cmd>TaskRunToggle<CR>", { noremap = true, silent = true })
vim.api.nvim_set_keymap("n", "<make>r", "<Cmd>TaskRunLast()<CR>", { noremap = true, silent = true })
