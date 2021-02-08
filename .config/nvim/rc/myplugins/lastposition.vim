
if exists('g:loaded_lastposition')
  finish
endif
let g:loaded_lastposition = 1

if has('autocmd')
  " Put these in an autocmd group, so that we can delete them easily.
  augroup lastposition
    autocmd!
    " 前回終了したカーソル行に移動
    autocmd BufReadPost * if line("'\"") > 0 && line("'\"") <= line("$") | exe "normal g`\"" | endif
  augroup END
endif
