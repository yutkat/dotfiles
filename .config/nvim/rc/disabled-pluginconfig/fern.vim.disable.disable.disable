augroup vimrc_fern
  autocmd!
  autocmd VimEnter * sil! au! FileExplorer *
  autocmd BufEnter * ++nested call s:hijack_directory()
augroup END
function! s:hijack_directory() abort
  let path = expand('%')
  if !isdirectory(path)
    return
  endif
  exe 'Fern' path
endfunction
