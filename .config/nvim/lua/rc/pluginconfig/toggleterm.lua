require("toggleterm").setup({
	-- size can be a number or function which is passed the current terminal
	size = function(term)
		if term.direction == "horizontal" then
			return vim.o.lines * 0.25
		elseif term.direction == "vertical" then
			return vim.o.columns * 0.4
		end
	end,
	open_mapping = [[<c-z>]],
	hide_numbers = true, -- hide the number column in toggleterm buffers
	shade_filetypes = {},
	shade_terminals = true,
	shading_factor = "1", -- the degree by which to darken to terminal colour, default: 1 for dark backgrounds, 3 for light
	start_in_insert = false,
	insert_mappings = true, -- whether or not the open mapping applies in insert mode
	persist_size = false,
	direction = "float",
	close_on_exit = false, -- close the terminal window when the process exits
	shell = vim.o.shell, -- change the default shell
	-- This field is only relevant if direction is set to 'float'
	float_opts = {
		-- The border key is *almost* the same as 'nvim_win_open'
		-- see :h nvim_win_open for details on borders however
		-- the 'curved' border is a custom border type
		-- not natively supported but implemented in this plugin.
		border = "single",
		width = math.floor(vim.o.columns * 0.9),
		height = math.floor(vim.o.lines * 0.9),
		winblend = 3,
		highlights = { border = "ColorColumn", background = "ColorColumn" },
	},
})

vim.api.nvim_set_keymap("n", "<C-z>", '<Cmd>execute v:count1 . "ToggleTerm"<CR>', { noremap = true, silent = true })

local groupname = "vimrc_toggleterm"
vim.api.nvim_create_augroup(groupname, { clear = true })
vim.api.nvim_create_autocmd({ "TermOpen", "TermEnter", "BufEnter" }, {
	group = groupname,
	pattern = "term://*/zsh;#toggleterm#[^56789]",
	callback = function()
		vim.cmd.startinsert()
	end,
	once = false,
})
vim.api.nvim_create_autocmd({ "TermOpen", "TermEnter" }, {
	group = groupname,
	pattern = "term://*#toggleterm#[^56789]",
	callback = function()
		vim.keymap.set("n", "<Esc>", "<Cmd>exe 'ToggleTerm'<CR>", { noremap = true, silent = true, buffer = true })
	end,
	once = false,
})
vim.api.nvim_create_autocmd({ "TermOpen", "TermEnter" }, {
	group = groupname,
	pattern = "term://*#toggleterm#[^56789]",
	callback = function()
		vim.keymap.set(
			"t",
			"<C-z>",
			"<C-\\><C-n>:exe 'ToggleTerm'<CR>",
			{ noremap = true, silent = true, buffer = true }
		)
	end,
	once = false,
})
vim.api.nvim_create_autocmd({ "TermOpen", "TermEnter" }, {
	group = groupname,
	pattern = "term://*#toggleterm#*",
	callback = function()
		vim.keymap.set("n", "gf", function()
			local function go_to_file_from_terminal()
				local r = vim.fn.expand("<cfile>")
				if vim.fn.filereadable(r) ~= 0 then
					return r
				end
				vim.cmd.normal({ "j", bang = true })
				local r1 = vim.fn.expand("<cfile>")
				if vim.fn.filereadable(vim.fs.joinpath(r, r1)) ~= 0 then
					return r .. r1
				end
				vim.cmd.normal({ "2k", bang = true })
				local r2 = vim.fn.expand("<cfile>")
				if vim.fn.filereadable(vim.fs.joinpath(r2, r)) ~= 0 then
					return r2 .. r
				end
				vim.cmd.normal({ "j", bang = true })
				return r
			end
			local function open_file_with_line_col(file, word)
				local f = vim.fs.find(vim.fs.basename(file), { path = vim.fs.dirname(file) })[1]
				local num = vim.fn.matchstr(word, file .. ":" .. "\\zsd*\\ze")
				if not f then
					vim.cmd.wincmd("p")
					vim.fn.execute("e " .. f)
					if string.len(num) ~= 0 then
						vim.fn.execute(num)
						local col = vim.fn.matchstr(word, file .. ":\\d*:" .. "\\zs\\d*\\ze")
						if string.len(col) ~= 0 then
							vim.fn.execute("normal! " .. col .. "|")
						end
					end
				end
			end
			local function toggle_term_open_in_normal_window()
				local file = go_to_file_from_terminal()
				local word = vim.fn.expand("<cWORD>")
				if vim.fn.has_key(vim.api.nvim_win_get_config(vim.api.nvim_get_current_win()), "anchor") ~= 0 then
					vim.cmd([[ToggleTerm]])
				end
				open_file_with_line_col(file, word)
			end
			toggle_term_open_in_normal_window()
		end, { noremap = true, silent = true, buffer = true })
	end,
	once = false,
})
