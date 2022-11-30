local group_name = "vimrc_vimrc"
vim.api.nvim_create_augroup(group_name, { clear = true })

vim.api.nvim_create_autocmd({ "BufEnter", "FocusGained", "InsertLeave", "WinEnter" }, {
	group = group_name,
	pattern = "*",
	callback = function()
		if vim.o.nu and vim.fn.mode() ~= "i" then
			vim.o.rnu = true
		end
	end,
	once = false,
})
vim.api.nvim_create_autocmd({ "BufLeave", "FocusLost", "InsertEnter", "WinLeave" }, {
	group = group_name,
	pattern = "*",
	callback = function()
		if vim.o.nu then
			vim.o.rnu = false
		end
	end,
	once = false,
})
vim.api.nvim_create_autocmd({ "QuickfixCmdPost" }, {
	group = group_name,
	pattern = { "make", "grep", "grepadd", "vimgrep", "vimgrepadd" },
	callback = function()
		vim.cmd([[cwin]])
	end,
	once = false,
})
vim.api.nvim_create_autocmd({ "QuickfixCmdPost" }, {
	group = group_name,
	pattern = { "lmake", "lgrep", "lgrepadd", "lvimgrep", "lvimgrepadd" },
	callback = function()
		vim.cmd([[lwin]])
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
	callback = function()
		if string.match(vim.fn.getline(1), "^#!") then
			if string.match(vim.fn.getline(1), ".+/bin/.+") then
				vim.cmd([[silent !chmod a+x <afile>]])
			end
		end
	end,
	once = false,
})
vim.api.nvim_create_autocmd({ "CmdwinEnter" }, {
	group = group_name,
	pattern = "*",
	callback = function()
		vim.cmd([[startinsert]])
	end,
	once = false,
})
-- Check timestamp more for 'autoread'.
vim.api.nvim_create_autocmd({ "WinEnter", "FocusGained" }, {
	group = group_name,
	pattern = "*",
	callback = function()
		if vim.fn.bufexists("[Command Line]") == 0 then
			vim.cmd([[checktime]])
		end
	end,
	once = false,
})
vim.api.nvim_create_autocmd({ "TextYankPost" }, {
	group = group_name,
	pattern = "*",
	callback = function()
		vim.highlight.on_yank({
			higroup = (vim.fn.hlexists("HighlightedyankRegion") > 0 and "HighlightedyankRegion" or "Visual"),
			timeout = 200,
		})
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
			if
				vim.fn.empty(dir) == 1
				or string.match(dir, "^%w%+://")
				or vim.fn.isdirectory(dir) == 1
				or string.match(dir, "^suda:")
			then
				return
			end
			if not force then
				vim.fn.inputsave()
				local result = vim.fn.input(string.format('"%s" does not exist. Create? [y/N]', dir), "")
				if vim.fn.empty(result) == 1 then
					print("Canceled")
					return
				end
				vim.fn.inputrestore()
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
		vim.cmd([[startinsert]])
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
		-- if vim.fn.mode() == "s" then
		-- 	vim.opt.clipboard:remove({ "unnamedplus", "unnamed" })
		-- else
		-- 	vim.opt.clipboard:append({ "unnamedplus", "unnamed" })
		-- end
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
