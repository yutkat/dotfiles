local m = require("put_at_end")
vim.keymap.set("i", "<C-g>", m.put_semicolon)
vim.keymap.set("n", ",;", m.put_semicolon)
