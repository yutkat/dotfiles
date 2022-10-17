local nstextobject = require("ns-textobject")

vim.keymap.set({ "x", "o" }, ";", function()
  -- q means the alias of nvim-surround
  -- a means around or i means inside
  nstextobject.create_textobj(";", "i")
end, { desc = "around the quote" })
