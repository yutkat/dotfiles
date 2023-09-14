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
		require("conform").format({ timeout_ms = 500, lsp_fallback = true, bufnr = args.buf })
	end,
})

require("conform").setup({
	format_on_save = function(bufnr)
		if vim.g.disable_autoformat or vim.b[bufnr].disable_autoformat then
			return
		end
		-- ...additional logic...
		return { timeout_ms = 500, lsp_fallback = true }
	end,
	formatters = {
		my_markdown = {
			command = "markdown-toc",
			args = { "-i", "$FILENAME" },
			stdin = false,
			cwd = require("conform.util").root_file({ ".editorconfig", "package.json" }),
		},
	},
	formatters_by_ft = {
		markdown = { "my_markdown" },
	}
})
