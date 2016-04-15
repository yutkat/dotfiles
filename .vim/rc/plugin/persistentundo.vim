
if has('autocmd')
  augroup pundo
    autocmd!
    " アンドゥ
    if has('persistent_undo')
      set undodir=./.vimundo,~/.vim/undo,~/.vim/vimundo
      autocmd BufRead ~/* setlocal undofile
    endif
  augroup END
endif
