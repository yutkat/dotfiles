local dial = require("dial")
dial.augends["custom#boolean"] = dial.common.enum_cyclic {
  name = "boolean",
  strlist = {"true", "false"}
}
dial.config.searchlist.normal = {
  "number#decimal#fixed#zero", "number#hex", "number#binary", "date#[%Y/%m/%d]",
  "markup#markdown#header", "custom#boolean"
}

vim.api.nvim_set_keymap('n', '+', '<Plug>(dial-increment)', {silent = true})
vim.api.nvim_set_keymap('n', '_', '<Plug>(dial-decrement)', {silent = true})
vim.api.nvim_set_keymap('v', '+', '<Plug>(dial-increment)', {silent = true})
vim.api.nvim_set_keymap('v', '_', '<Plug>(dial-decrement)', {silent = true})
vim.api.nvim_set_keymap('v', 'g+', '<Plug>(dial-increment-additional)', {silent = true})
vim.api.nvim_set_keymap('v', 'g_', '<Plug>(dial-decrement-additional)', {silent = true})
