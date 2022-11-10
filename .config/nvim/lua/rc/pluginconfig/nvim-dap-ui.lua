require("dapui").setup({})
vim.api.nvim_set_keymap("n", "[_Debugger]x", '<Cmd>lua require("dapui").toggle()<CR>', { noremap = true, silent = true })
vim.api.nvim_set_keymap("v", "[_Debugger]e", '<Cmd>lua require("dapui").eval()<CR>', { noremap = true, silent = true })
