require("qf_helper").setup({
	prefer_loclist = false,
	quickfix = {
		default_bindings = false, -- Set up recommended bindings in qf window
	},
	loclist = {               -- The same options, but for the loclist
		default_bindings = false,
	}
})
vim.keymap.set("n", "[_SubLeader]q", "<Cmd>QFToggle!<CR>", { noremap = true, silent = true })
vim.keymap.set("n", "[_SubLeader]l", "<Cmd>LLToggle!<CR>", { noremap = true, silent = true })
