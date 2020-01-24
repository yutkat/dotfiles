if exists('g:loaded_ctrl_w_until_underscore')
	finish
endif
let g:loaded_ctrl_w_until_underscore = 1


inoremap <silent> <C-w> <C-o>:<C-u>call <SID>ctrl_w_until_underscore()<CR>

function! s:ctrl_w_until_underscore() abort
  let l:isk_save = &l:iskeyword
  setlocal iskeyword-=_
  try
    execute "normal! db"
  catch
    return 'echoerr '.string(v:exception)
  finally
    let &l:iskeyword = l:isk_save
  endtry
endfunction
