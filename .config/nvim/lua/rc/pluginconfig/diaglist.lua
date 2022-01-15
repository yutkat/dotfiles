require("diaglist").init({
  -- optional settings
  -- below are defaults
  debug = false,
  -- increase for noisy servers
  debounce_ms = 150
})

vim.keymap.set('n', '<lsp>dw', "<cmd>lua require('diaglist').open_all_diagnostics()<cr>",
               {noremap = true, silent = true})
vim.keymap.set('n', '<lsp>d0', "<cmd>lua require('diaglist').open_buffer_diagnostics()<cr>",
               {noremap = true, silent = true})
