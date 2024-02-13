-- nvim color
vim.env.NVIM_TUI_ENABLE_TRUE_COLOR = 1

vim.o.synmaxcol = 200
-- ColorScheme
vim.cmd.syntax("enable")
vim.o.background = "dark"

-- true color support
vim.g.colorterm = os.getenv("COLORTERM")
if vim.fn.exists("+termguicolors") == 1 then
	-- vim.o.t_8f = "<Esc>[38;2;%lu;%lu;%lum"
	-- vim.o.t_8b = "<Esc>[48;2;%lu;%lu;%lum"
	vim.o.termguicolors = true
end

vim.o.cmdheight = 0
-- colorscheme pluginconfig -> colorscheme
vim.o.cursorline = false

vim.o.display = "lastline" -- long lines fit on one line
vim.o.showmode = false
vim.o.showmatch = true     -- highlight parentheses correspondence
vim.o.matchtime = 1        -- number of milliseconds to find a pair of parentheses
vim.o.showcmd = true       -- Show command as typed
vim.o.number = true        -- display line number
vim.o.relativenumber = true
vim.o.wrap = true          -- wrap by screen width
vim.o.title = false        -- don't rewrite title
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
vim.w.foldcolumn = "0:"

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
