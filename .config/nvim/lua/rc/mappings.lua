---------------------------------------------------------------------------------------------------+
-- Commands \ Modes | Normal | Insert | Command | Visual | Select | Operator | Terminal | Lang-Arg |
-- ================================================================================================+
-- map  / noremap   |    @   |   -    |    -    |   @    |   @    |    @     |    -     |    -     |
-- nmap / nnoremap  |    @   |   -    |    -    |   -    |   -    |    -     |    -     |    -     |
-- map! / noremap!  |    -   |   @    |    @    |   -    |   -    |    -     |    -     |    -     |
-- imap / inoremap  |    -   |   @    |    -    |   -    |   -    |    -     |    -     |    -     |
-- cmap / cnoremap  |    -   |   -    |    @    |   -    |   -    |    -     |    -     |    -     |
-- vmap / vnoremap  |    -   |   -    |    -    |   @    |   @    |    -     |    -     |    -     |
-- xmap / xnoremap  |    -   |   -    |    -    |   @    |   -    |    -     |    -     |    -     |
-- smap / snoremap  |    -   |   -    |    -    |   -    |   @    |    -     |    -     |    -     |
-- omap / onoremap  |    -   |   -    |    -    |   -    |   -    |    @     |    -     |    -     |
-- tmap / tnoremap  |    -   |   -    |    -    |   -    |   -    |    -     |    @     |    -     |
-- lmap / lnoremap  |    -   |   @    |    @    |   -    |   -    |    -     |    -     |    @     |
---------------------------------------------------------------------------------------------------+
-- custom leader
vim.keymap.set({ "n", "x" }, "[_SubLeader]", "<Nop>", { noremap = true, silent = true })
vim.api.nvim_set_keymap("n", ",", "[_SubLeader]", {})
vim.api.nvim_set_keymap("x", ",", "[_SubLeader]", {})
-- [_Lsp]
vim.keymap.set("n", ";", "<Nop>", { noremap = true, silent = true })
vim.api.nvim_set_keymap("n", ";", "[_Lsp]", {})
-- [_Ts]
vim.api.nvim_set_keymap("n", "'", "[_Ts]", {})
vim.keymap.set("n", "M", "<Nop>", { noremap = true, silent = true })
vim.keymap.set("n", "?", "<Nop>", { noremap = true, silent = true })
vim.keymap.set("n", "<C-s>", "<Nop>", { noremap = true, silent = true })
-- sandwich & <spector>
vim.keymap.set({ "n", "x" }, "s", "<Nop>", { noremap = true, silent = true })
vim.keymap.set({ "n", "x" }, "S", "<Nop>", { noremap = true, silent = true })
-- [_Make]
vim.keymap.set("n", "m", "<Nop>", { noremap = true, silent = true })
vim.api.nvim_set_keymap("n", "m", "[_Make]", {})
-- [_FuzzyFinder]
vim.keymap.set({ "n", "x" }, "z", "<Nop>", { noremap = true, silent = true })
vim.api.nvim_set_keymap("n", "[_FuzzyFinder]", "<Nop>", { noremap = true, silent = true })
vim.api.nvim_set_keymap("v", "[_FuzzyFinder]", "<Nop>", { noremap = true, silent = true })
vim.api.nvim_set_keymap("n", "z", "[_FuzzyFinder]", {})
vim.api.nvim_set_keymap("v", "z", "[_FuzzyFinder]", {})
vim.keymap.set("n", "Z", "<Nop>", { noremap = true, silent = true })
-- switch buffer
vim.keymap.set("n", "H", "<Nop>", { noremap = true, silent = true })
vim.keymap.set("n", "L", "<Nop>", { noremap = true, silent = true })
-- columnmove. use gJ
vim.keymap.set("n", "J", "<Nop>", { noremap = true, silent = true })
vim.keymap.set("n", "K", "<Nop>", { noremap = true, silent = true })
-- clever-f
vim.keymap.set("n", "t", "<Nop>", { noremap = true, silent = true })
vim.keymap.set("n", "T", "<Nop>", { noremap = true, silent = true })
-- git, use :10 or gG or GG
vim.keymap.set("n", "G", "<Nop>", { noremap = true, silent = true })
vim.api.nvim_set_keymap("n", "G", "[_Git]", {})
-- not use, use RR
vim.keymap.set("n", "R", "<Nop>", { noremap = true, silent = true })
-- close
vim.keymap.set("n", "X", "<Nop>", { noremap = true, silent = true })
-- operator-replace
vim.keymap.set("n", "U", "<Nop>", { noremap = true, silent = true })
-- use 0, toggle statusline
vim.keymap.set("n", "!", "<Nop>", { noremap = true, silent = true })
-- barbar
vim.keymap.set("n", "@", "<Nop>", { noremap = true, silent = true })
vim.keymap.set("n", "#", "<Nop>", { noremap = true, silent = true })
-- g; g,
vim.keymap.set("n", "^", "<Nop>", { noremap = true, silent = true })
vim.keymap.set("n", "&", "<Nop>", { noremap = true, silent = true })
-- not use
vim.keymap.set("n", "(", "<Nop>", { noremap = true, silent = true })
vim.keymap.set("n", ")", "<Nop>", { noremap = true, silent = true })
-- <C-x>
vim.keymap.set("n", "_", "<Nop>", { noremap = true, silent = true })
-- milfeulle
vim.keymap.set("n", "<C-a>", "<Nop>", { noremap = true, silent = true })
vim.keymap.set("n", "<C-g>", "<Nop>", { noremap = true, silent = true })
-- buffer close
vim.keymap.set("n", "<C-x>", "<Nop>", { noremap = true, silent = true })
-- switch window
vim.keymap.set("n", "<C-h>", "<Nop>", { noremap = true, silent = true })
vim.keymap.set("n", "<C-j>", "<Nop>", { noremap = true, silent = true })
vim.keymap.set("n", "<C-k>", "<Nop>", { noremap = true, silent = true })
vim.keymap.set("n", "<C-l>", "<Nop>", { noremap = true, silent = true })
-- floaterm
vim.keymap.set("n", "<C-z>", "<Nop>", { noremap = true, silent = true })
-- treesitter
vim.keymap.set("n", "'", "<Nop>", { noremap = true, silent = true })
-- vim-operator-convert-case
vim.keymap.set("n", "~", "<Nop>", { noremap = true, silent = true })
-- not use
vim.keymap.set("n", "Q", "<Nop>", { noremap = true, silent = true })
vim.keymap.set("n", "C", "<Nop>", { noremap = true, silent = true })
vim.keymap.set("n", "D", "<Nop>", { noremap = true, silent = true })
vim.keymap.set("n", "Y", "<Nop>", { noremap = true, silent = true })
vim.keymap.set("n", "=", "<Nop>", { noremap = true, silent = true })
vim.keymap.set("n", "<C-q>", "<Nop>", { noremap = true, silent = true })
-- vim.keymap.set('n', '<C-c>', '<Nop>',  {noremap=true, silent = true})

