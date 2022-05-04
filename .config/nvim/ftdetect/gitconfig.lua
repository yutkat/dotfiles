vim.api.nvim_create_autocmd({ "BufNewFile", "BufRead" }, {
	pattern = "gitconfig*,.gitconfig*",
	callback = function()
		vim.bo.filetype = "gitconfig"
	end,
	once = false,
})
