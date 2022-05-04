vim.api.nvim_create_autocmd({ "BufNewFile", "BufRead" }, {
	pattern = "*.graphql,*.graphqls,*.gql",
	callback = function()
		vim.bo.filetype = "graphql"
	end,
	once = false,
})