-- nnoremap <C-m> <Nop> " = <CR>
-- noremap <CR> <Nop> " use quickfix

vim.keymap.set("n", "qq", function()
	return vim.fn.reg_recording() == "" and "qq" or "q"
end, { noremap = true, expr = true })
vim.keymap.set("n", "q", "<Nop>", { noremap = true, silent = true })

vim.keymap.set("n", "gh", "<Nop>", { noremap = true, silent = true })
vim.keymap.set("n", "gj", "<Nop>", { noremap = true, silent = true })
vim.keymap.set("n", "gk", "<Nop>", { noremap = true, silent = true })
vim.keymap.set("n", "gl", "<Nop>", { noremap = true, silent = true })
vim.keymap.set("n", "gn", "<Nop>", { noremap = true, silent = true })
vim.keymap.set("n", "gm", "<Nop>", { noremap = true, silent = true })
vim.keymap.set("n", "go", "<Nop>", { noremap = true, silent = true })
vim.keymap.set("n", "gq", "<Nop>", { noremap = true, silent = true })
vim.keymap.set("n", "gr", "<Nop>", { noremap = true, silent = true })
vim.keymap.set("n", "gs", "<Nop>", { noremap = true, silent = true })
vim.keymap.set("n", "gw", "<Nop>", { noremap = true, silent = true })
vim.keymap.set("n", "g^", "<Nop>", { noremap = true, silent = true })
vim.keymap.set("n", "g?", "<Nop>", { noremap = true, silent = true })
vim.keymap.set("n", "gQ", "<Nop>", { noremap = true, silent = true })
vim.keymap.set("n", "gR", "<Nop>", { noremap = true, silent = true })
vim.keymap.set("n", "gT", "<Nop>", { noremap = true, silent = true })

---- remap
vim.keymap.set("n", "gK", "K", { noremap = true, silent = true })
vim.keymap.set("n", "g~", "~", { noremap = true, silent = true })
vim.keymap.set("n", "G@", "@", { noremap = true, silent = true })
vim.keymap.set("n", "g=", "=", { noremap = true, silent = true })
vim.keymap.set("n", "gzz", "zz", { noremap = true, silent = true })
vim.keymap.set("n", "g?", "?", { noremap = true, silent = true })
vim.keymap.set("n", "gG", "G", { noremap = true, silent = true })
vim.keymap.set("n", "GG", "G", { noremap = true, silent = true })
vim.keymap.set({ "n", "x" }, "gJ", "J", { noremap = true, silent = true })
vim.keymap.set("n", "q", "<Cmd>close<CR>", { noremap = true, silent = true })
vim.keymap.set("n", "RR", "R", { noremap = true, silent = true })
vim.keymap.set("n", "CC", '"_C', { noremap = true, silent = true })
vim.keymap.set("n", "DD", "D", { noremap = true, silent = true })
vim.keymap.set("n", "YY", "y$", { noremap = true, silent = true })
vim.keymap.set("n", "X", "<Cmd>tabclose<CR>", { noremap = true, silent = true })
vim.keymap.set("n", "<C-S-q>", "<Cmd>tabclose<CR>", { noremap = true, silent = true })
vim.keymap.set("n", "gj", "j", { noremap = true, silent = true })
vim.keymap.set("n", "gk", "k", { noremap = true, silent = true })

