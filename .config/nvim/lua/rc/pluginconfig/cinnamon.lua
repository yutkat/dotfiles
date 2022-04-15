local opts = { noremap = true, silent = true }
local keymap = vim.api.nvim_set_keymap

-- DEFAULT_KEYMAPS:

-- Half-window movements:
keymap("", "<C-u>", "<Cmd>lua Scroll('<C-u>')<CR>", opts)
keymap("i", "<C-u>", "<Cmd>lua Scroll('<C-u>')<CR>", opts)
keymap("", "<C-d>", "<Cmd>lua Scroll('<C-d>')<CR>", opts)
keymap("i", "<C-d>", "<Cmd>lua Scroll('<C-d>')<CR>", opts)

-- Page movements:
keymap("n", "<C-b>", "<Cmd>lua Scroll('<C-b>', 1, 1)<CR>", opts)
keymap("n", "<C-f>", "<Cmd>lua Scroll('<C-f>', 1, 1)<CR>", opts)
keymap("n", "<PageUp>", "<Cmd>lua Scroll('<C-b>', 1, 1)<CR>", opts)
keymap("n", "<PageDown>", "<Cmd>lua Scroll('<C-f>', 1, 1)<CR>", opts)

-- EXTRA_KEYMAPS:

-- Start/end of file and line number movements:
keymap("n", "gg", "<Cmd>lua Scroll('gg', 0, 0, 3)<CR>", opts)
keymap("x", "gg", "<Cmd>lua Scroll('gg', 0, 0, 3)<CR>", opts)
keymap("n", "G", "<Cmd>lua Scroll('G', 0, 1, 3)<CR>", opts)
keymap("x", "G", "<Cmd>lua Scroll('G', 0, 1, 3)<CR>", opts)

-- Paragraph movements:
-- keymap("n", "{", "<Cmd>lua Scroll('{', 0)<dCR>", opts)
-- keymap("x", "{", "<Cmd>lua Scroll('{', 0)<CR>", opts)
-- keymap("n", "}", "<Cmd>lua Scroll('}', 0)<CR>", opts)
-- keymap("x", "}", "<Cmd>lua Scroll('}', 0)<CR>", opts)

-- Previous/next search result:
keymap("n", "n", "<Cmd>lua Scroll('n')<CR>", opts)
keymap("n", "N", "<Cmd>lua Scroll('N')<CR>", opts)
keymap("n", "*", "<Cmd>lua Scroll('*')<CR>", opts)
keymap("n", "#", "<Cmd>lua Scroll('#')<CR>", opts)
keymap("n", "g*", "<Cmd>lua Scroll('g*')<CR>", opts)
keymap("n", "g#", "<Cmd>lua Scroll('g#')<CR>", opts)

-- Previous/next cursor location:
keymap("n", "<C-o>", "<Cmd>lua Scroll('<C-o>')<CR>", opts)
keymap("n", "<C-i>", "<Cmd>lua Scroll('1<C-i>')<CR>", opts)

-- Window scrolling:
-- keymap("n", "zz", "<Cmd>lua Scroll('zz', 0, 1)<CR>", opts)
-- keymap("n", "zt", "<Cmd>lua Scroll('zt', 0, 1)<CR>", opts)
-- keymap("n", "zb", "<Cmd>lua Scroll('zb', 0, 1)<CR>", opts)
-- keymap("n", "z.", "<Cmd>lua Scroll('z.', 0, 1)<CR>", opts)
-- keymap("n", "z<CR>", "<Cmd>lua Scroll('zt^', 0, 1)<CR>", opts)
-- keymap("n", "z-", "<Cmd>lua Scroll('z-', 0, 1)<CR>", opts)
-- keymap("n", "z+", "<Cmd>lua Scroll('z+', 0, 1)<CR>", opts)
-- keymap("n", "z^", "<Cmd>lua Scroll('z^', 0, 1)<CR>", opts)

-- EXTENDED_KEYMAPS:

-- Up/down movements:
keymap("n", "k", "<Cmd>lua Scroll('k', 0, 1, 3, 0)<CR>", opts)
keymap("x", "k", "<Cmd>lua Scroll('k', 0, 1, 3, 0)<CR>", opts)
keymap("n", "j", "<Cmd>lua Scroll('j', 0, 1, 3, 0)<CR>", opts)
keymap("x", "j", "<Cmd>lua Scroll('j', 0, 1, 3, 0)<CR>", opts)
keymap("n", "<Up>", "<Cmd>lua Scroll('k', 0, 1, 3, 0)<CR>", opts)
keymap("x", "<Up>", "<Cmd>lua Scroll('k', 0, 1, 3, 0)<CR>", opts)
keymap("n", "<Down>", "<Cmd>lua Scroll('j', 0, 1, 3, 0)<CR>", opts)
keymap("x", "<Down>", "<Cmd>lua Scroll('j', 0, 1, 3, 0)<CR>", opts)

-- LSP_KEYMAPS:

-- LSP go-to-definition:
keymap("n", "gd", "<Cmd>lua Scroll('definition')<CR>", opts)

-- LSP go-to-declaration:
keymap("n", "gD", "<Cmd>lua Scroll('declaration')<CR>", opts)
