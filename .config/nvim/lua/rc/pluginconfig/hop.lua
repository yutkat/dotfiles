vim.api.nvim_set_keymap('n', 'SS', "<cmd>lua vim.cmd('DisableWhitespace'); require'hop'.jump_words()<cr>", {})
-- FIXME
vim.api.nvim_exec([[
augroup vimrc_hop
  autocmd!
  autocmd InsertEnter * EnableWhitespace
augroup END
]], true)