-- move cursor
vim.keymap.set({ "n", "x" }, "j", function()
	return vim.v.count > 0 and "j" or "gj"
end, { noremap = true, expr = true })
vim.keymap.set({ "n", "x" }, "k", function()
	return vim.v.count > 0 and "k" or "gk"
end, { noremap = true, expr = true })
vim.keymap.set("n", "<C-j>", "<C-w>j", { noremap = true, silent = true })
vim.keymap.set("n", "<C-k>", "<C-w>k", { noremap = true, silent = true })
vim.keymap.set("n", "<C-l>", "<C-w>l", { noremap = true, silent = true })
vim.keymap.set("n", "<C-h>", "<C-w>h", { noremap = true, silent = true })
vim.keymap.set("n", "<C-s>", "<C-w>p", { noremap = true, silent = true })

-- Focus floating window with <C-w><C-w>
vim.keymap.set("n", "<C-w><C-w>", function()
	if vim.api.nvim_win_get_config(vim.api.nvim_get_current_win()).relative ~= "" then
		vim.cmd.wincmd("p")
		return
	end
	for _, winid in ipairs(vim.api.nvim_tabpage_list_wins(vim.api.nvim_get_current_tabpage())) do
		local conf = vim.api.nvim_win_get_config(winid)
		if conf.focusable and conf.relative ~= "" then
			vim.api.nvim_set_current_win(winid)
			return
		end
	end
end, { noremap = true, silent = false })

-- jump cursor
-- vim.keymap.set('n', '<Tab>', function() return vim.v.count and '0<Bar>' or '10l' end,
--                {noremap = true, expr = true, silent = true})
-- vim.keymap.set('n', '<CR>', function() return vim.o.buftype == 'quickfix' and "<CR>" or vim.v.count and '0jzz' or '10jzz' end,
--                {noremap = true, expr = true, silent = true})
-- nnoremap <silent> <expr> <CR>  &buftype ==# 'quickfix' ? "\<CR>" : v:count ? '0jzz' : '10jzz'

-- Automatically indent with i and A made by ycino
vim.keymap.set("n", "i", function()
	return string.len(vim.api.nvim_get_current_line()) ~= 0 and "i" or '"_cc'
end, { noremap = true, expr = true, silent = true })
vim.keymap.set("n", "A", function()
	return string.len(vim.api.nvim_get_current_line()) ~= 0 and "A" or '"_cc'
end, { noremap = true, expr = true, silent = true })

-- toggle 0, ^ made by ycino
vim.keymap.set("n", "0", function()
	return string.match(vim.api.nvim_get_current_line():sub(0, vim.api.nvim_win_get_cursor(0)[2]), "^%s+$") and "0"
			or "^"
end, { noremap = true, expr = true, silent = true })

-- high-functioning undo
-- nnoremap u g-
-- nnoremap <C-r> g+

-- undo behavior
vim.keymap.set("i", "<BS>", "<C-g>u<BS>", { noremap = true, silent = false })
vim.keymap.set("i", "<CR>", "<C-g>u<CR>", { noremap = true, silent = false })
vim.keymap.set("i", "<DEL>", "<C-g>u<DEL>", { noremap = true, silent = false })
vim.keymap.set("i", "<C-w>", "<C-g>u<C-w>", { noremap = true, silent = false })

-- Emacs style
vim.keymap.set("c", "<C-a>", "<Home>", { noremap = true, silent = false })
if not vim.g.vscode then
	vim.keymap.set("c", "<C-e>", "<End>", { noremap = true, silent = false })
end
vim.keymap.set("c", "<C-f>", "<right>", { noremap = true, silent = false })
vim.keymap.set("c", "<C-b>", "<left>", { noremap = true, silent = false })
vim.keymap.set("c", "<C-d>", "<DEL>", { noremap = true, silent = false })
-- vim.keymap.set('c', '<C-h>', '<BS>', {noremap = true, silent = true})
vim.keymap.set("c", "<C-s>", "<BS>", { noremap = true, silent = false })
vim.keymap.set("i", "<C-a>", "<Home>", { noremap = true, silent = false })
vim.keymap.set("i", "<C-e>", "<End>", { noremap = true, silent = false })
vim.keymap.set("i", "<C-f>", "<right>", { noremap = true, silent = false })
vim.keymap.set("i", "<C-b>", "<left>", { noremap = true, silent = false })
vim.keymap.set("i", "<C-h>", "<left>", { noremap = true, silent = false })
vim.keymap.set("i", "<C-l>", "<right>", { noremap = true, silent = false })
vim.keymap.set("i", "<C-k>", "<up>", { noremap = true, silent = false })
vim.keymap.set("i", "<C-j>", "<down>", { noremap = true, silent = false })

