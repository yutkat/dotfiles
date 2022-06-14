vim.keymap.set("n", "<C-x>", "<Cmd>lua require('bufdelete').bufwipeout(0, true)<CR>", { noremap = true, silent = true })
