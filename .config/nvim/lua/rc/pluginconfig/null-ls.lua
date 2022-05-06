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
	null_ls.builtins.formatting.stylua.with({
		condition = function()
			return vim.fn.executable("stylua") > 0
		end,
	}),
	null_ls.builtins.formatting.black.with({
		condition = function()
			return vim.fn.executable("black") > 0
		end,
	}),
	-- rust-analyzer
	-- null_ls.builtins.formatting.rustfmt,
	null_ls.builtins.formatting.prettier.with({
		condition = function()
			return vim.fn.executable("prettier") > 0
		end,
	}),
	null_ls.builtins.diagnostics.eslint.with({
		condition = function()
			return vim.fn.executable("eslint") > 0
		end,
	}),
	null_ls.builtins.formatting.shfmt.with({
		condition = function()
			return vim.fn.executable("shfmt") > 0
		end,
	}),
	null_ls.builtins.diagnostics.shellcheck.with({
		condition = function()
			return vim.fn.executable("shellcheck") > 0
		end,
	}),
	null_ls.builtins.diagnostics.editorconfig_checker.with({
		condition = function()
			return vim.fn.executable("ec") > 0
		end,
	}),
	null_ls.builtins.diagnostics.cspell.with({
		diagnostics_postprocess = function(diagnostic)
			diagnostic.severity = vim.diagnostic.severity["WARN"]
		end,
		condition = function()
			return vim.fn.executable("cspell") > 0
		end,
	}),
	-- null_ls.builtins.diagnostics.codespell.with({
	-- 	args = spell_args,
	-- }),
	-- create
	null_ls.builtins.formatting.markdownlint.with({
		condition = function()
			return vim.fn.executable("markdownlint") > 0
		end,
	}),
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

local lsp_formatting = function(bufnr)
	vim.lsp.buf.format({
		filter = function(clients)
			-- filter out clients that you don't want to use
			return vim.tbl_filter(function(client)
				return client.name ~= "tsserver"
			end, clients)
		end,
		bufnr = bufnr,
	})
end
local augroup = vim.api.nvim_create_augroup("LspFormatting", { clear = true })
local on_attach = function(client, bufnr)
	if client.supports_method("textDocument/formatting") then
		vim.api.nvim_clear_autocmds({ group = augroup, buffer = bufnr })
		vim.api.nvim_create_autocmd({ "BufWritePre" }, {
			group = augroup,
			buffer = bufnr,
			callback = function()
				lsp_formatting(bufnr)
			end,
			once = false,
		})
	end
end

null_ls.setup({
	sources = sources,
	on_attach = on_attach,
})
