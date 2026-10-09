local nightfox = require("nightfox")
nightfox.setup({
	options = {
		dim_inactive = true, -- Non focused panes set to alternative background
	},
})
vim.cmd.colorscheme("nordfox")
