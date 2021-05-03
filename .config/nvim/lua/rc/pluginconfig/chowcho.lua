vim.api.nvim_set_keymap('n', '<Leader>-', ":lua require('chowcho').run()<CR>",
                        {noremap = true, silent = true})
