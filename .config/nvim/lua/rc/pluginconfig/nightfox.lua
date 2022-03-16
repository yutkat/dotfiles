vim.cmd([[ colorscheme nordfox ]])
local nightfox = require("nightfox")
local compile_path = vim.fn.stdpath("cache") .. "/nightfox"

if vim.fn.isdirectory(compile_path) == 0 then
	nightfox.compile()
end
