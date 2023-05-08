vim.keymap.set({ "n", "x", "o" }, "Ss", function()
	require("leap-ast").leap()
end, {})
