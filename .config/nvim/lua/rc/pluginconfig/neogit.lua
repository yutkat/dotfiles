local neogit = require('neogit')

neogit.setup {}
vim.api.nvim_set_keymap('n', '<git><Space>', '<Cmd>Neogit<CR>', {noremap = true, silent = true})
