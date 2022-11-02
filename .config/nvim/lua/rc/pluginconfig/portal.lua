require("portal").setup()
vim.keymap.set("n", "<leader>o", require("portal").jump_backward, {})
vim.keymap.set("n", "<leader>i", require("portal").jump_forward, {})
vim.keymap.set("n", "<leader>t", require("portal.tag").toggle, {})
