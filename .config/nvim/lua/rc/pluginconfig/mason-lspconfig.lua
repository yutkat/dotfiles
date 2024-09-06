require("mason-lspconfig").setup()

-- Use an on_attach function to only map the following keys
-- after the language server attaches to the current buffer
-- selene: allow(unused_variable)
---@diagnostic disable-next-line: unused-local
local on_attach = function(client, bufnr)
	-- Enable completion triggered by <c-x><c-o>
	vim.api.nvim_set_option_value("omnifunc", "v:lua.vim.lsp.omnifunc", { buf = bufnr })

	-- Mappings.
	local opts = { noremap = true, silent = true, buffer = bufnr }
	-- See `:help vim.lsp.*` for documentation on any of the below functions
	vim.keymap.set("n", "gD", "<cmd>lua vim.lsp.buf.declaration()<CR>", opts)
	vim.keymap.set("n", "gd", "<cmd>lua vim.lsp.buf.definition()<CR>", opts)
	vim.keymap.set("n", "?", "<cmd>lua vim.lsp.buf.hover()<CR>", opts)
	vim.keymap.set("n", "gi", "<cmd>lua vim.lsp.buf.implementation()<CR>", opts)
	vim.keymap.set("n", "g?", "<cmd>lua vim.lsp.buf.signature_help()<CR>", opts)
	vim.keymap.set("n", "[_Lsp]wa", "<cmd>lua vim.lsp.buf.add_workspace_folder()<CR>", opts)
	vim.keymap.set("n", "[_Lsp]wr", "<cmd>lua vim.lsp.buf.remove_workspace_folder()<CR>", opts)
	vim.keymap.set("n", "[_Lsp]wl", "<cmd>lua print(vim.inspect(vim.lsp.buf.list_workspace_folders()))<CR>", opts)
	vim.keymap.set("n", "[_Lsp]D", "<cmd>lua vim.lsp.buf.type_definition()<CR>", opts)
	-- vim.keymap.set("n", "[_Lsp]rn", "<cmd>lua vim.lsp.buf.rename()<CR>", opts)
	vim.keymap.set("n", "[_Lsp]a", "<cmd>lua vim.lsp.buf.code_action()<CR>", opts)
	vim.keymap.set("n", "gr", "<cmd>lua vim.lsp.buf.references()<CR>", opts)
	vim.keymap.set("n", "[_Lsp]e", "<cmd>lua vim.diagnostic.open_float()<CR>", opts)
	vim.keymap.set("n", "[d", "<cmd>lua vim.diagnostic.goto_prev()<CR>", opts)
	vim.keymap.set("n", "]d", "<cmd>lua vim.diagnostic.goto_next()<CR>", opts)
	vim.keymap.set("n", "[_Lsp]q", "<cmd>lua vim.diagnostic.setloclist()<CR>", opts)
	vim.keymap.set("n", "[_Lsp]f", "<cmd>lua vim.lsp.buf.formatting()<CR>", opts)

	-- require("lsp_signature").on_attach()
	-- require("illuminate").on_attach(client)
	-- require("nvim-navic").attach(client, bufnr)
end

local group_name = "vimrc_mason_lspconfig"
vim.api.nvim_create_augroup(group_name, { clear = true })

vim.api.nvim_create_autocmd("LspAttach", {
	callback = function(args)
		local bufnr = args.buf
		local client = vim.lsp.get_client_by_id(args.data.client_id)
		if client.supports_method("textDocument/inlayHint") then
			vim.lsp.inlay_hint.enable(true, { bufnr = bufnr })

			-- vim.api.nvim_create_autocmd("InsertEnter", {
			-- 	buffer = bufnr,
			-- 	callback = function()
			-- 		vim.lsp.buf.inlay_hint(bufnr, true)
			-- 	end,
			-- 	group = group_name,
			-- })
			-- vim.api.nvim_create_autocmd("InsertLeave", {
			-- 	buffer = bufnr,
			-- 	callback = function()
			-- 		vim.lsp.buf.inlay_hint(bufnr, false)
			-- 	end,
			-- 	group = group_name,
			-- })
		end
	end,
	group = group_name,
})

local lspconfig = require("lspconfig")
local capabilities = vim.tbl_deep_extend("force",
	vim.lsp.protocol.make_client_capabilities(),
	require('cmp_nvim_lsp').default_capabilities()
)
require("mason-lspconfig").setup_handlers({
	function(server_name)
		if server_name == "tsserver" then
			server_name = "ts_ls"
		end

		if server_name == "rust_analyzer" then
			local has_rust_tools, rust_tools = pcall(require, "rust-tools")
			if has_rust_tools then
				rust_tools.setup({ server = { capabilities = capabilities, on_attach = on_attach } })
			else
				lspconfig.rust_analyzer.setup({ capabilities = capabilities, on_attach = on_attach })
			end
		elseif server_name == "lua_ls" then
			lspconfig.lua_ls.setup({
				capabilities = capabilities,
				on_attach = on_attach,
				settings = {
					Lua = {
						diagnostics = {
							globals = { "vim" },
						},
						hint = { enable = true },
						format = {
							enable = true,
							defaultConfig = {
								indent_style = "tab",
								indent_size = "2",
							}
						},
					},
				},
			})
		else
			lspconfig[server_name].setup({ capabilities = capabilities, on_attach = on_attach })
		end
	end,
})
