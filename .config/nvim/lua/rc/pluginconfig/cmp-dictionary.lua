local file = vim.fn.stdpath("data") .. "/zsh/dictionary/my.dict"
local dic = {}
if vim.fn.filereadable(file) ~= 0 then
	dic = file
end
require("cmp_dictionary").setup({
	dic = { ["*"] = dic },
	-- The following are default values, so you don't need to write them if you don't want to change them
	exact = 2,
	async = false,
	capacity = 5,
	debug = false,
})
