require("dapui").setup()
vim.api.nvim_set_keymap('n', '<debugger>q', "<Cmd>lua require'dap'.disconnect({})<CR>",
                        {noremap = true, silent = true})
