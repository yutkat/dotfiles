vim.api.nvim_set_keymap("n", "[Lsp]r", '<cmd>lua require("renamer").rename()<cr>', { noremap = true, silent = true })
vim.api.nvim_set_keymap("v", "[Lsp]r", '<cmd>lua require("renamer").rename()<cr>', { noremap = true, silent = true })
