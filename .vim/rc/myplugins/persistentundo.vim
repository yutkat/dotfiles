
if exists('g:loaded_persistentundo')
  finish
endif
let g:loaded_persistentundo = 1

if has('autocmd')
  augroup persistentundo
    autocmd!
    " アンドゥ
    if has('persistent_undo')
      set undodir=./.vimundo,~/.vim/undo,~/.vim/vimundo
      autocmd BufRead ~/* setlocal undofile
    endif
  augroup END
endif
