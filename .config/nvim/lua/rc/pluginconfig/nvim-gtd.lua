require("gtd").setup()

vim.keymap.set("n", "gf", function()
	require("gtd").exec({ command = "edit" })
end)
