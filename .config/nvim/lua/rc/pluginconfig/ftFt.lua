vim.g.ftFT_hl_group = "Search" -- will use Search hl group to do the highlitgt

vim.g.ftFT_keymap_keys = { "f", "t", "F" } -- Will create key binding for "f", "t", "F", but not "T"
vim.g.ftFT_keymap_skip_n = 1 -- if set this, will not create key binding for ftFT in normal mode
vim.g.ftFT_keymap_skip_ydc = 1 -- if set this, will not create key binding for [ydc][ftFT] in normal mode
vim.g.ftFT_keymap_skip_v = 1 -- if set this, will not create key binding for ftFT in visual mode

-- ftFT will show another sight line below current line, shows you how many `;` you need to jump there
vim.g.ftFT_sight_disable = 0 -- if set this, will not have sight line
vim.g.ftFT_sight_hl_group = "Search" -- if set htis, will use other hl group for sight line

require("ftFT").setup() -- this will create default keymapping for you

vim.keymap.set("n", "f", "<Cmd>lua require('ftFT').execute('f')<CR>", { noremap = true, silent = true })
vim.keymap.set("n", "t", "<Cmd>lua require('ftFT').execute('t')<CR>", { noremap = true, silent = true })
vim.keymap.set("n", "F", "<Cmd>lua require('ftFT').execute('F')<CR>", { noremap = true, silent = true })
vim.keymap.set("n", "T", "<Cmd>lua require('ftFT').execute('T')<CR>", { noremap = true, silent = true })
