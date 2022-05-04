
if exists('g:loaded_mouse')
  finish
endif
let g:loaded_mouse = 1

" ======== Mouse Setting ======== "
" In many terminal emulators the mouse works just fine, thus enable it.
if has('mouse')
  set mouse=
  " For screen.
  if &term =~? '^screen'
    augroup mouse_config
      autocmd!
      autocmd VimLeave * :set mouse=
    augroup END

    if exists('&ttymouse')
      set ttymouse=xterm2
    endif
  endif

  if has('gui_running')
    " Show popup menu if right click.
    set mousemodel=popup
    " Don't focus the window when the mouse pointer is moved.
    set nomousefocus
    " Hide mouse pointer on insert mode.
    set mousehide
  endif
endif
