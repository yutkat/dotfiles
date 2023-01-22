require("other-nvim").setup({
	mappings = {
		-- builtin mappings
		"livewire",
		"angular",
		"laravel",
		-- custom mapping
		{
			pattern = "src/(.*).ts$",
			target = "test/%1.test.ts",
			-- transformer = "lowercase",
		},
		{
			pattern = "test/(.*).test.ts$",
			target = "src/%1.ts",
			-- transformer = "lowercase",
		},
		{
			pattern = "lua/(.*)/(.*).lua$",
			target = "tests/%2_spec.lua",
			-- transformer = "lowercase",
		},
		{
			pattern = "tests/(.*)_spec.lua$",
			target = "lua/*/%1.lua",
			-- transformer = "lowercase",
		},
		{
			pattern = ".config/nvim/lua/rc/pluginconfig/(.*).lua$",
			target = "../.local/share/nvim/lazy/%1*/README.md",
			-- transformer = "lowercase",
		},
	},
	transformers = {
		-- defining a custom transformer
		lowercase = function(inputString)
			return inputString:lower()
		end,
	},
})

vim.api.nvim_set_keymap("n", "<F6>", "<cmd>:Other<CR>", { noremap = true, silent = true })
vim.api.nvim_set_keymap("n", "<C-S-T>", "<cmd>:Other<CR>", { noremap = true, silent = true })
