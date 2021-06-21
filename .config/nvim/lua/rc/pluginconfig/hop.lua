require'hop'.setup {}

vim.api.nvim_set_keymap('n', 'SS',
                        "<cmd>lua vim.cmd('DisableWhitespace'); require'hop'.hint_words()<CR>", {})
vim.api.nvim_set_keymap('x', 'SS',
                        "<cmd>lua vim.cmd('DisableWhitespace'); require'hop'.hint_words()<CR>", {})
-- FIXME
vim.api.nvim_exec([[
augroup vimrc_hop
  autocmd!
  autocmd InsertEnter * EnableWhitespace
augroup END
]], true)
