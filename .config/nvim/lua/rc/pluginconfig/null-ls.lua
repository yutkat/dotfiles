local null_ls = require("null-ls")

local function file_exists(fname)
	local stat = vim.loop.fs_stat(vim.fn.expand(fname))
	return (stat and stat.type) or false
end

-- local spell_args = { "-" }
-- if file_exists("./.nvim/ignore_codespell.txt") then
-- 	spell_args = { "--ignore-words=./.nvim/ignore_codespell.txt", "-" }
-- end
--
local sources = {
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
	null_ls.builtins.diagnostics.editorconfig_checker,
	null_ls.builtins.diagnostics.cspell.with({
		diagnostics_postprocess = function(diagnostic)
			diagnostic.severity = vim.diagnostic.severity["WARN"]
		end,
	}),
	-- null_ls.builtins.diagnostics.codespell.with({
	-- 	args = spell_args,
	-- }),
	-- create
	null_ls.builtins.formatting.markdownlint,
	null_ls.builtins.code_actions.gitsigns,
	-- LuaFormatter on
}

-- ./.nvim/local-null-ls.lua
-- local null_ls = require("null-ls")
-- return {
--   null_ls.builtins.diagnostics.cspell.with({
-- 		diagnostics_postprocess = function(diagnostic)
-- 			diagnostic.severity = vim.diagnostic.severity["WARN"]
-- 		end,
-- 	}),
-- }
if file_exists("./.nvim/local-null-ls.lua") then
	local local_null = dofile("./.nvim/local-null-ls.lua")
	sources = require("rc/utils").merge_lists(sources, local_null)
end

null_ls.setup({
	sources = sources,
	on_attach = function(client)
		if client.server_capabilities.document_formatting then
			vim.api.nvim_create_augroup("LspFormatting", { clear = true })
			vim.api.nvim_create_autocmd({ "BufWritePre" }, {
				group = "LspFormatting",
				buffer = 0,
				callback = function()
					vim.lsp.buf.formatting_sync()
				end,
				once = false,
			})
		end
	end,
})
