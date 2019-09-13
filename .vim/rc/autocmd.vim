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
    autocmd BufWritePost * if getline(1) =~ "^#!" | if getline(1) =~ "/bin/" | silent !chmod +x <afile> | endif | endif
    autocmd CmdlineEnter : call DeleteIgnoredHistories()
    " Check timestamp more for 'autoread'.
    autocmd WinEnter,FocusGained * checktime
  augroup END
endif