-- remap H M L
vim.keymap.set("n", "gH", "H", { noremap = true, silent = true })
vim.keymap.set("n", "gM", "M", { noremap = true, silent = true })
vim.keymap.set("n", "gL", "L", { noremap = true, silent = true })

-- function key
vim.keymap.set({ "i", "c", "t" }, "<F1>", "<Esc><F1>", { noremap = true, silent = true })
vim.keymap.set({ "i", "c", "t" }, "<F2>", "<Esc><F2>", { noremap = true, silent = true })
vim.keymap.set({ "i", "c", "t" }, "<F3>", "<Esc><F3>", { noremap = true, silent = true })
vim.keymap.set({ "i", "c", "t" }, "<F4>", "<Esc><F4>", { noremap = true, silent = true })
vim.keymap.set({ "i", "c", "t" }, "<F5>", "<Esc><F5>", { noremap = true, silent = true })
vim.keymap.set({ "i", "c", "t" }, "<F6>", "<Esc><F6>", { noremap = true, silent = true })
vim.keymap.set({ "i", "c", "t" }, "<F7>", "<Esc><F7>", { noremap = true, silent = true })
vim.keymap.set({ "i", "c", "t" }, "<F8>", "<Esc><F8>", { noremap = true, silent = true })
vim.keymap.set({ "i", "c", "t" }, "<F9>", "<Esc><F9>", { noremap = true, silent = true })
vim.keymap.set({ "i", "c", "t" }, "<F10>", "<Esc><F10>", { noremap = true, silent = true })
vim.keymap.set({ "i", "c", "t" }, "<F11>", "<Esc><F11>", { noremap = true, silent = true })
vim.keymap.set({ "i", "c", "t" }, "<F12>", "<Esc><F12>", { noremap = true, silent = true })

vim.keymap.set({ "n", "x" }, "<F13>", "<S-F1>", { noremap = true, silent = true })
vim.keymap.set({ "n", "x" }, "<F14>", "<S-F2>", { noremap = true, silent = true })
vim.keymap.set({ "n", "x" }, "<F15>", "<S-F3>", { noremap = true, silent = true })
vim.keymap.set({ "n", "x" }, "<F16>", "<S-F4>", { noremap = true, silent = true })
vim.keymap.set({ "n", "x" }, "<F17>", "<S-F5>", { noremap = true, silent = true })
vim.keymap.set({ "n", "x" }, "<F18>", "<S-F6>", { noremap = true, silent = true })
vim.keymap.set({ "n", "x" }, "<F19>", "<S-F7>", { noremap = true, silent = true })
vim.keymap.set({ "n", "x" }, "<F20>", "<S-F8>", { noremap = true, silent = true })
vim.keymap.set({ "n", "x" }, "<F21>", "<S-F9>", { noremap = true, silent = true })
vim.keymap.set({ "n", "x" }, "<F22>", "<S-F10>", { noremap = true, silent = true })
vim.keymap.set({ "n", "x" }, "<F23>", "<S-F11>", { noremap = true, silent = true })
vim.keymap.set({ "n", "x" }, "<F24>", "<S-F12>", { noremap = true, silent = true })
vim.keymap.set({ "n", "x" }, "<F25>", "<C-F1>", { noremap = true, silent = true })
vim.keymap.set({ "n", "x" }, "<F26>", "<C-F2>", { noremap = true, silent = true })
vim.keymap.set({ "n", "x" }, "<F27>", "<C-F3>", { noremap = true, silent = true })
vim.keymap.set({ "n", "x" }, "<F28>", "<C-F4>", { noremap = true, silent = true })
vim.keymap.set({ "n", "x" }, "<F29>", "<C-F5>", { noremap = true, silent = true })
vim.keymap.set({ "n", "x" }, "<F30>", "<C-F6>", { noremap = true, silent = true })
vim.keymap.set({ "n", "x" }, "<F31>", "<C-F7>", { noremap = true, silent = true })
vim.keymap.set({ "n", "x" }, "<F32>", "<C-F8>", { noremap = true, silent = true })
vim.keymap.set({ "n", "x" }, "<F33>", "<C-F9>", { noremap = true, silent = true })
vim.keymap.set({ "n", "x" }, "<F34>", "<C-F10>", { noremap = true, silent = true })
vim.keymap.set({ "n", "x" }, "<F35>", "<C-F11>", { noremap = true, silent = true })
vim.keymap.set({ "n", "x" }, "<F36>", "<C-F12>", { noremap = true, silent = true })
vim.keymap.set({ "n", "x" }, "<F37>", "<C-S-F1>", { noremap = true, silent = true })

