-- rust-analyzer extensions exposed by rustaceanvim (not reachable through plain LSP).
local function rust_lsp(args)
	return function()
		vim.cmd.RustLsp(args)
	end
end

local function map(lhs, args, desc)
	vim.keymap.set("n", lhs, rust_lsp(args), { buffer = true, silent = true, desc = desc })
end

-- Run / test / debug
map("[_Make]e", "run", "Rust: run target at cursor")
map("[_Make]E", "runnables", "Rust: select runnable")
map("[_Make]t", "testables", "Rust: select test")
map("[_Make]T", { "testables", bang = true }, "Rust: rerun last test")
map("[_Make]d", "debug", "Rust: debug target at cursor")
map("[_Make]D", "debuggables", "Rust: select debuggable")

-- Code insight
map("Q", { "hover", "actions" }, "Rust: hover actions")
map("[_Lsp]m", "expandMacro", "Rust: expand macro")
map("[_Lsp]e", "explainError", "Rust: explain error")
map("[_Lsp]D", "renderDiagnostic", "Rust: render diagnostic")
map("[_Lsp]o", "openDocs", "Rust: open docs.rs")
map("[_Lsp]t", "relatedTests", "Rust: related tests")
