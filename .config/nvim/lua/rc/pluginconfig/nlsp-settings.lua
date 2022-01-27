require("nlspsettings").setup({
	config_home = vim.fn.stdpath("config") .. "/nlsp-settings",
	local_settings_root_markers = { ".git" },
	-- append default schemas
	jsonls_append_default_schemas = true,
})
