require("trevj").setup()

vim.keymap.set("n", "<Leader>=", function()
	require("trevj").format_at_cursor()
end, { noremap = true, silent = true })
