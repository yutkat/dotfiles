local formatters = {
	shuck = {
		command = "shuck",
		args = { "format", "--stdin-filename", "$FILENAME", "-" },
		stdin = true,
	},
	markdown_toc = {
		command = "markdown-toc",
		args = { "--bullets", "-", "-i", "$FILENAME" },
		stdin = false,
		cwd = require("conform.util").root_file({ ".editorconfig", "package.json" }),
	},
	["emmylua-codeformat"] = {
		args = { "format", "-f", "$FILENAME", "-d", "-ow" },
		stdin = false,
		cwd = require("conform.util").root_file({ ".editorconfig", "package.json" }),
	},
}

-- Binaries come from mise (see .config/mise/config.toml), resolved via $PATH.
local formatters_by_ft = {
	markdown = { "markdown_toc", "prettier", "markdownlint-cli2" },
	nix = { "nixfmt" },
	zsh = { "shuck" },
	sh = { "shuck" },
	bash = { "shuck" },
	-- lua = { "emmylua-codeformat", lsp_format = "fallback" }
	lua = { "stylua", lsp_format = "fallback" },
	luau = { "stylua" },
	javascript = { "biome", lsp_format = "fallback" },
	typescript = { "biome", lsp_format = "fallback" },
	json = { "biome" },
	yaml = { "prettier" },
	css = { "prettier" },
	scss = { "prettier" },
	less = { "prettier" },
	html = { "prettier" },
	graphql = { "prettier" },
	vue = { "prettier" },
	python = { "ruff_format", lsp_format = "fallback" },
	rust = { "rustfmt", lsp_format = "fallback" },
}

require("conform").setup({
	format_on_save = function(bufnr)
		-- Disable autoformat on certain filetypes
		local ignore_filetypes = { "sql", "java" }
		if vim.tbl_contains(ignore_filetypes, vim.bo[bufnr].filetype) then
			return
		end
		-- Disable with a global or buffer-local variable
		if vim.g.disable_autoformat or vim.b[bufnr].disable_autoformat then
			return
		end
		-- Disable autoformat for files in a certain path
		if vim.api.nvim_buf_get_name(bufnr):match("/node_modules/") then
			return
		end
		return { timeout_ms = 3000, lsp_fallback = true }
	end,
	formatters = formatters,
	formatters_by_ft = formatters_by_ft,
})
