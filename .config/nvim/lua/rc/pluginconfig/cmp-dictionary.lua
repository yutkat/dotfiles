local dict = require("cmp_dictionary")
dict.setup({
	-- The following are default values.
	exact = 2,
	first_case_insensitive = false,
	document = false,
	document_command = "wn %s -over",
	async = false,
	sqlite = false,
	max_items = -1,
	capacity = 5,
	debug = false,
})

local file = vim.fn.stdpath("data") .. "/../zsh/dictionary/my.dict"
local dic = {}
if vim.fn.filereadable(file) ~= 0 then
	dic = { file }
end

dict.switcher({
	spelllang = {
		en = dic,
	},
})
