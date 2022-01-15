require("trouble").setup {
  -- your configuration comes here
  -- or leave it empty to use the default settings
  -- refer to the configuration section below
}

vim.api.nvim_set_keymap("n", "<lsp>xx", "<cmd>Trouble<cr>", {silent = true, noremap = true})
vim.api.nvim_set_keymap("n", "<lsp>xw", "<cmd>Trouble workspace_diagnostics<cr>",
                        {silent = true, noremap = true})
vim.api.nvim_set_keymap("n", "<lsp>xd", "<cmd>Trouble document_diagnostics<cr>",
                        {silent = true, noremap = true})
vim.api.nvim_set_keymap("n", "<lsp>xl", "<cmd>Trouble loclist<cr>", {silent = true, noremap = true})
vim.api
    .nvim_set_keymap("n", "<lsp>xq", "<cmd>Trouble quickfix<cr>", {silent = true, noremap = true})
vim.api.nvim_set_keymap("n", "gR", "<cmd>Trouble lsp_references<cr>",
                        {silent = true, noremap = true})
