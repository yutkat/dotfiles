require("null-ls").setup({
	sources = {
		-- LuaFormatter off
		require("null-ls").builtins.formatting.stylua,
		require("null-ls").builtins.diagnostics.eslint,
		require("null-ls").builtins.diagnostics.shellcheck,
		require("null-ls").builtins.completion.spell,
		-- LuaFormatter on
	},
	on_attach = function(client)
		if client.resolved_capabilities.document_formatting then
			vim.cmd([[
			augroup LspFormatting
				autocmd! * <buffer>
				autocmd BufWritePre <buffer> lua vim.lsp.buf.formatting_sync()
			augroup END
]])
		end
	end,
})

local null_ls = require("null-ls")
local api = vim.api

local no_really = {
	method = null_ls.methods.DIAGNOSTICS,
	filetypes = { "markdown", "text" },
	generator = {
		fn = function(params)
			local diagnostics = {}
			-- sources have access to a params object
			-- containing info about the current file and editor state
			for i, line in ipairs(params.content) do
				local col, end_col = line:find("really")
				if col and end_col then
					-- null-ls fills in undefined positions
					-- and converts source diagnostics into the required format
					table.insert(diagnostics, {
						row = i,
						col = col,
						end_col = end_col,
						source = "no-really",
						message = "Don't use 'really!'",
						severity = 2,
					})
				end
			end
			return diagnostics
		end,
	},
}

null_ls.register(no_really)
