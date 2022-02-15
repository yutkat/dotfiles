local capabilities = require("cmp_nvim_lsp").update_capabilities(vim.lsp.protocol.make_client_capabilities())
local lspconfig = require("lspconfig")

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
	buf_set_keymap("n", "<lsp>wa", "<cmd>lua vim.lsp.buf.add_workspace_folder()<CR>", opts)
	buf_set_keymap("n", "<lsp>wr", "<cmd>lua vim.lsp.buf.remove_workspace_folder()<CR>", opts)
	buf_set_keymap("n", "<lsp>wl", "<cmd>lua print(vim.inspect(vim.lsp.buf.list_workspace_folders()))<CR>", opts)
	buf_set_keymap("n", "<lsp>D", "<cmd>lua vim.lsp.buf.type_definition()<CR>", opts)
	buf_set_keymap("n", "<lsp>rn", "<cmd>lua vim.lsp.buf.rename()<CR>", opts)
	buf_set_keymap("n", "<lsp>ca", "<cmd>lua vim.lsp.buf.code_action()<CR>", opts)
	buf_set_keymap("n", "gr", "<cmd>lua vim.lsp.buf.references()<CR>", opts)
	buf_set_keymap("n", "<lsp>e", "<cmd>lua vim.diagnostic.open_float()<CR>", opts)
	buf_set_keymap("n", "[d", "<cmd>lua vim.diagnostic.goto_prev()<CR>", opts)
	buf_set_keymap("n", "]d", "<cmd>lua vim.diagnostic.goto_next()<CR>", opts)
	buf_set_keymap("n", "<lsp>q", "<cmd>lua vim.diagnostic.setloclist()<CR>", opts)
	buf_set_keymap("n", "<lsp>f", "<cmd>lua vim.lsp.buf.formatting()<CR>", opts)

	require("lsp_signature").on_attach()
	require("illuminate").on_attach(client)
end

-- local util = require('lspconfig.util')
-- local path = util.path
-- local function get_python_path(workspace)
--   -- Use activated virtualenv.
--   if vim.env.VIRTUAL_ENV then
--     return path.join(vim.env.VIRTUAL_ENV, 'bin', 'python')
--   end
--
--   -- Find and use virtualenv in workspace directory.
--   for _, pattern in ipairs({'*', '.*'}) do
--     local match = vim.fn.glob(path.join(workspace, pattern, 'pyvenv.cfg'))
--     if match ~= '' then
--       return path.join(path.dirname(match), 'bin', 'python')
--     end
--     match = vim.fn.glob(path.join(workspace, 'poetry.lock'))
--     if match ~= '' then
--       local venv = vim.fn.trim(vim.fn.system('poetry env info -p'))
--       return path.join(venv, 'bin', 'python')
--     end
--   end
--
--   -- Fallback to system Python.
--   return vim.fn.exepath('python3') or vim.fn.exepath('python') or 'python'
-- end

local server_configs = {
	["sumneko_lua"] = {
		settings = {
			Lua = {
				workspace = {
					-- Make the server aware of Neovim runtime files
					-- library = vim.api.nvim_get_runtime_file("", true),
					preloadFileSize = 500,
					-- very slow
					-- library = vim.api.nvim_get_runtime_file("", true),
				},
				-- Do not send telemetry data containing a randomized but unique identifier
				telemetry = { enable = false },
			},
		},
	},
	-- ["pyright"] = {settings = {python = {pythonPath = "python3"}}}
}

local lsp_installer = require("nvim-lsp-installer")

lsp_installer.on_server_ready(function(server)
	local opts = { capabilities = capabilities, on_attach = on_attach }
	if server_configs[server.name] then
		opts = vim.tbl_deep_extend("force", opts, server_configs[server.name])
	end
	server:setup(opts)
	vim.cmd([[ do User LspAttachBuffers ]])
end)
