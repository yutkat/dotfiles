vim.api.nvim_set_keymap('n', '<lsp>r', '<cmd>lua require("renamer").rename()<cr>',
                        {noremap = true, silent = true})
vim.api.nvim_set_keymap('v', '<lsp>r', '<cmd>lua require("renamer").rename()<cr>',
                        {noremap = true, silent = true})
