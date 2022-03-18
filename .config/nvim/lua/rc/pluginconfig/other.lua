require("other-nvim").setup({
	mappings = {
		-- builtin mappings
		"livewire",
		"angular",
		"laravel",
		-- custom mapping
		{
			pattern = ".config/nvim/lua/rc/pluginconfig/(.*).lua$",
			target = "../.local/share/nvim/site/pack/packer/*/%1*/README.md",
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
