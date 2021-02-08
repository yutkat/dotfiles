
if exists('g:loaded_persistentundo')
  finish
endif
let g:loaded_persistentundo = 1

if ! &undofile
  echom 'Please set `:set undofile`'
  finish
endif

if empty(&undodir)
  echom 'Please set `:set undodir=$HOME/.vim/undo`'
  finish
endif

if has('autocmd')
  augroup persistentundo
    autocmd!
    if has('persistent_undo')
      autocmd BufRead ~/* setlocal undofile
    endif
  augroup END
endif
