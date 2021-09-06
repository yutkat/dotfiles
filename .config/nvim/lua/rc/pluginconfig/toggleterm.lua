require("toggleterm").setup {
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
  shading_factor = '1', -- the degree by which to darken to terminal colour, default: 1 for dark backgrounds, 3 for light
  start_in_insert = false,
  insert_mappings = true, -- whether or not the open mapping applies in insert mode
  persist_size = false,
  direction = 'float',
  close_on_exit = false, -- close the terminal window when the process exits
  shell = vim.o.shell, -- change the default shell
  -- This field is only relevant if direction is set to 'float'
  float_opts = {
    -- The border key is *almost* the same as 'nvim_win_open'
    -- see :h nvim_win_open for details on borders however
    -- the 'curved' border is a custom border type
    -- not natively supported but implemented in this plugin.
    border = 'none',
    width = math.floor(vim.o.columns * 0.9),
    height = math.floor(vim.o.lines * 0.9),
    winblend = 3,
    highlights = {border = "NonText", background = "ColorColumn"}
  }
}

local split_size = vim.fn.float2nr(vim.o.lines * 0.25)
local Terminal = require('toggleterm.terminal').Terminal
local task_runner = Terminal:new({direction = "horizontal", count = 9})
function TaskRunnerTerminal(cmd)
  if task_runner:is_open() then
    task_runner:shutdown()
  end
  task_runner = Terminal:new({cmd = cmd, direction = "horizontal", count = 9})
  task_runner:open(split_size, "horizontal", true)
  -- require('toggleterm.ui').save_window_size()
  vim.cmd [[let g:toglleterm_win_num = winnr()]]
  vim.cmd [[setlocal number]]
  vim.cmd [[stopinsert | wincmd p]]
end

vim.api.nvim_set_keymap('n', '<C-z>', '<Cmd>execute v:count1 . "ToggleTerm"<CR>',
                        {noremap = true, silent = true})

vim.cmd [[command! -nargs=+ TaskRunnerTerminal lua TaskRunnerTerminal(<q-args>)]]

function TaskRunnerTerminalToggle()
  task_runner:toggle(split_size)
  if task_runner:is_open() then
    vim.cmd("wincmd p")
  end
end
vim.cmd [[command! -nargs=0 TaskRunnerTerminalToggle lua TaskRunnerTerminalToggle()]]
vim.api.nvim_set_keymap('n', '<make>m', "<Cmd>TaskRunnerTerminalToggle<CR>",
                        {noremap = true, silent = true})

function ToggleTermShutdown()
  if task_runner:is_open() then
    task_runner:shutdown()
  end
end

function ToggleTermClose()
  ToggleTermShutdown()
  if vim.api.nvim_win_is_valid(vim.g.toglleterm_win_num) then
    vim.api.nvim_win_close(vim.g.toglleterm_win_num)
  end
end

vim.cmd [[
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
  " https://github.com/neovim/neovim/issues/13078
  autocmd VimLeavePre * lua ToggleTermClose()
  autocmd TermOpen,TermEnter term://*#toggleterm#* nnoremap <silent><buffer> gf :call ToggleTermOpenInNormalWindow()<CR>
  autocmd TermOpen,TermEnter,BufEnter term://*/zsh;#toggleterm#* startinsert
  autocmd TermClose term://*#toggleterm#9* ++nested if winbufnr(g:toglleterm_win_num) != -1 | execute g:toglleterm_win_num . "wincmd w" | $ | wincmd p | endif
augroup END
]]
