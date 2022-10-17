require("mason-lspconfig").setup()

-- Use an on_attach function to only map the following keys
-- after the language server attaches to the current buffer
local on_attach = function(client, bufnr)
	local function buf_set_keymap(...)
		vim.api.nvim_buf_set_keymap(bufnr, ...)
	end

	local function buf_set_option(...)
		vim.api.nvim_buf_set_option(bufnr, ...)
	end

	-- Enable completion triggered by <c-x><c-o>
	buf_set_option("omnifunc", "v:lua.vim.lsp.omnifunc")

	-- Mappings.
	local opts = { noremap = true, silent = true }

	-- See `:help vim.lsp.*` for documentation on any of the below functions
	buf_set_keymap("n", "gD", "<cmd>lua vim.lsp.buf.declaration()<CR>", opts)
	buf_set_keymap("n", "gd", "<cmd>lua vim.lsp.buf.definition()<CR>", opts)
	buf_set_keymap("n", "?", "<cmd>lua vim.lsp.buf.hover()<CR>", opts)
	buf_set_keymap("n", "gi", "<cmd>lua vim.lsp.buf.implementation()<CR>", opts)
	buf_set_keymap("n", "g?", "<cmd>lua vim.lsp.buf.signature_help()<CR>", opts)
	buf_set_keymap("n", "[lsp]wa", "<cmd>lua vim.lsp.buf.add_workspace_folder()<CR>", opts)
	buf_set_keymap("n", "[lsp]wr", "<cmd>lua vim.lsp.buf.remove_workspace_folder()<CR>", opts)
	buf_set_keymap("n", "[lsp]wl", "<cmd>lua print(vim.inspect(vim.lsp.buf.list_workspace_folders()))<CR>", opts)
	buf_set_keymap("n", "[lsp]D", "<cmd>lua vim.lsp.buf.type_definition()<CR>", opts)
	-- buf_set_keymap("n", "[lsp]rn", "<cmd>lua vim.lsp.buf.rename()<CR>", opts)
	buf_set_keymap("n", "[lsp]a", "<cmd>lua vim.lsp.buf.code_action()<CR>", opts)
	buf_set_keymap("n", "gr", "<cmd>lua vim.lsp.buf.references()<CR>", opts)
	buf_set_keymap("n", "[lsp]e", "<cmd>lua vim.diagnostic.open_float()<CR>", opts)
	buf_set_keymap("n", "[d", "<cmd>lua vim.diagnostic.goto_prev()<CR>", opts)
	buf_set_keymap("n", "]d", "<cmd>lua vim.diagnostic.goto_next()<CR>", opts)
	buf_set_keymap("n", "[lsp]q", "<cmd>lua vim.diagnostic.setloclist()<CR>", opts)
	buf_set_keymap("n", "[lsp]f", "<cmd>lua vim.lsp.buf.formatting()<CR>", opts)

	-- require("lsp_signature").on_attach()
	-- require("illuminate").on_attach(client)
	require("nvim-navic").attach(client, bufnr)
end

local lspconfig = require("lspconfig")
local capabilities = vim.lsp.protocol.make_client_capabilities()
capabilities = require("cmp_nvim_lsp").default_capabilities(capabilities)
local opts = { capabilities = capabilities, on_attach = on_attach }

require("mason-lspconfig").setup_handlers({
	function(server_name)
		lspconfig[server_name].setup(opts)
	end,
	["rust_analyzer"] = function()
		local has_rust_tools, rust_tools = pcall(require, "rust-tools")
		if has_rust_tools then
			rust_tools.setup({ server = opts })
		else
			lspconfig.rust_analyzer.setup({})
		end
	end,
	["sumneko_lua"] = function()
		local has_lua_dev, lua_dev = pcall(require, "lua-dev")
		if has_lua_dev then
			local l = lua_dev.setup({
				library = {
					vimruntime = true, -- runtime path
					types = true, -- full signature, docs and completion of vim.api, vim.treesitter, vim.lsp and others
					-- plugins = false, -- installed opt or start plugins in packpath
					-- you can also specify the list of plugins to make available as a workspace library
					-- plugins = { "nvim-treesitter", "plenary.nvim", "telescope.nvim" },
					plugins = { "nvim-treesitter", "plenary.nvim" },
				},
				runtime_path = false,
				lspconfig = opts,
			})
			lspconfig.sumneko_lua.setup(l)
		else
			lspconfig.sumneko_lua.setup({
				settings = {
					Lua = {
						diagnostics = {
							globals = { "vim" },
						},
					},
				},
			})
		end
	end,
})
