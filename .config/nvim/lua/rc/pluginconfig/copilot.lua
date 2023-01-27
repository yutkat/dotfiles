require("copilot").setup({
	suggestion = {
		auto_trigger = true,
		keymap = {
			accept = "<C-S-y>",
			accept_word = false,
			accept_line = false,
			next = "<C-S-n>",
			prev = "<C-S-p>",
			dismiss = "<C-S-]>",
		},
	},
})

vim.keymap.set("i", "<C-S-e>", require("copilot.suggestion").accept, {
	desc = "[copilot] accept suggestion",
	silent = true,
})
