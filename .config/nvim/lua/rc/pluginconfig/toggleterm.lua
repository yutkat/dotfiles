require("toggleterm").setup({
	-- size can be a number or function which is passed the current terminal
	size = function(term)
		if term.direction == "horizontal" then
			return vim.fn.float2nr(vim.o.lines * 0.25)
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

vim.cmd([[
let g:toglleterm_win_num = winnr()
function! ToggleTermOpenInNormalWindow() abort
  let l:file = vimrc#go_to_file_from_terminal()
  let l:word = expand('<cWORD>')
  if has_key(nvim_win_get_config(win_getid()), 'anchor')
    ToggleTerm
  endif
  call vimrc#open_file_with_line_col(l:file, l:word)
endfunction

augroup vimrc_toggleterm
  autocmd!
	autocmd TermOpen,TermEnter term://*#toggleterm#[^9] nnoremap <buffer><silent> <Esc> <Cmd>exe v:count1 . "ToggleTerm"<CR>
	autocmd TermOpen,TermEnter term://*#toggleterm#[^9] tnoremap <buffer><silent> <C-z> <C-\><C-n>:exe v:count1 . "ToggleTerm"<CR>
  autocmd TermOpen,TermEnter term://*#toggleterm#* nnoremap <silent><buffer> gf :call ToggleTermOpenInNormalWindow()<CR>
  autocmd TermOpen,TermEnter,BufEnter term://*/zsh;#toggleterm#* startinsert
augroup END
]])
