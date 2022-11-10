vim.api.nvim_set_keymap("n", "[_Lsp]r", '<cmd>lua require("renamer").rename()<cr>', { noremap = true, silent = true })
vim.api.nvim_set_keymap("v", "[_Lsp]r", '<cmd>lua require("renamer").rename()<cr>', { noremap = true, silent = true })
