vim.api.nvim_create_autocmd({ "BufNewFile", "BufRead" }, {
	pattern = "*.tmux",
	callback = function()
		vim.bo.filetype = "tmux"
	end,
	once = false,
})
