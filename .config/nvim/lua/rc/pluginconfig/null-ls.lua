local null_ls = require("null-ls")

local function file_exists(fname)
	local stat = vim.loop.fs_stat(vim.fn.expand(fname))
	return (stat and stat.type) or false
end

local spell_args = { "-" }
if file_exists("./.nvim/ignore_codespell.txt") then
	spell_args = { "--ignore-words=./.nvim/ignore_codespell.txt", "-" }
end

null_ls.setup({
	sources = {
		-- LuaFormatter off
		-- null_ls.builtins.completion.spell,
		null_ls.builtins.formatting.stylua,
		null_ls.builtins.formatting.black,
		-- rust-analyzer
		-- null_ls.builtins.formatting.rustfmt,
		null_ls.builtins.formatting.prettier,
		null_ls.builtins.diagnostics.eslint,
		null_ls.builtins.formatting.shfmt,
		null_ls.builtins.diagnostics.shellcheck,
		null_ls.builtins.diagnostics.codespell.with({
			args = spell_args,
		}),
		-- create
		null_ls.builtins.formatting.markdownlint,
		null_ls.builtins.code_actions.gitsigns,
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