-- Clear highlighting
vim.keymap.set("n", "gq", "<Cmd>nohlsearch<CR>", { noremap = true, silent = true })

-- yank
vim.keymap.set("n", "d<Space>", "diw", { noremap = true, silent = true })
vim.keymap.set("n", "c<Space>", "ciw", { noremap = true, silent = true })
vim.keymap.set("n", "y<Space>", "yiw", { noremap = true, silent = true })
vim.keymap.set({ "x" }, "gy", "y`>", { noremap = true, silent = true })
vim.keymap.set({ "n", "x" }, "<LocalLeader>y", '"+y', { noremap = true, silent = true })
vim.keymap.set({ "n", "x" }, "<LocalLeader>d", '"+d', { noremap = true, silent = true })

-- lambdalisue's yank for slack
vim.keymap.set("x", "[_SubLeader]y", function()
	vim.cmd.normal({ "y", bang = true })
	local content = vim.fn.getreg(vim.v.register, 1, true)
	local spaces = {}
	for _, v in ipairs(content) do
		table.insert(spaces, string.match(v, "%s*"):len())
	end
	table.sort(spaces)
	local leading = spaces[1]
	local content_new = {}
	for _, v in ipairs(content) do
		table.insert(content_new, string.sub(v, leading + 1))
	end
	vim.fn.setreg(vim.v.register, content_new, vim.fn.getregtype(vim.v.register))
end, { noremap = true, silent = true })

-- paste
vim.keymap.set({ "n", "x" }, "p", "]p", { noremap = true, silent = true })
vim.keymap.set({ "n", "x" }, "gp", "p", { noremap = true, silent = true })
vim.keymap.set({ "n", "x" }, "gP", "P", { noremap = true, silent = true })
vim.keymap.set({ "n", "x" }, "<LocalLeader>p", '"+p', { noremap = true, silent = true })
vim.keymap.set({ "n", "x" }, "<LocalLeader>P", '"+P', { noremap = true, silent = true })

-- x,d are not registered in the register
vim.keymap.set({ "n", "x" }, "x", '"_x', { noremap = true, silent = true })
vim.keymap.set("n", "[_SubLeader]d", '"_d', { noremap = true, silent = true })
vim.keymap.set("n", "[_SubLeader]D", '"_D', { noremap = true, silent = true })

-- Increment / Decrement
vim.keymap.set({ "n", "x" }, "+", "<C-a>", { noremap = true, silent = true })
vim.keymap.set({ "n", "x" }, "_", "<C-x>", { noremap = true, silent = true })

-- move changes
vim.keymap.set("n", "<C-F2>", "g;zz", { noremap = true, silent = true })
vim.keymap.set("n", "<C-F3>", "g,zz", { noremap = true, silent = true })
vim.keymap.set("n", "^", "g;zz", { noremap = true, silent = true })
vim.keymap.set("n", "&", "g,zz", { noremap = true, silent = true })

-- refresh Use <F5> to clear the highlighting of :set hlsearch.
if vim.fn.maparg("<F5>", "n") == "" then
	vim.keymap.set(
		"n",
		"<F5>",
		":<C-u>nohlsearch<C-r>=has('diff')?'<Bar>diffupdate':''<CR><CR><C-l>",
		{ noremap = true, silent = true }
	)
end
vim.keymap.set("n", "<Esc>", "<Cmd>nohlsearch<CR><C-L><Esc>", { noremap = true, silent = true })

local function is_normal_buffer()
	if
			vim.o.ft == "qf"
			or vim.o.ft == "Vista"
			or vim.o.ft == "NvimTree"
			or vim.o.ft == "coc-explorer"
			or vim.o.ft == "diff"
	then
		return false
	end
	if vim.o.buftype == nil or vim.o.buftype == "terminal" then
		return true
	end
	return true
end

-- move buffer
vim.keymap.set("n", "<F2>", function()
	if is_normal_buffer() then
		vim.cmd.bprev()
	end
end, { noremap = true, silent = true })
vim.keymap.set("n", "<F3>", function()
	if is_normal_buffer() then
		vim.cmd.bnext()
	end
end, { noremap = true, silent = true })
vim.keymap.set("n", "H", function()
	if is_normal_buffer() then
		vim.cmd.bprev()
	end
end, { noremap = true, silent = true })
vim.keymap.set("n", "L", function()
	if is_normal_buffer() then
		vim.cmd.bnext()
	end
end, { noremap = true, silent = true })
vim.keymap.set("n", "<C-S-Left>", function()
	if is_normal_buffer() then
		vim.cmd.bprev()
	end
end, { noremap = true, silent = true })
vim.keymap.set("n", "<C-S-Right>", function()
	if is_normal_buffer() then
		vim.cmd.bnext()
	end
end, { noremap = true, silent = true })

