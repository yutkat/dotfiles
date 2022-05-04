local groupname = "i3config#ft_detect"
vim.api.nvim_create_augroup(groupname, { clear = true })
vim.api.nvim_create_autocmd({ "BufNewFile", "BufRead" }, {
	group = groupname,
	pattern = ".i3.config,i3.config,*.i3config,*.i3.config,*i3/*.config,*i3/*.conf,*i3/config.d/*.conf,*sway/*.config,*sway/*.conf,*sway/config.d/*.conf,*sway/config,*.swayconfig,*.sway.config,sway.config,*sway/config",
	callback = function()
		vim.bo.filetype = "i3config"
	end,
	once = false,
})
