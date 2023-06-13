vim.api.nvim_create_user_command("BaleiaColorize", function()
	require("baleia").setup({}).once(vim.api.nvim_get_current_buf())
end, { force = true })
