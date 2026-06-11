require("tree-sitter-manager").setup({
	parser_dir = vim.fn.stdpath("data") .. "/site/parser",
	query_dir = vim.fn.stdpath("data") .. "/site/queries",
})

-- Update all installed treesitter parsers (used by `plugupdate`). Installs are
-- async (git clone + tree-sitter build), so block until every one finishes
-- before the headless `nvim` quits.
vim.api.nvim_create_user_command("TSUpgrade", function()
	local state = require("tree-sitter-manager.config")
	local util = require("tree-sitter-manager.util")
	local installer = require("tree-sitter-manager.installer")
	local langs = vim.tbl_filter(function(lang)
		return util.is_installed(lang)
	end, state.languages)
	for _, lang in ipairs(langs) do
		installer.remove(lang)
	end
	local remaining = #langs
	for _, lang in ipairs(langs) do
		installer.install(lang, function()
			remaining = remaining - 1
		end)
	end
	if #langs > 0 then
		vim.wait(900000, function()
			return remaining <= 0
		end, 200)
	end
end, { nargs = 0, desc = "Update all installed treesitter parsers" })
