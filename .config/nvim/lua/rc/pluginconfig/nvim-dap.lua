local dap = require("dap")
-- Rust debugging is handled by rustaceanvim (codelldb). Manual lldb-vscode adapter
-- removed: redundant, and `lldb-vscode` was renamed to `lldb-dap` in modern LLVM.
dap.configurations.lua = {
	{
		type = "nlua",
		request = "attach",
		name = "Attach to running Neovim instance",
	},
}

dap.adapters.nlua = function(callback, config)
	callback({ type = "server", host = config.host or "127.0.0.1", port = config.port or 8086 })
end

vim.fn.sign_define("DapBreakpoint", { text = "🛑", texthl = "", linehl = "", numhl = "" })

vim.api.nvim_set_keymap("n", "<Leader>d", "[_Debugger]", {})
vim.api.nvim_set_keymap(
	"n",
	"[_Debugger]b",
	"<Cmd>lua require'dap'.toggle_breakpoint()<CR>",
	{ noremap = true, silent = true }
)
vim.api.nvim_set_keymap("n", "[_Debugger]c", "<Cmd>lua require'dap'.continue()<CR>", { noremap = true, silent = true })
vim.api.nvim_set_keymap("n", "[_Debugger]n", "<Cmd>lua require'dap'.step_over()<CR>", { noremap = true, silent = true })
vim.api.nvim_set_keymap("n", "[_Debugger]i", "<Cmd>lua require'dap'.step_into()<CR>", { noremap = true, silent = true })
vim.api.nvim_set_keymap("n", "[_Debugger]o", "<Cmd>lua require'dap'.step_out()<CR>", { noremap = true, silent = true })
vim.api.nvim_set_keymap("n", "[_Debugger]R", "<Cmd>lua require'dap'.repl.open()<CR>", { noremap = true, silent = true })
vim.api.nvim_set_keymap(
	"n",
	"[_Debugger]B",
	"<Cmd>lua require'dap'.set_breakpoint(vim.fn.input('Breakpoint condition: '))<CR>",
	{ noremap = true, silent = true }
)
vim.api.nvim_set_keymap(
	"n",
	"[_Debugger]l",
	"<Cmd>lua require'dap'.load_launchjs()<CR>",
	{ noremap = true, silent = true }
)
vim.api.nvim_set_keymap("n", "[_Debugger]g", "<Cmd>lua require'dap'.run_last()<CR>", { noremap = true, silent = true })
-- telescope-dap removed (browse UI dropped during telescope -> snacks migration)
--[[
vim.api.nvim_set_keymap(
	"n",
	"[_Debugger]H",
	"<Cmd>lua require'telescope'.extensions.dap.commands{}<CR>",
	{ noremap = true, silent = true }
)
vim.api.nvim_set_keymap(
	"n",
	"[_Debugger]C",
	"<Cmd>lua require'telescope'.extensions.dap.configurations{}<CR>",
	{ noremap = true, silent = true }
)
vim.api.nvim_set_keymap(
	"n",
	"[_Debugger]P",
	"<Cmd>lua require'telescope'.extensions.dap.list_breakpoints{}<CR>",
	{ noremap = true, silent = true }
)
vim.api.nvim_set_keymap(
	"n",
	"[_Debugger]V",
	"<Cmd>lua require'telescope'.extensions.dap.variables{}<CR>",
	{ noremap = true, silent = true }
)
]]
vim.api.nvim_set_keymap(
	"n",
	"[_Debugger]q",
	"<Cmd>lua require'dap'.disconnect({})<CR>",
	{ noremap = true, silent = true }
)

-- dap.configurations.rust = {
--   {
--     name = "Launch",
--     type = "rust",
--     request = "launch",
--     program = "",
--   },
-- }

-- overseer is set up with dap = false so it does not force-load nvim-dap at
-- startup; enable its preLaunchTask/postDebugTask support now that dap is loaded.
local ok, overseer = pcall(require, "overseer")
if ok then
	overseer.enable_dap()
end
