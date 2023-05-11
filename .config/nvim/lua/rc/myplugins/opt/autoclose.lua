local groupname = "autoclose"
vim.api.nvim_create_augroup(groupname, { clear = true })

vim.api.nvim_create_autocmd({ "BufEnter" }, {
	group = groupname,
	pattern = "*",
	callback = function()
		-- if the window is quickfix go on
		if vim.o.buftype == "quickfix" then
			-- if this window is last on screen quit without warning
			if vim.fn.winbufnr(2) == -1 then
				vim.cmd.quit({ bang = true })
			end
		end
	end,
	once = true,
})
