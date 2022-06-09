require("textcase").setup({
	-- prefix = "cr",
})

local case_loop = {
	"to_camel_case",
	"to_pascal_case",
	"to_snake_case",
	-- "to_dash_case",
	-- "to_dot_case",
}
vim.g.textcase_current = vim.g.textcase_current or case_loop[1]

vim.keymap.set("n", "C", function()
	for index, value in ipairs(case_loop) do
		if value == vim.g.textcase_current then
			require("textcase").current_word(value)
			vim.g.textcase_current = case_loop[(index % #case_loop) + 1]
			return
		end
	end
end, { noremap = true, silent = true })

-- TextCase
-- textcase.api.to_constant_case
-- textcase.api.to_lower_case
-- textcase.api.to_snake_case
-- textcase.api.to_dash_case
-- textcase.api.to_constant_case
-- textcase.api.to_dot_case
-- textcase.api.to_camel_case
-- textcase.api.to_pascal_case
-- textcase.api.to_title_case
-- textcase.api.to_path_case
-- textcase.api.to_phrase_case
