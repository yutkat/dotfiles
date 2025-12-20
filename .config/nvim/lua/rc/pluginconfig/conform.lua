-- Format synchronously on save
vim.api.nvim_create_autocmd("BufWritePre", {
	pattern = "*",
	callback = function(args)
		-- Disable autoformat on certain filetypes
		local ignore_filetypes = { "sql", "java" }
		if vim.tbl_contains(ignore_filetypes, vim.bo[args.buf].filetype) then
			return
		end
		-- Disable with a global or buffer-local variable
		if vim.g.disable_autoformat or vim.b[args.buf].disable_autoformat then
			return
		end
		-- Disable autoformat for files in a certain path
		local bufname = vim.api.nvim_buf_get_name(args.buf)
		if bufname:match("/node_modules/") then
			return
		end
		require("conform").format({ timeout_ms = 1000, lsp_fallback = true, bufnr = args.buf })
	end,
})

local mason_reg = require("mason-registry")
local formatters = {
	markdown_toc = {
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
local formatters_by_ft = {
	markdown = { "markdown_toc", "prettier" },
	nix = { "nixfmt" },
	-- lua = { "emmylua-codeformat", lsp_format = "fallback" }
	lua = { lsp_format = "fallback" },
	javascript = { "biome", lsp_format = "fallback" },
	typescript = { "biome", lsp_format = "fallback" },
	python = { "ruff_format", lsp_format = "fallback" },
	rust = { "rustfmt", lsp_format = "fallback" },
}

-- add diff langue vs filetype
local keymap = {
	["c++"] = "cpp",
	["c#"] = "cs",
}

-- add dif conform vs mason
local name_map = {
	["cmakelang"] = "cmake_format",
	["deno"] = "deno_fmt",
	["elm-format"] = "elm_format",
	["gdtoolkit"] = "gdformat",
	["nixpkgs-fmt"] = "nixpkgs_fmt",
	["opa"] = "opa_fmt",
	["php-cs-fixer"] = "php_cs_fixer",
	["ruff"] = "ruff_format",
	["sql-formatter"] = "sql_formatter",
	["xmlformatter"] = "xmlformat",
	["markdown-toc"] = "markdown_toc",
}

for _, pkg in pairs(mason_reg.get_installed_packages()) do
	for _, type in pairs(pkg.spec.categories) do
		if type == "Formatter" then
			local mason_name = pkg.spec.name
			local formatter_name = name_map[mason_name] or mason_name
			local custom_config = formatters[mason_name] or formatters[formatter_name]
			local default_config = require("conform").get_formatter_config(formatter_name)
			if not default_config then
				local bin = next(pkg.spec.bin)
				local prefix = vim.fn.stdpath("data") .. "/mason/bin/"

				local base_config = {
					command = prefix .. bin,
					args = { "$FILENAME" },
					stdin = true,
					require_cwd = false,
				}
				if custom_config then
					formatters[formatter_name] = vim.tbl_extend("force", base_config, custom_config)
				else
					formatters[formatter_name] = base_config
				end
			else
				if custom_config then
					formatters[formatter_name] = vim.tbl_extend("force", default_config, custom_config)
				end
			end

			-- finally add the formatter to it's compatible filetype(s)
			for _, ft in pairs(pkg.spec.languages) do
				local ftl = string.lower(ft)
				local ready = mason_reg.get_package(pkg.spec.name):is_installed()
				if ready then
					if keymap[ftl] ~= nil then
						ftl = keymap[ftl]
					end
					if name_map[pkg.spec.name] ~= nil then
						pkg.spec.name = name_map[pkg.spec.name]
					end
					formatters_by_ft[ftl] = formatters_by_ft[ftl] or {}
					table.insert(formatters_by_ft[ftl], pkg.spec.name)
				end
			end
		end
	end
end

require("conform").setup({
	format_on_save = function(bufnr)
		if vim.g.disable_autoformat or vim.b[bufnr].disable_autoformat then
			return
		end
		-- ...additional logic...
		return { timeout_ms = 1000, lsp_fallback = true }
	end,
	formatters = formatters,
	formatters_by_ft = formatters_by_ft,
})
