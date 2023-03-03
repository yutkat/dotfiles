require("portal").setup()
vim.keymap.set("n", "<Leader>o", "<Cmd>Portal jumplist backward<CR>")
vim.keymap.set("n", "<Leader>i", "<Cmd>Portal jumplist forward<CR>")
