vim.api.nvim_create_user_command("BaleiaColorize", function()
	require("baleia").setup({}).once(vim.fn.bufnr("%"))
end, { force = true })
