vim.api.nvim_set_keymap('n', 'SS', "<cmd>lua vim.cmd('DisableWhitespace'); require'hop'.jump_words()<cr>", {})
-- FIXME
vim.cmd [[autocmd InsertEnter * EnableWhitespace]]
