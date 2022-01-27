require("Navigator").setup({ auto_save = "nil", disable_on_zoom = false })

vim.api.nvim_set_keymap("n", "<M-H>", "<CMD>lua require('Navigator').left()<CR>", { noremap = true, silent = true })
vim.api.nvim_set_keymap("n", "<M-K>", "<CMD>lua require('Navigator').up()<CR>", { noremap = true, silent = true })
vim.api.nvim_set_keymap("n", "<M-L>", "<CMD>lua require('Navigator').right()<CR>", { noremap = true, silent = true })
vim.api.nvim_set_keymap("n", "<M-J>", "<CMD>lua require('Navigator').down()<CR>", { noremap = true, silent = true })
