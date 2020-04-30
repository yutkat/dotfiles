if exists('g:save_exit_clipboard')
  finish
endif
let g:save_exit_clipboard = 1


function! s:save_to_clipboard() abort
  if exists('$WAYLAND_DISPLAYD')
    return
  endif
  if !exists('$DISPLAY') || !has('clipboard')
    return
  endif

  if executable('xsel')
    if &clipboard =~# '\<unnamed\>'
      call system("xsel -i --clipboard", getreg('*'))
    endif
    if &clipboard =~# '\<unnamedplus\>'
      call system("xsel -i --primary", getreg('+'))
    endif
  elseif executable('xclip')
    if &clipboard =~# '\<unnamed\>'
      call system("xclip -i -selection clipboard", getreg('*'))
    endif
    if &clipboard =~# '\<unnamedplus\>'
      call system("xclip -i -selection primary", getreg('+'))
    endif
  endif
endfunction


if has('autocmd')
  augroup save_exit_clipboard
    autocmd VimLeave * call s:save_to_clipboard()
  augroup END
endif


