vim.g.mapleader = " "
vim.g.maplocalleader = "\\"

vim.o.shada = "'50,<1000,s100,\"1000,!" -- ! for YankRing
vim.o.shadafile = vim.fn.stdpath("state") .. "/shada/main.shada"
vim.fn.mkdir(vim.fn.fnamemodify(vim.fn.expand(vim.g.viminfofile), ":h"), "p")
-- vim.o.lazyredraw = true  -- OFF because vim-anzu search results may not be visible
vim.o.complete = vim.o.complete .. ",k" -- Add dictionary file to completion
vim.o.completeopt = "menuone,noselect,noinsert"
vim.o.history = 10000
vim.o.timeout = true
vim.o.timeoutlen = 500
vim.o.ttimeoutlen = 10
vim.o.updatetime = 2000
vim.o.jumpoptions = "stack"
vim.o.mouse = ""
vim.o.mousescroll = "ver:0,hor:0"
vim.g.editorconfig_enable = true

-- Tab
-- tabstop is the number of characters to expand the Tab character to on the screen
-- shiftwidth is the width of indent inserted when cindent or autoindent.
-- softtabstop is the amount of whitespace inserted when the Tab key is pressed down. 0 is the same as tabstop, and also affects BS.
vim.o.tabstop = 2
vim.o.shiftwidth = 2
vim.o.softtabstop = 0
-- vim.o.expandtab = true -- Expand tabs to whitespace characters
-- vim.o.autoindent smartindent
vim.o.list = true
vim.o.listchars = "tab:» "

-- Insert
vim.o.backspace = "indent,eol,start"             -- Backspaces to delete anything
vim.o.formatoptions = vim.o.formatoptions .. "m" -- Add formatting options, multi-byte system
-- https://github.com/vim-jp/issues/issues/152 use nofixeol
-- vim.o.binary noeol=true
vim.o.fixendofline = false
-- vim.o.formatoptions=vim.o.formatoptions .. "j" -- Delete comment character when joining commented lines

-- word delimiter setting. setting by vim-polyglot
-- vim.o.iskeyword="48-57,192-255"

-- Command
vim.o.wildmenu = true -- Enhanced command completion
vim.o.wildmode = "longest,list,full"

-- Search
vim.o.wrapscan = true   -- Back to the top after searching to EOF
vim.o.ignorecase = true -- ignore upper and lower case letters
vim.o.smartcase = true  -- If I start with a capital letter, I don't ignore the case.
vim.o.incsearch = true  -- incremental search
vim.o.hlsearch = true   -- Highlight search text

-- Window
vim.o.splitbelow = true
vim.o.splitright = true
vim.o.splitkeep = "cursor"
vim.o.equalalways = false

-- File
-- vim.o.backup=false   -- Never backed up
vim.o.autoread = true  -- Automatically reread if rewritten by others.
vim.o.swapfile = false -- No swap file is created.
vim.o.hidden = true    -- Allow other files to be opened while editing.
vim.o.backup = true
vim.o.backupdir = vim.fn.stdpath("state") .. "/backup/"
vim.fn.mkdir(vim.o.backupdir, "p")
-- vim.o.backupext = string.gsub(vim.o.backupext, "[vimbackup]", "")
vim.o.backupskip = ""
vim.o.directory = vim.fn.stdpath("state") .. "/swap/"
vim.fn.mkdir(vim.o.directory, "p")
vim.o.updatecount = 100
vim.o.undofile = true
vim.o.undodir = vim.fn.stdpath("state") .. "/undo/"
vim.fn.mkdir(vim.o.undodir, "p")
vim.o.modeline = false
-- vim.o.autochdir = true

-- clipboard
-- + reg: Ctrl-v nnamedplus
-- * reg: middle click unnamed
if vim.fn.has("clipboard") == 1 then
	vim.o.clipboard = "unnamedplus,unnamed"
end

-- beep sound
vim.o.errorbells = false
vim.o.visualbell = false

-- tags
vim.opt.tags:remove({ "./tags" })
vim.opt.tags:remove({ "./tags;" })
vim.opt.tags = "./tags," .. vim.go.tags

-- session
vim.o.sessionoptions = "buffers,curdir,tabpages,winsize,globals"

-- quickfix
vim.o.switchbuf = "useopen,uselast"

-- smart indent for long line
-- vim.o.breakindent=true

vim.o.pumblend = 0
vim.o.wildoptions = vim.o.wildoptions .. ",pum"
vim.o.spelllang = "en,cjk"
vim.opt_local.spelloptions:append("noplainbuffer")
vim.o.inccommand = "split"
vim.g.vimsyn_embed = "l"

-- diff
vim.o.diffopt = vim.o.diffopt .. ",vertical,internal,algorithm:patience,iwhite,indent-heuristic"

-- increment
vim.opt.nrformats:append("unsigned")

-- OSC 52
vim.g.clipboard = {
	name = 'OSC 52',
	copy = {
		['+'] = require('vim.ui.clipboard.osc52').copy,
		['*'] = require('vim.ui.clipboard.osc52').copy,
	},
	paste = {
		['+'] = require('vim.ui.clipboard.osc52').paste,
		['*'] = require('vim.ui.clipboard.osc52').paste,
	},
}

vim.diagnostic.config({
	virtual_text = {
		source = true
	},
	float = {
		source = true
	}
})
