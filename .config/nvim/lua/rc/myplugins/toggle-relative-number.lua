vim.api.nvim_create_user_command("ToggleRelativeNumber", function()
	local rel_num = vim.wo.relativenumber

	if rel_num then
		vim.wo.relativenumber = false
	else
		vim.wo.relativenumber = true
	end
	vim.wo.number = true
end, { force = true })
