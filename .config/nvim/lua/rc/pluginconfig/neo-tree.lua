-- See ":help neo-tree-highlights" for a list of available highlight groups
vim.cmd([[
        hi link NeoTreeDirectoryName Directory
        hi link NeoTreeDirectoryIcon NeoTreeDirectoryName
      ]])

require("neo-tree").setup({})
vim.keymap.set("n", "gx", "<Cmd>Neotree toggle<CR>", { noremap = true, silent = true })
vim.keymap.set("n", "G,", "<Cmd>Neotree git_status<CR>", { noremap = true, silent = true })
