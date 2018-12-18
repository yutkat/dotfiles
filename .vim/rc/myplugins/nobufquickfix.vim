
if exists('g:loaded_nobufquickfix')
	finish
endif
let g:loaded_nobufquickfix = 1

augroup qf
  autocmd!
  autocmd FileType qf set nobuflisted
augroup END