vim.keymap.set("n", "[q", ":cprevious<CR>", { noremap = true, silent = true })
vim.keymap.set("n", "]q", ":cnext<CR>", { noremap = true, silent = true })
vim.keymap.set("n", "[Q", ":cfirst<CR>", { noremap = true, silent = true })
vim.keymap.set("n", "]Q", ":clast<CR>", { noremap = true, silent = true })
vim.keymap.set("n", "[l", ":lprevious<CR>", { noremap = true, silent = true })
vim.keymap.set("n", "]l", ":lnext<CR>", { noremap = true, silent = true })
vim.keymap.set("n", "[L", ":lfirst<CR>", { noremap = true, silent = true })
vim.keymap.set("n", "]L", ":llast<CR>", { noremap = true, silent = true })
vim.keymap.set("n", "[b", ":bprevious<CR>", { noremap = true, silent = true })
vim.keymap.set("n", "]b", ":bnext<CR>", { noremap = true, silent = true })
vim.keymap.set("n", "[B", ":bfirst<CR>", { noremap = true, silent = true })
vim.keymap.set("n", "]B", ":blast<CR>", { noremap = true, silent = true })
vim.keymap.set("n", "[t", ":tabprevious<CR>", { noremap = true, silent = true })
vim.keymap.set("n", "]t", ":tabnext<CR>", { noremap = true, silent = true })
vim.keymap.set("n", "[T", ":tabfirst<CR>", { noremap = true, silent = true })
vim.keymap.set("n", "]T", ":tablast<CR>", { noremap = true, silent = true })
vim.keymap.set("n", "[;", "g;zz", { noremap = true, silent = true })
vim.keymap.set("n", "];", "g,zz", { noremap = true, silent = true })

-- switch quickfix/location list
vim.keymap.set("n", "[_SubLeader]q", "<Cmd>copen<CR>", { noremap = true, silent = true })
vim.keymap.set("n", "[_SubLeader]l", "<Cmd>lopen<CR>", { noremap = true, silent = true })

-- Go to tab by number
-- nnoremap <Leader>1 1gt
-- nnoremap <Leader>2 2gt
-- nnoremap <Leader>3 3gt
-- nnoremap <Leader>4 4gt
-- nnoremap <Leader>5 5gt
-- nnoremap <Leader>6 6gt
-- nnoremap <Leader>7 7gt
-- nnoremap <Leader>8 8gt
-- nnoremap <Leader>9 9gt
-- nnoremap <Leader>0 :tablast<CR>
--
-- Tab move(alt-left/right)
-- nnoremap <S-PageUp> <Cmd>execute 'silent! tabmove ' . (tabpagenr()-2)<CR>
-- nnoremap <S-PageDown> <Cmd>execute 'silent! tabmove ' . (tabpagenr()+1)<CR>

-- move tab
-- nnoremap <S-F2> gT
-- nnoremap <S-F3> gt

