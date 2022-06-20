vim.keymap.set({ "n", "x" }, "p", require("pasta.mappings").p)
vim.keymap.set({ "n", "x" }, "P", require("pasta.mappings").P)

-- This is the default. You can omit `setup` call if you don't want to change this.
require("pasta").setup({
	converters = {
		require("pasta.converters").indentation,
	},
	paste_mode = true,
	next_key = vim.api.nvim_replace_termcodes("<C-p>", true, true, true),
	prev_key = vim.api.nvim_replace_termcodes("<C-n>", true, true, true),
})
