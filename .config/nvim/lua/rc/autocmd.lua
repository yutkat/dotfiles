local group_name = "vimrc_vimrc"
vim.api.nvim_create_augroup(group_name, { clear = true })

vim.api.nvim_create_autocmd({ "QuickfixCmdPost" }, {
	group = group_name,
	pattern = { "make", "grep", "grepadd", "vimgrep", "vimgrepadd" },
	callback = function()
		vim.cmd.cwin()
	end,
	once = false,
})
vim.api.nvim_create_autocmd({ "QuickfixCmdPost" }, {
	group = group_name,
	pattern = { "lmake", "lgrep", "lgrepadd", "lvimgrep", "lvimgrepadd" },
	callback = function()
		vim.cmd.lwin()
	end,
	once = false,
})
vim.api.nvim_create_autocmd({ "FileType" }, {
	group = group_name,
	pattern = { "qf" },
	callback = function()
		vim.wo.wrap = true
	end,
	once = false,
})
vim.api.nvim_create_autocmd({ "BufWritePost" }, {
	group = group_name,
	pattern = "*",
	callback = function(args)
		local first_line = vim.api.nvim_buf_get_lines(0, 0, 1, false)[1] or ""
		if first_line:match("^#!.+/bin/.+") then
			vim.fn.setfperm(args.file, "rwxr-xr-x")
		end
	end,
	once = false,
})
vim.api.nvim_create_autocmd({ "CmdwinEnter" }, {
	group = group_name,
	pattern = "*",
	callback = function()
		vim.cmd.startinsert()
	end,
	once = false,
})
-- Check timestamp more for 'autoread'.
vim.api.nvim_create_autocmd({ "WinEnter", "FocusGained" }, {
	group = group_name,
	pattern = "*",
	callback = function()
		if vim.api.nvim_buf_get_name(0) ~= "[Command Line]" then
			vim.cmd.checktime()
		end
	end,
	once = false,
})
vim.api.nvim_create_autocmd({ "TextYankPost" }, {
	group = group_name,
	pattern = "*",
	callback = function()
		vim.hl.on_yank({
			higroup = (vim.fn.hlexists("HighlightedyankRegion") > 0 and "HighlightedyankRegion" or "Visual"),
			timeout = 200,
		})
	end,
	once = false,
})
vim.keymap.set({ "n" }, "gy", function()
	vim.g.keep_cursor_yank = vim.api.nvim_win_get_cursor(0)
	return "y"
end, { noremap = true, silent = true, expr = true })
vim.api.nvim_create_autocmd({ "TextYankPost" }, {
	group = group_name,
	pattern = "*",
	callback = function()
		if vim.v.event.operator == "y" and vim.g.keep_cursor_yank then
			vim.api.nvim_win_set_cursor(0, vim.g.keep_cursor_yank)
			vim.g.keep_cursor_yank = nil
		end
	end,
	once = false,
})
vim.api.nvim_create_autocmd({ "BufWinEnter", "WinEnter" }, {
	group = group_name,
	pattern = "*",
	callback = function()
		if vim.bo.buftype == "prompt" then
			vim.keymap.set("i", "<C-j>", "<Esc><C-w>j", { noremap = true, silent = true, buffer = true })
			vim.keymap.set("i", "<C-k>", "<Esc><C-w>k", { noremap = true, silent = true, buffer = true })
			vim.keymap.set("i", "<C-h>", "<Esc><C-w>h", { noremap = true, silent = true, buffer = true })
			vim.keymap.set("i", "<C-l>", "<Esc><C-w>l", { noremap = true, silent = true, buffer = true })
		end
	end,
	once = false,
})
vim.api.nvim_create_autocmd({ "BufWritePre" }, {
	group = group_name,
	pattern = "*",
	callback = function()
		local function auto_mkdir(dir, force)
			if not dir or string.len(dir) == 0 then
				return
			end
			local stats = vim.uv.fs_stat(dir)
			local is_directory = (stats and stats.type == "directory") or false
			if string.match(dir, "^%w%+://") or is_directory or string.match(dir, "^suda:") then
				return
			end
			if not force then
				vim.fn.inputsave()
				local result = vim.fn.input(string.format('"%s" does not exist. Create? [y/N]', dir), "")
				vim.fn.inputrestore()
				if result:lower() ~= "y" then
					print("Canceled")
					return
				end
			end
			vim.fn.mkdir(dir, "p")
		end

		auto_mkdir(vim.fn.expand("<afile>:p:h"), vim.v.cmdbang)
	end,
	once = false,
})
vim.api.nvim_create_autocmd({ "FileType" }, {
	group = group_name,
	pattern = { "gitcommit" },
	callback = function()
		vim.cmd.startinsert()
	end,
	once = false,
})
-- https://github.com/vim/vim/pull/9531
-- LuaSnip insert mode overwrite register when I pasted
vim.api.nvim_create_autocmd({ "ModeChanged" }, {
	group = group_name,
	pattern = "*",
	callback = function()
		local mode = vim.api.nvim_get_mode().mode
		if mode == "s" then
			local key = vim.api.nvim_replace_termcodes("<C-r>_", true, false, true)
			vim.api.nvim_feedkeys(key, "s", false)
		end
	end,
	once = false,
})
vim.api.nvim_create_autocmd({ "ModeChanged" }, {
	group = group_name,
	pattern = "*:s",
	callback = function()
		vim.o.clipboard = ""
	end,
	once = false,
})
vim.api.nvim_create_autocmd({ "ModeChanged" }, {
	group = group_name,
	pattern = "s:*",
	callback = function()
		if vim.fn.has("clipboard") == 1 then
			vim.o.clipboard = "unnamedplus,unnamed"
		end
	end,
	once = false,
})

-- cd to the project root of the entered file (replaces nvim-rooter.lua)
vim.api.nvim_create_autocmd("BufEnter", {
	group = group_name,
	nested = true,
	callback = function(args)
		if vim.g.SessionLoad == 1 or vim.bo[args.buf].buftype ~= "" then
			return
		end
		local root = vim.fs.root(args.buf, { ".git", ".hg", ".svn" })
		if root and root ~= vim.fn.getcwd() then
			vim.api.nvim_set_current_dir(root)
		end
	end,
})

-- https://www.reddit.com/r/neovim/comments/wlkq0e/neovim_configuration_to_backup_files_with/
-- Add timestamp as extension for backup files
vim.api.nvim_create_autocmd("BufWritePre", {
	group = group_name,
	desc = "Add timestamp to backup extension",
	pattern = "*",
	callback = function()
		vim.opt.backupext = "-" .. os.date("%Y%m%d%H%M")
	end,
})