-- change paragraph
-- nnoremap (  {zz
-- nnoremap )  }zz
-- nnoremap ]] ]]zz
-- nnoremap [[ [[zz
-- nnoremap [] []zz
-- nnoremap ][ ][zz

-- For search
vim.keymap.set("n", "g/", "/\\v", { noremap = true, silent = false })
vim.keymap.set("n", "*", "g*N", { noremap = true, silent = true })
vim.keymap.set("x", "*", 'y/<C-R>"<CR>N', { noremap = true, silent = true })
-- noremap # g#n
vim.keymap.set({ "n", "x" }, "g*", "*N", { noremap = true, silent = true })
vim.keymap.set({ "n", "x" }, "g#", "#n", { noremap = true, silent = true })
vim.keymap.set("x", "/", "<ESC>/\\%V", { noremap = true, silent = false })
vim.keymap.set("x", "?", "<ESC>?\\%V", { noremap = true, silent = false })

-- For replace
vim.keymap.set("n", "gr", "gd[{V%::s/<C-R>///gc<left><left><left>", { noremap = true, silent = false })
vim.keymap.set("n", "gR", "gD:%s/<C-R>///gc<left><left><left>", { noremap = true, silent = false })
vim.keymap.set("n", "[_SubLeader]s", ":%s/\\<<C-r><C-w>\\>/", { noremap = true, silent = false })
vim.keymap.set("x", "[_SubLeader]s", ":s/\\%V", { noremap = true, silent = false })

-- Undoable<C-w> <C-u>
vim.keymap.set("i", "<C-w>", "<C-g>u<C-w>", { noremap = true, silent = true })
vim.keymap.set("i", "<C-u>", "<C-g>u<C-u>", { noremap = true, silent = true })
vim.keymap.set("i", "<Space>", "<C-g>u<Space>", { noremap = true, silent = true })

-- Change current directory
vim.keymap.set("n", "[_SubLeader]cd", "<Cmd>lcd %:p:h<CR>:pwd<CR>", { noremap = true, silent = true })

-- Delete buffer
vim.keymap.set("n", "[_SubLeader]bd", "<Cmd>bdelete<CR>", { noremap = true, silent = true })
vim.keymap.set("n", "<C-x>", "<Cmd>bdelete<CR>", { noremap = true, silent = true })
vim.keymap.set("n", "<S-F4>", "<Cmd>edit #<CR>", { noremap = true, silent = true })

-- Delete all marks
vim.keymap.set("n", "[_SubLeader]md", "<Cmd>delmarks!<CR>", { noremap = true, silent = true })

-- Change encoding
vim.keymap.set("n", "[_SubLeader]eu", "<Cmd>e ++enc=utf-8<CR>", { noremap = true, silent = true })
vim.keymap.set("n", "[_SubLeader]es", "<Cmd>e ++enc=cp932<CR>", { noremap = true, silent = true })
vim.keymap.set("n", "[_SubLeader]ee", "<Cmd>e ++enc=euc-jp<CR>", { noremap = true, silent = true })
vim.keymap.set("n", "[_SubLeader]ej", "<Cmd>e ++enc=iso-2022-jp<CR>", { noremap = true, silent = true })

-- tags jump
-- vim.keymap.set("n", "<C-]>", "g<C-]>", { noremap = true, silent = true })

-- goto
vim.keymap.set("n", "gf", "gF", { noremap = true, silent = true })
vim.keymap.set("n", "<C-w>f", "<C-w>F", { noremap = true, silent = true })
vim.keymap.set("n", "<C-w>gf", "<C-w>F", { noremap = true, silent = true })
vim.keymap.set("n", "<C-w><C-f>", "<C-w>F", { noremap = true, silent = true })
vim.keymap.set("n", "<C-w>g<C-f>", "<C-w>F", { noremap = true, silent = true })

-- split goto
vim.keymap.set("n", "-gf", "<Cmd>split<CR>gF", { noremap = true, silent = true })
vim.keymap.set("n", "<Bar>gf", "<Cmd>vsplit<CR>gF", { noremap = true, silent = true })
vim.keymap.set("n", "-<C-]>", "<Cmd>split<CR>g<C-]>", { noremap = true, silent = true })
vim.keymap.set("n", "<Bar><C-]>", "<Cmd>vsplit<CR>g<C-]>", { noremap = true, silent = true })

-- split
vim.keymap.set("n", "-", "<Cmd>split<CR>", { noremap = true, silent = true })
vim.keymap.set("n", "<Bar>", "<Cmd>vsplit<CR>", { noremap = true, silent = true })
vim.keymap.set("n", "--", "<Cmd>split<CR>", { noremap = true, silent = true })
vim.keymap.set("n", "<Bar><Bar>", "<Cmd>vsplit<CR>", { noremap = true, silent = true })

-- useful search
vim.keymap.set("n", "n", "'Nn'[v:searchforward]", { noremap = true, silent = true, expr = true })
vim.keymap.set("n", "N", "'nN'[v:searchforward]", { noremap = true, silent = true, expr = true })
vim.keymap.set("c", "<C-s>", "<HOME><Bslash><lt><END><Bslash>>", { noremap = true, silent = false })
vim.keymap.set("c", "<C-d>", "<HOME><Del><Del><END><BS><BS>", { noremap = true, silent = false })

-- Edit macro
vim.keymap.set(
	"n",
	"[_SubLeader]me",
	":<C-r><C-r>='let @'. v:register .' = '. string(getreg(v:register))<CR><C-f><left>",
	{ noremap = true, silent = true }
)

-- indent
vim.keymap.set("x", "<", "<gv", { noremap = true, silent = true })
vim.keymap.set("x", ">", ">gv", { noremap = true, silent = true })
-- vim.keymap.set("n", "(", "{", { noremap = true, silent = true })
-- vim.keymap.set("n", ")", "}", { noremap = true, silent = true })
vim.keymap.set("n", "[[", "[m", { noremap = true, silent = true })
vim.keymap.set("n", "]]", "]m", { noremap = true, silent = true })

-- command mode
vim.keymap.set("c", "<C-x>", "<C-r>=expand('%:p:h')<CR>/", { noremap = true, silent = false }) -- expand path
vim.keymap.set("c", "<C-z>", "<C-r>=expand('%:p:r')<CR>", { noremap = true, silent = false })  -- expand file (not ext)
vim.keymap.set("c", "<C-p>", "<Up>", { noremap = true, silent = false })
vim.keymap.set("c", "<C-n>", "<Down>", { noremap = true, silent = false })
vim.keymap.set("c", "<Up>", "<C-p>", { noremap = true, silent = false })
vim.keymap.set("c", "<Down>", "<C-n>", { noremap = true, silent = false })
vim.o.cedit = "<C-c>" -- command window

-- terminal mode
vim.keymap.set("t", "<Esc>", "<C-\\><C-n>", { noremap = true, silent = false })

-- fold
-- nnoremap Zo zo " -> use l
vim.keymap.set("n", "gzO", "zO", { noremap = true, silent = true })
vim.keymap.set("n", "gzc", "zc", { noremap = true, silent = true })
vim.keymap.set("n", "gzC", "zC", { noremap = true, silent = true })
vim.keymap.set("n", "gzR", "zR", { noremap = true, silent = true })
vim.keymap.set("n", "gzM", "zM", { noremap = true, silent = true })
vim.keymap.set("n", "gza", "za", { noremap = true, silent = true })
vim.keymap.set("n", "gzA", "zA", { noremap = true, silent = true })
vim.keymap.set("n", "gz<Space>", "zMzvzz", { noremap = true, silent = true })

-- quit
vim.keymap.set("n", "ZZ", "<Nop>", { noremap = true, silent = true })
vim.keymap.set("n", "ZQ", "<Nop>", { noremap = true, silent = true })

-- operator
vim.keymap.set("o", "<Space>", "iw", { noremap = true, silent = true })
vim.keymap.set("o", 'a"', '2i"', { noremap = true, silent = true })
vim.keymap.set("o", "a'", "2i'", { noremap = true, silent = true })
vim.keymap.set("o", "a`", "2i`", { noremap = true, silent = true })
-- -> In double-quote, you can't delete with ]} and ])
vim.keymap.set("o", "{", "i{", { noremap = true, silent = true })
vim.keymap.set("o", "(", "i(", { noremap = true, silent = true })
vim.keymap.set("o", "[", "i[", { noremap = true, silent = true })
vim.keymap.set("o", "<", "i<", { noremap = true, silent = true })
vim.keymap.set("n", "<<", "<<", { noremap = true, silent = true })
vim.keymap.set("o", "}", "i}", { noremap = true, silent = true })
vim.keymap.set("o", ")", "i)", { noremap = true, silent = true })
vim.keymap.set("o", "]", "i]", { noremap = true, silent = true })
vim.keymap.set("o", ">", "i>", { noremap = true, silent = true })
vim.keymap.set("n", ">>", ">>", { noremap = true, silent = true })
vim.keymap.set("o", '"', 'i"', { noremap = true, silent = true })
vim.keymap.set("o", "'", "i'", { noremap = true, silent = true })
vim.keymap.set("o", "`", "i`", { noremap = true, silent = true })
vim.keymap.set("o", "_", "i_", { noremap = true, silent = true })
vim.keymap.set("o", "-", "i-", { noremap = true, silent = true })

-- from monaqa's vimrc
vim.keymap.set("n", "[_SubLeader])", "])", { noremap = true, silent = true })
vim.keymap.set("n", "[_SubLeader]}", "]}", { noremap = true, silent = true })
vim.keymap.set("x", "[_SubLeader]]", "i]o``", { noremap = true, silent = true })
vim.keymap.set("x", "[_SubLeader](", "i)``", { noremap = true, silent = true })
vim.keymap.set("x", "[_SubLeader]{", "i}``", { noremap = true, silent = true })
vim.keymap.set("x", "[_SubLeader][", "i]``", { noremap = true, silent = true })
vim.keymap.set("n", "d[_SubLeader]]", "vi]o``d", { noremap = true, silent = true })
vim.keymap.set("n", "d[_SubLeader](", "vi)o``d", { noremap = true, silent = true })
vim.keymap.set("n", "d[_SubLeader]{", "vi}o``d", { noremap = true, silent = true })
vim.keymap.set("n", "d[_SubLeader][", "vi]o``d", { noremap = true, silent = true })
vim.keymap.set("n", "d[_SubLeader]]", "vi]o``d", { noremap = true, silent = true })
vim.keymap.set("n", "c[_SubLeader]]", "vi]o``c", { noremap = true, silent = true })
vim.keymap.set("n", "c[_SubLeader](", "vi)o``c", { noremap = true, silent = true })
vim.keymap.set("n", "c[_SubLeader]{", "vi}o``c", { noremap = true, silent = true })
vim.keymap.set("n", "c[_SubLeader][", "vi]o``c", { noremap = true, silent = true })
vim.keymap.set("n", "c[_SubLeader]]", "vi]o``c", { noremap = true, silent = true })

-- control code
vim.keymap.set("i", "<C-q>", "<C-r>=nr2char(0x)<Left>", { noremap = true, silent = true })
vim.keymap.set("x", ".", ":normal! .<CR>", { noremap = true, silent = true })
vim.keymap.set(
	"x",
	"@",
	":<C-u>execute \":'<,'>normal! @\" . nr2char(getchar())<CR>",
	{ noremap = true, silent = true }
)
