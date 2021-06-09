vim.api.nvim_set_keymap('n', '<C-x>', '<Cmd>lua require("bufdelete").bufdelete(0, true)<CR>',
                        {noremap = true, silent = true})

