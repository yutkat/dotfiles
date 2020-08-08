
if exists('g:loaded_autoclose')
  finish
endif
let g:loaded_autoclose = 1

augroup QFClose
  autocmd!
  autocmd BufEnter * call MyLastWindow()
augroup END

function! MyLastWindow()
  " if the window is quickfix go on
  if &buftype ==? 'quickfix'
    " if this window is last on screen quit without warning
    if winbufnr(2) == -1
      quit!
    endif
  endif
endfunction

