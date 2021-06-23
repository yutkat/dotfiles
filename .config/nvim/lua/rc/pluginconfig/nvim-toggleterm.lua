require("toggleterm").setup {
  -- size can be a number or function which is passed the current terminal
  size = function(term)
    if term.direction == "horizontal" then
      return 15
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
  persist_size = true,
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

local Terminal = require('toggleterm.terminal').Terminal
local task_runner = Terminal:new({direction = "horizontal", count = 9})
function TaskRunnerTerminal(cmd)
  if task_runner:is_open() then
    task_runner:shutdown()
  end
  task_runner = Terminal:new({cmd = cmd, direction = "horizontal", count = 9})
  task_runner:open(30, false)
  vim.cmd [[setlocal number]]
end

vim.api.nvim_set_keymap('n', '<C-z>', '<Cmd>execute v:count1 . "ToggleTerm"<CR>',
                        {noremap = true, silent = true})

vim.cmd [[command! -nargs=+ TaskRunnerTerminal lua TaskRunnerTerminal(<q-args>)]]

function TaskRunnerTerminalToggle()
  task_runner:toggle(30)
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

vim.cmd [[
function OpenInNormalWindow() abort
  let l:f = findfile(expand('<cfile>'))
  let l:num = matchstr(expand('<cWORD>'), expand('<cfile>') .. ':' .. '\zs\d*\ze')
  if !empty(f) && has_key(nvim_win_get_config(win_getid()), 'anchor')
    ToggleTerm
    execute 'e ' . l:f
    if !empty(num)
      execute l:num
    endif
  endif
endfunction
augroup vimrc_toggleterm
  autocmd!
  autocmd TermOpen,TermEnter term://*#toggleterm#* nnoremap <buffer><silent> <Esc> <Cmd>exe v:count1 . "ToggleTerm"<CR>
  autocmd TermOpen,TermEnter term://*#toggleterm#* tnoremap <buffer><silent> <C-z> <C-\><C-n>:exe v:count1 . "ToggleTerm"<CR>
  " https://github.com/neovim/neovim/issues/13078
  autocmd QuitPre,VimLeavePre * lua ToggleTermShutdown()
  autocmd FileType toggleterm nnoremap <silent><buffer> gf :call OpenInNormalWindow()<CR>
  autocmd TermOpen,TermEnter,BufEnter term://*/zsh;#toggleterm#* startinsert
augroup END
]]
