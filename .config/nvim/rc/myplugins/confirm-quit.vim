if exists('g:loaded_confirm_quit')
  finish
endif
let g:loaded_confirm_quit = 1

function! ConfirmQuit()
  if (len(filter(nvim_list_wins(), {k,v->nvim_win_get_config(v).relative==""}))==1 && tabpagenr('$')==1)
    if (confirm("Do you want to quit?", "&Yes\n&No", 2)!=1)
      return
    endif
  endif
  quit
endfunction

command! ConfirmQuit call ConfirmQuit()
cnoreabbrev q ConfirmQuit<CR>
cnoreabbrev qq  quit
command! Q qall

augroup confirm_quit
  autocmd!
  autocmd CmdlineEnter : let s:isk_save = &l:iskeyword | setlocal iskeyword+=!
  autocmd CmdlineLeave : let &l:iskeyword = s:isk_save
augroup END
