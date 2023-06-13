local groupname = "lastposition"
vim.api.nvim_create_augroup(groupname, { clear = true })

vim.api.nvim_create_autocmd({ "BufReadPost" }, {
	group = groupname,
	pattern = "*",
	callback = function()
		if vim.fn.line("'\"") > 0 and vim.fn.line("'\"") <= vim.api.nvim_buf_line_count(0) then
			vim.cmd.normal({ [[g`"]], bang = true })
		end
	end,
	once = false,
})
