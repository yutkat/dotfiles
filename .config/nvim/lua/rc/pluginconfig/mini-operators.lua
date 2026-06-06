require("mini.operators").setup({
	replace = {
		prefix = "U",
	},
	exchange = {
		prefix = "gX",
	},
})

-- iswap.nvim replacement: exchange (swap) two regions via the exchange operator.
-- Swap two arguments: `<Leader>s` + `ia` on the first, then `<Leader>s` + `ia` on the second.
vim.keymap.set("n", "<Leader>s", "gX", { remap = true, desc = "Exchange region (swap)" })
vim.keymap.set("x", "<Leader>s", "gX", { remap = true, desc = "Exchange selection (swap)" })
