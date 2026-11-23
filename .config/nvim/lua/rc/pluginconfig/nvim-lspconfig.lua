-- Servers are installed by mise (.config/mise/conf.d/neovim.toml) and enabled
-- automatically by mise-lspconfig.nvim.
vim.diagnostic.config({
	signs = {
		text = {
			[vim.diagnostic.severity.ERROR] = "󰅚",
			[vim.diagnostic.severity.WARN] = "󰀪 ",
			[vim.diagnostic.severity.HINT] = "󰌶 ",
			[vim.diagnostic.severity.INFO] = "󰋽 ",
		},
		linehl = {
			[vim.diagnostic.severity.ERROR] = "DiagnosticSignError",
			[vim.diagnostic.severity.WARN] = "DiagnosticSignWarn",
			[vim.diagnostic.severity.HINT] = "DiagnosticSignHint",
			[vim.diagnostic.severity.INFO] = "DiagnosticSignInfo",
		},
		numhl = {
			[vim.diagnostic.severity.ERROR] = "DiagnosticSignError",
			[vim.diagnostic.severity.WARN] = "DiagnosticSignWarn",
			[vim.diagnostic.severity.HINT] = "DiagnosticSignHint",
			[vim.diagnostic.severity.INFO] = "DiagnosticSignInfo",
		},
	},
})

-- Prose filetypes only: in code comments harper flags identifiers and commented-out code.
-- Disabled rules misfire on terse technical notes (identifiers at line starts, config/dir jargon,
-- lowercase tool names that the dictionary cannot override).
vim.lsp.config("harper_ls", {
	filetypes = { "asciidoc", "gitcommit", "jjdescription", "markdown", "tex", "typst" },
	settings = {
		["harper-ls"] = {
			linters = {
				ExpandArgument = false,
				ExpandConfiguration = false,
				ExpandDirectory = false,
				OrthographicConsistency = false,
				PhrasalVerbAsCompoundNoun = false,
				SentenceCapitalization = false,
				UseTitleCase = false,
			},
		},
	},
})

vim.lsp.config("lua_ls", {
	settings = {
		Lua = {
			completion = { callSnippet = "Replace" },
		},
	},
})

-- Extend dprint LSP beyond nvim-lspconfig's defaults so it formats every filetype
-- configured in ~/.config/dprint/dprint.jsonc even outside repos with a local dprint.json.
vim.lsp.config("dprint", {
	cmd_env = {
		DPRINT_EDITOR_USE_GLOBAL_CONFIG = "true",
	},
	settings = {
		dprint = {
			useGlobalConfig = true,
		},
	},
	filetypes = {
		"bash",
		"css",
		"graphql",
		"html",
		"javascript",
		"javascriptreact",
		"json",
		"jsonc",
		"less",
		"lua",
		"luau",
		"markdown",
		"nix",
		"python",
		"rust",
		"scss",
		"sh",
		"typescript",
		"typescriptreact",
		"vue",
		"yaml",
		"zsh",
	},
	root_dir = function(bufnr, on_dir)
		local fname = vim.api.nvim_buf_get_name(bufnr)
		local root = vim.fs.root(bufnr, { "dprint.json", ".dprint.json", "dprint.jsonc", ".dprint.jsonc", ".git" })
		on_dir(root or (fname ~= "" and vim.fs.dirname(fname)) or vim.uv.cwd())
	end,
})
