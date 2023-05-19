vim.keymap.set({ "n", "o", "x" }, ")", "<cmd>lua require('spider').motion('w')<CR>", { desc = "Spider-w" })
vim.keymap.set({ "n", "o", "x" }, "g)", "<cmd>lua require('spider').motion('e')<CR>", { desc = "Spider-e" })
vim.keymap.set({ "n", "o", "x" }, "(", "<cmd>lua require('spider').motion('b')<CR>", { desc = "Spider-b" })
vim.keymap.set({ "n", "o", "x" }, "g(", "<cmd>lua require('spider').motion('ge')<CR>", { desc = "Spider-ge" })
