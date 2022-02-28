local groupname = "vimrc_vimrc"
vim.api.nvim_create_augroup({ name = groupname, clear = true })

vim.api.nvim_create_autocmd({
	group = groupname,
	event = { "BufEnter", "FocusGained", "InsertLeave", "WinEnter" },
	pattern = "*",
	callback = function()
		if vim.o.nu and vim.fn.mode() ~= "i" then
			vim.o.rnu = true
		end
	end,
	once = false,
})
vim.api.nvim_create_autocmd({
	group = groupname,
	event = { "BufLeave", "FocusLost", "InsertEnter", "WinLeave" },
	pattern = "*",
	callback = function()
		if vim.o.nu then
			vim.o.rnu = false
		end
	end,
	once = false,
})
vim.api.nvim_create_autocmd({
	group = groupname,
	event = { "QuickfixCmdPost" },
	pattern = { "make", "grep", "grepadd", "vimgrep", "vimgrepadd" },
	callback = function()
		vim.cmd([[cwin]])
	end,
	once = false,
})
vim.api.nvim_create_autocmd({
	group = groupname,
	event = { "QuickfixCmdPost" },
	pattern = { "lmake", "lgrep", "lgrepadd", "lvimgrep", "lvimgrepadd" },
	callback = function()
		vim.cmd([[lwin]])
	end,
	once = false,
})
vim.api.nvim_create_autocmd({
	group = groupname,
	event = { "FileType" },
	pattern = { "qf" },
	callback = function()
		vim.wo.wrap = true
	end,
	once = false,
})
vim.api.nvim_create_autocmd({
	group = groupname,
	event = { "BufWritePost" },
	pattern = "*",
	callback = function()
		if vim.fn.getline(1) == "^#!" then
			if vim.fn.getline(1) == "/bin/" then
				vim.cmd([[chmod a+x <afile>]])
			end
		end
	end,
	once = false,
})
vim.api.nvim_create_autocmd({
	group = groupname,
	event = { "CmdwinEnter" },
	pattern = "*",
	callback = function()
		vim.cmd([[startinsert]])
	end,
	once = false,
})
-- Check timestamp more for 'autoread'.
vim.api.nvim_create_autocmd({
	group = groupname,
	event = { "WinEnter", "FocusGained" },
	pattern = "*",
	callback = function()
		if vim.fn.bufexists("[Command Line]") == 0 then
			vim.cmd([[checktime]])
		end
	end,
	once = false,
})
vim.api.nvim_create_autocmd({
	group = groupname,
	event = { "WinEnter", "FocusGained" },
	pattern = "*",
	callback = function()
		if vim.fn.bufexists("[Command Line]") == 0 then
			vim.cmd([[checktime]])
		end
	end,
	once = false,
})
vim.api.nvim_create_autocmd({
	group = groupname,
	event = { "TextYankPost" },
	pattern = "*",
	callback = function()
		vim.highlight.on_yank({
			higroup = (vim.fn["hlexists"]("HighlightedyankRegion") > 0 and "HighlightedyankRegion" or "Visual"),
			timeout = 200,
		})
	end,
	once = false,
})
vim.api.nvim_create_autocmd({
	group = groupname,
	event = { "BufEnter", "TermOpen", "TermEnter" },
	pattern = "term://*",
	callback = function()
		vim.keymap.set("n", "<CR>", function()
			vim.cmd([[call vimrc#open_file_with_line_col(expand('<cfile>'), expand('<cWORD>'))<CR>]])
		end, { noremap = true, silent = true, buffer = true })
	end,
	once = false,
})
vim.api.nvim_create_autocmd({
	group = groupname,
	event = { "BufWinEnter", "WinEnter" },
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
vim.api.nvim_create_autocmd({
	group = groupname,
	event = { "BufWritePre" },
	pattern = "*",
	callback = function()
		local function auto_mkdir(dir, force)
			print("dir:" .. dir)
			if
				vim.fn.empty(dir) == 1
				or string.match(dir, "^%w%+://")
				or vim.fn.isdirectory(dir) ~= 0
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
				vim.fninputrestore()
			end
			vim.fn.mkdir(dir, "p")
		end
		auto_mkdir(vim.fn.expand("<afile>:p:h"), vim.v.cmdbang)
	end,
	once = false,
})
