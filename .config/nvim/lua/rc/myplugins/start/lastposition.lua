local groupname = "lastposition"
vim.api.nvim_create_augroup(groupname, { clear = true })

vim.api.nvim_create_autocmd({ "BufReadPost" }, {
	group = groupname,
	pattern = "*",
	callback = function()
		if vim.fn.line("'\"") > 0 and vim.fn.line("'\"") <= vim.fn.line("$") then
			vim.cmd.normal({ [[g`"]], bang = true })
		end
	end,
	once = false,
})
