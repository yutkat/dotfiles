-- nvim color
vim.env.NVIM_TUI_ENABLE_TRUE_COLOR = 1

vim.o.synmaxcol = 200
-- ColorScheme
vim.defer_fn(function()
	vim.cmd.syntax("enable")
end, 50)
vim.o.background = "dark"

-- true color support
vim.g.colorterm = os.getenv("COLORTERM")
if vim.fn.exists("+termguicolors") == 1 then
	-- vim.o.t_8f = "<Esc>[38;2;%lu;%lu;%lum"
	-- vim.o.t_8b = "<Esc>[48;2;%lu;%lu;%lum"
	vim.o.termguicolors = true
end

vim.o.cmdheight = 0

-- Built-in message/cmdline UI (replaces noice.nvim). Experimental upstream.
-- cmdheight=0 hides the "cmd" target, so route messages to the "msg" float.
if not vim.g.vscode then
	local ok, ui2 = pcall(require, "vim._core.ui2")
	if ok then
		ui2.enable({ msg = { targets = "msg" } })
		vim.api.nvim_create_autocmd("LspProgress", {
			group = vim.api.nvim_create_augroup("rc_lsp_progress", { clear = true }),
			callback = function(ev)
				local value = ev.data.params.value
				vim.api.nvim_echo({ { value.message or "done" } }, false, {
					id = "lsp." .. ev.data.params.token,
					kind = "progress",
					source = "vim.lsp",
					title = value.title,
					status = value.kind ~= "end" and "running" or "success",
					percent = value.percentage,
				})
			end,
		})
	end
end
-- colorscheme pluginconfig -> colorscheme
vim.o.cursorline = false

vim.o.display = "lastline" -- long lines fit on one line
vim.o.showmode = false
vim.o.showmatch = true -- highlight parentheses correspondence
vim.o.matchtime = 1 -- number of milliseconds to find a pair of parentheses
vim.o.showcmd = true -- Show command as typed
vim.o.number = true -- display line number
vim.o.relativenumber = true
vim.o.wrap = true -- wrap by screen width
vim.o.title = true
vim.o.titlestring = "nvim:%t"
vim.o.scrolloff = 5
vim.o.sidescrolloff = 5
vim.o.pumheight = 10 -- number of completion suggestions to display
vim.o.statuscolumn = "%=%{&nu ? v:relnum && mode() != 'i' ? v:relnum : v:lnum : ''} %s%C"
vim.o.signcolumn = "yes"

-- Fold
-- vim.o.foldmethod="marker"
vim.o.foldmethod = "manual"
vim.o.foldlevel = 1
vim.o.foldlevelstart = 99

-- Cursor style
vim.o.guicursor = "n-v-c-sm:block-Cursor/lCursor-blinkon0,i-ci-ve:ver25-Cursor/lCursor,r-cr-o:hor20-Cursor/lCursor"
vim.o.cursorlineopt = "number"

-- vim.o.laststatus = 2
vim.o.laststatus = 3
vim.o.shortmess = "aItToOF"
vim.opt.fillchars = {
	horiz = "━",
	horizup = "┻",
	horizdown = "┳",
	vert = "┃",
	vertleft = "┫",
	vertright = "┣",
	verthoriz = "╋",
}
