function! s:set_prompt_buffer_config() abort
  if &l:buftype ==# 'prompt'
    inoremap <buffer> <C-j> <Esc><C-w>j
    inoremap <buffer> <C-k> <Esc><C-w>k
    inoremap <buffer> <C-h> <Esc><C-w>h
    inoremap <buffer> <C-l> <Esc><C-w>l
    " startinsert
  endif
endfunction

" https://github.com/lambdalisue/dotfiles/blob/02549431364232b051cc8bdb5b124e9e75256a6b/nvim/init.vim#L423-L449
function! s:auto_mkdir(dir, force) abort
  if empty(a:dir) || a:dir =~# '^\w\+://' || isdirectory(a:dir) || a:dir =~# '^suda:'
      return
  endif
  if !a:force
    echohl Question
    call inputsave()
    try
      let result = input(
            \ printf('"%s" does not exist. Create? [y/N]', a:dir),
            \ '',
            \)
      if empty(result)
        echohl WarningMsg
        echo 'Canceled'
        return
      endif
    finally
      call inputrestore()
      echohl None
    endtry
  endif
  call mkdir(a:dir, 'p')
endfunction

if has('autocmd')
  augroup vimrc_vimrc
    autocmd!
    autocmd BufEnter,FocusGained,InsertLeave,WinEnter * if &nu && mode() != "i" | set rnu   | endif
    autocmd BufLeave,FocusLost,InsertEnter,WinLeave   * if &nu                  | set nornu | endif
    autocmd QuickfixCmdPost make,grep,grepadd,vimgrep,vimgrepadd cwin
    autocmd QuickfixCmdPost lmake,lgrep,lgrepadd,lvimgrep,lvimgrepadd lwin
    autocmd FileType qf setlocal wrap
    "autocmd BufWritePost * if getline(1) =~ "^#!" | if getline(1) =~ "/bin/" | silent !chmod +x <afile> | endif | endif
    autocmd BufWritePost * if getline(1) =~ "^#!" | if getline(1) =~ "/bin/" | silent execute "!chmod a+x <afile>" | endif | endif
    autocmd CmdwinEnter * startinsert
    " Check timestamp more for 'autoread'.
    autocmd WinEnter,FocusGained * if !bufexists("[Command Line]") | checktime | endif
    " thincursor https://thinca.hatenablog.com/entry/20090530/1243615055
    " let s:cur_f = 0
    " autocmd WinEnter * setlocal cursorline | let s:cur_f = 0
    " autocmd WinLeave * setlocal nocursorline
    " autocmd CursorHold,CursorHoldI * setlocal cursorline | let s:cur_f = 1
    " autocmd CursorMoved,CursorMovedI * if s:cur_f | setlocal nocursorline | endif

    " winresizer bugs when using startinsert instead of feedkeys
    " autocmd BufEnter,TermOpen,TermEnter term://* startinsert
    " When TermClose is enable, [Process exited 0] is diplayed and terminal window cannot be closed.
    " autocmd BufLeave,TermLeave term://* stopinsert
    autocmd TextYankPost * silent! lua vim.highlight.on_yank {higroup=(vim.fn['hlexists']('HighlightedyankRegion') > 0 and 'HighlightedyankRegion' or 'Visual'), timeout=200}
    autocmd BufWinEnter,WinEnter * call s:set_prompt_buffer_config()
    autocmd BufWritePre * call s:auto_mkdir(expand('<afile>:p:h'), v:cmdbang)
    autocmd BufEnter,TermOpen,TermEnter term://* nnoremap <silent><buffer> <CR> <Cmd>call vimrc#open_file_with_line_col(expand('<cfile>'), expand('<cWORD>'))<CR>
  augroup END
endif
