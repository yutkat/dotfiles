require("qf_helper").setup()
vim.keymap.set("n", "[SubLeader]q", "<Cmd>QFToggle!<CR>", { noremap = true, silent = true })
vim.keymap.set("n", "[SubLeader]l", "<Cmd>LLToggle!<CR>", { noremap = true, silent = true })
