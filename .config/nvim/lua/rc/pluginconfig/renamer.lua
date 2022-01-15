vim.api.nvim_set_keymap('n', '<lsp>rn', '<cmd>lua require("renamer").rename()<cr>',
                        {noremap = true, silent = true})
vim.api.nvim_set_keymap('v', '<lsp>rn', '<cmd>lua require("renamer").rename()<cr>',
                        {noremap = true, silent = true})
