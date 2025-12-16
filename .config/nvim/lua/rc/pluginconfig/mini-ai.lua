require("mini.ai").setup({
	custom_textobjects = {
		e = { { "%b()", "%b[]", "%b{}", '%b""', "%b''", "%b``" }, "^.().*().$" },
	},
})
vim.keymap.set({ "o", "x" }, ";", "ie", { remap = true, desc = "inside any enclosure" })
