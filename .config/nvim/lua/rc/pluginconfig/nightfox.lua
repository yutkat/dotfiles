local nightfox = require("nightfox")
nightfox.setup({
	options = {
		dim_inactive = true, -- Non focused panes set to alternative background
	},
})
vim.cmd.colorscheme("nordfox")

local compile_path = vim.fn.stdpath("cache") .. "/nightfox"

local stats = vim.uv.fs_stat(compile_path)
local is_directory = (stats and stats.type == "directory") or false
if is_directory then
	nightfox.compile()
end
