vim.api.nvim_add_user_command('CommentBoxLeft', 'lua require("comment-box").lbox()', {force = true})
vim.api.nvim_add_user_command('CommentBoxCenter', 'lua require("comment-box").cbox()',
                              {force = true})
