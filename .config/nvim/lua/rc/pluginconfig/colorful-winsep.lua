require("colorful-winsep").setup({
	highlight = { fg = vim.api.nvim_get_hl(0, { name = "FloatBorder" })["fg"], bg = "bg" },
})
