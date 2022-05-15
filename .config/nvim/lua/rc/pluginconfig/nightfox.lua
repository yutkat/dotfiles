local nightfox = require("nightfox")
nightfox.setup({
	options = {
		dim_inactive = true, -- Non focused panes set to alternative background
	},
})
vim.cmd([[ colorscheme nordfox ]])

local compile_path = vim.fn.stdpath("cache") .. "/nightfox"
if vim.fn.isdirectory(compile_path) == 0 then
	nightfox.compile()
end
