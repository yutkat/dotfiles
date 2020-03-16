let g:histignore = [
      \ '^buf$',
      \ '^history$',
      \ '^h$',
      \ '^q$',
      \ '^qa$',
      \ '^w$',
      \ '^wq$',
      \ '^wa$',
      \ '^wqa$',
      \ '^q!$',
      \ '^qa!$',
      \ '^w!$',
      \ '^wq!$',
      \ '^wa!$',
      \'^wqa!$'
      \ ]

function! DeleteIgnoredHistories() abort
  call filter(copy(g:histignore), {i, v -> histdel(':', v)})
endfunction

if has('autocmd')
  augroup MyVimrc
    autocmd!
    autocmd QuickfixCmdPost make,grep,grepadd,vimgrep,vimgrepadd cwin
    autocmd QuickfixCmdPost lmake,lgrep,lgrepadd,lvimgrep,lvimgrepadd lwin
    autocmd FileType qf setlocal wrap
    "autocmd BufWritePost * if getline(1) =~ "^#!" | if getline(1) =~ "/bin/" | silent !chmod +x <afile> | endif | endif
    autocmd BufWritePost * if getline(1) =~ "^#!" | if getline(1) =~ "/bin/" | silent execute "!chmod a+x <afile>" | endif | endif
    if exists('##CmdlineEnter')
      autocmd CmdlineEnter : call DeleteIgnoredHistories()
    endif
    " Check timestamp more for 'autoread'.
    autocmd WinEnter,FocusGained * if !bufexists("[Command Line]") | checktime | endif

    " thincursor https://thinca.hatenablog.com/entry/20090530/1243615055
    " let s:cur_f = 0
    " autocmd WinEnter * setlocal cursorline | let s:cur_f = 0
    " autocmd WinLeave * setlocal nocursorline
    " autocmd CursorHold,CursorHoldI * setlocal cursorline | let s:cur_f = 1
    " autocmd CursorMoved,CursorMovedI * if s:cur_f | setlocal nocursorline | endif
  augroup END
endif
