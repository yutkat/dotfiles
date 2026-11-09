local sessions = require("mini.sessions")
local ignore_filetypes = { "gitcommit", "gitrebase" }
local session_dir = vim.fn.stdpath("state") .. "/sessions"
vim.fn.mkdir(session_dir, "p")

sessions.setup({
	autoread = false,
	autowrite = false,
	directory = session_dir,
	file = "", -- no local Session.vim
	verbose = { read = false, write = false, delete = true },
})

-- One session per working directory
local function current_name()
	return (vim.uv.cwd() or ""):gsub("/", "__") .. ".vim"
end

-- A normal file under cwd that is worth restoring
local function is_restorable(buf)
	local name = vim.api.nvim_buf_get_name(buf)
	local cwd = vim.uv.cwd() or ""
	return vim.bo[buf].buflisted
		and vim.bo[buf].buftype == ""
		and vim.startswith(name, cwd .. "/")
		and vim.fn.filereadable(name) == 1
end

local function save_current()
	if vim.tbl_contains(ignore_filetypes, vim.bo.filetype) then
		return
	end
	if not vim.iter(vim.api.nvim_list_bufs()):any(is_restorable) then
		return
	end
	if vim.fn.argc() > 0 then
		vim.cmd("%argdelete")
	end
	-- Drop special buffers (help, quickfix, plugin panels) so they are not restored as empty windows
	for _, buf in ipairs(vim.api.nvim_list_bufs()) do
		local bt = vim.bo[buf].buftype
		if (bt ~= "" and bt ~= "terminal") or (bt == "" and not vim.bo[buf].buflisted) then
			pcall(vim.api.nvim_buf_delete, buf, { force = true })
		end
	end
	sessions.write(current_name(), { force = true })
end

vim.api.nvim_create_user_command("SessionSaveCurrent", save_current, { desc = "Save the session for cwd" })
vim.api.nvim_create_user_command("SessionLoadCurrent", function()
	if sessions.detected[current_name()] == nil then
		require("snacks").dashboard()
		return
	end
	sessions.read(current_name(), { force = true })
end, { desc = "Load the session for cwd" })

-- Autosave on quit unless the quit command was forced (e.g. :qa!)
vim.api.nvim_create_autocmd("VimLeavePre", {
	group = vim.api.nvim_create_augroup("vimrc_sessions", { clear = true }),
	callback = function()
		local token = vim.fn.histget("c", -1):match("^%S+")
		if token == nil or vim.endswith(token, "!") then
			return
		end
		save_current()
	end,
})
