if exists('g:loaded_confirm_quit')
  finish
endif
let g:loaded_confirm_quit = 1

function! s:confirm_quit()
  if (len(filter(nvim_list_wins(), {k,v->nvim_win_get_config(v).relative==""}))==1 && tabpagenr('$')==1)
    if (confirm("Do you want to quit?", "&Yes\n&No", 2)!=1)
      return
    endif
  endif
  quit
endfunction

cabbrev q  <Cmd>call <SID>confirm_quit()<CR>
cabbrev qq  quit
command! Q qall

