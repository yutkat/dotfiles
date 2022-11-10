require("dapui").setup({})
vim.api.nvim_set_keymap("n", "[Debugger]x", '<Cmd>lua require("dapui").toggle()<CR>', { noremap = true, silent = true })
vim.api.nvim_set_keymap("v", "[Debugger]e", '<Cmd>lua require("dapui").eval()<CR>', { noremap = true, silent = true })
