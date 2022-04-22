require("zk").setup({
	picker = "telescope",

	lsp = {
		config = {
			cmd = { "zk", "lsp" },
			name = "zk",
		},
		auto_attach = {
			enabled = true,
			filetypes = { "markdown" },
		},
	},
})

vim.env.ZK_NOTEBOOK_DIR = os.getenv("HOME") .. "/.local/share/nvim/zk/"

vim.api.nvim_create_user_command("Zknew", function(name)
	if name == "" then
		name = vim.fn.input("filename: ")
	end
	if name == "" then
		return
	end
	vim.fn.execute('ZkNew { title = "' .. name .. '" }')
end, { force = true, nargs = 1 })
