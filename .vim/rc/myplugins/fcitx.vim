if has('has')
  if executable('fcitx-remote')
    set iminsert=2
    set imsearch=2
    set imcmdline
    set imactivatefunc=ImActivate
    function! ImActivate(active)
      if a:active
        call system('fcitx-remote -o')
      else
        call system('fcitx-remote -c')
      endif
    endfunction
    set imstatusfunc=ImStatus
    function! ImStatus()
      return system('fcitx-remote')[0] is# '2'
    endfunction
  endid
endif
