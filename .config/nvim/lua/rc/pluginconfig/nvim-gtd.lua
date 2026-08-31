require("gtd").setup()

vim.keymap.set("n", "gd", function()
	require("gtd").exec({ command = "edit" })
end)
