require("dapui").setup({})
vim.api.nvim_set_keymap('n', '<debugger>x', '<Cmd>lua require("dapui").toggle()<CR>',
                        {noremap = true, silent = true})
vim.api.nvim_set_keymap('v', '<debugger>e', '<Cmd>lua require("dapui").eval()<CR>',
                        {noremap = true, silent = true})
