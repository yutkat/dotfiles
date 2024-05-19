require("format").setup({
	-- ["*"] = {
	--   {cmd = {"sed -i 's/[ \t]*$//'"}} -- remove trailing whitespace
	-- },
	-- vim = {
	--   {
	--     cmd = {"luafmt -w replace"},
	--     start_pattern = "^lua << EOF$",
	--     end_pattern = "^EOF$"
	--   }
	-- },
	-- vimwiki = {
	--   {
	--     cmd = {"prettier -w --parser babel"},
	--     start_pattern = "^{{{javascript$",
	--     end_pattern = "^}}}$"
	--   }
	-- },
	lua = { {
		cmd = {
			function(file)
				return string.format("lua-format -i %s", file)
			end,
		}
	} },
	-- go = {
	--   {
	--     cmd = {"gofmt -w", "goimports -w"},
	--     tempfile_postfix = ".tmp"
	--   }
	-- },
	-- javascript = {
	--   {cmd = {"prettier -w", "./node_modules/.bin/eslint --fix"}}
	-- },
	svelte = { { cmd = { "prettier -w", "./node_modules/.bin/eslint --fix" } } },
	toml = { { cmd = { "prettier -w" } } },
	-- markdown = {
	--   {cmd = {"prettier -w"}},
	--   {
	--     cmd = {"black"},
	--     start_pattern = "^```python$",
	--     end_pattern = "^```$",
	--     target = "current"
	--   }
	-- },
	python = { { cmd = { "black" } } },
	sh = { { cmd = { "shfmt -w -i 2 -sr -ci" } } },
})

local format_file_type = {}
for key, _ in pairs(require("format").config) do
	table.insert(format_file_type, key)
end
vim.api.nvim_set_var("format_file_type", format_file_type)

-- do `:e` for CocDiagnostics
vim.api.nvim_exec2(
	[[
augroup vimrc_format
	autocmd!
	autocmd BufWritePost * if index(g:format_file_type, &filetype) != -1 | execute "FormatWrite" | e | endif
augroup END
]],
	{ output = true }
)
