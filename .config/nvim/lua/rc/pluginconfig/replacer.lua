vim.api.nvim_create_user_command("QfReplacer", function()
	require("replacer").run()
end, { force = true })
