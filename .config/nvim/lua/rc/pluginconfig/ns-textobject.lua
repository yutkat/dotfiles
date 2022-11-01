local nstextobject = require("ns-textobject")

vim.keymap.set({ "x", "o" }, ";", function()
	-- q means the alias of nvim-surround
	-- a means around or i means inside
	nstextobject.create_textobj(";", "i")
end, { desc = "inside the quote" })
vim.keymap.set({ "n" }, "R", function()
	nstextobject.create_textobj(";", "i")
end, { desc = "inside the quote" })
