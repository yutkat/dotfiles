vim.keymap.set({ "n", "x" }, "p", require("pasta.mapping").p)
vim.keymap.set({ "n", "x" }, "P", require("pasta.mapping").P)

require('pasta').config.next_key = vim.keycode('<C-p>')
require('pasta').config.prev_key = vim.keycode('<C-n>')
require('pasta').config.indent_key = vim.keycode(',')
require('pasta').config.indent_fix = true
