
if exists('g:loaded_fcitx')
  finish
endif
let g:loaded_fcitx= 1


if has('has')
  if executable('fcitx-remote')
    set iminsert=2
    set imsearch=2
    set imcmdline
    set imactivatefunc=ImActivate
    function! ImActivate(active) abort
      if a:active
        call system('fcitx-remote -o')
      else
        call system('fcitx-remote -c')
      endif
    endfunction
    set imstatusfunc=ImStatus
    function! ImStatus() abort
      return system('fcitx-remote')[0] is# '2'
    endfunction
  endif
endif
