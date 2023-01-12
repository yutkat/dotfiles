-- nvim color
vim.env.NVIM_TUI_ENABLE_TRUE_COLOR = 1

vim.o.synmaxcol = 200
-- ColorScheme
vim.cmd([[ syntax enable ]])
vim.o.t_Co = 256
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
vim.o.showmatch = true -- highlight parentheses correspondence
vim.o.matchtime = 1 -- number of milliseconds to find a pair of parentheses
vim.o.showcmd = true -- Show command as typed
vim.o.number = true -- display line number
vim.o.relativenumber = true
vim.o.wrap = true -- wrap by screen width
vim.o.title = false -- don't rewrite title
vim.o.scrolloff = 5
vim.o.sidescrolloff = 5
vim.o.pumheight = 10 -- number of completion suggestions to display
vim.o.statuscolumn = "%=%{&nu ? v:relnum ? v:relnum : v:lnum : ''}%s%C"

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
vim.o.shortmess = "aIToOF"
vim.opt.fillchars = {
	horiz = "━",
	horizup = "┻",
	horizdown = "┳",
	vert = "┃",
	vertleft = "┫",
	vertright = "┣",
	verthoriz = "╋",
}

-- use plugin

-- "vim.o.statusline=%t\ %m%r%h%w[%Y][%{&fenc}][%{&ff}]<%F>%=%c,%l%11p%%
-- "vim.o.statusline=%<[%n]%m%r%h%w%{'['.(&fenc!=''?&fenc:&enc).':'.&ff.']'}%y\ %F%=%l,%c%V%8P
-- " display statusline
-- vim.o.statusline=%< -- position to truncate if line is too long
-- vim.o.statusline+=[%n] -- buffer number
-- vim.o.statusline+=%m -- %m correction flag
-- vim.o.statusline+=%r -- %r read-only flag
-- vim.o.statusline+=%r
-- vim.o.statusline+=%h -- %h help buffer flag
-- vim.o.statusline+=%w -- %w preview window flag
-- vim.o.statusline+=%{'['.(&fenc!=''?&fenc:&enc).':'.&ff.']'} -- Show fenc and ff
-- vim.o.statusline+=%y -- type of file in buffer
-- vim.o.statusline+=\ -- blank space
-- if winwidth(0) >= 130
--   vim.o.statusline+=%F -- full path of file in buffer
-- else
--   vim.o.statusline+=%t -- filename only
-- endif
-- vim.o.statusline+=%= -- separator between left-justified and right-justified items
-- vim.o.statusline+=%{exists('g:loaded_fugitive')?fugitive#statusline():''} -- Git branch name
-- vim.o.statusline+=\ \ -- 2 blank spaces
-- vim.o.statusline+=%1l -- how many lines have cursor
-- vim.o.statusline+=/
-- vim.o.statusline+=%L -- total number of lines in buffer
-- vim.o.statusline+=,
-- vim.o.statusline+=%c -- how many columns the cursor is in
-- vim.o.statusline+=%V -- how many columns the cursor is in on the screen
-- vim.o.statusline+=\ \ -- two blank spaces
-- vim.o.statusline+=%P -- what percent position is the cursor in the file

-- jamessan's
-- vim.o.statusline=   " clear the statusline for when vimrc is reloaded
-- vim.o.statusline+=%-3.3n\                      " buffer number
-- vim.o.statusline+=%f\                          " file name
-- vim.o.statusline+=%h%m%r%w                     " flags
-- vim.o.statusline+=[%{strlen(&ft)?&ft:'none'},  " filetype
-- vim.o.statusline+=%{strlen(&fenc)?&fenc:&enc}, " encoding
-- vim.o.statusline+=%{&fileformat}]              " file format
-- vim.o.statusline+=%=                           " right align
-- vim.o.statusline+=%{synIDattr(synID(line('.'),col('.'),1),'name')}\  " highlight
-- vim.o.statusline+=%b,0x%-8B\                   " current char
-- vim.o.statusline+=%-14.(%l,%c%V%)\ %<%P        " offset
