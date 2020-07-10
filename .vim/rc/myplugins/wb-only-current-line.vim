if exists('g:loaded_wb_only_current_line')
	finish
endif
let g:loaded_wb_only_current_line = 1

" Override w motion
function! MyOnelineMotion(mode, motion, back_motion)
    if v:count
      execute "normal! " . v:count . a:motion
      return
    endif
    " Save the initial position
    if a:mode ==# 'v'
      normal! gv
    endif

    let initialLine=line('.')

    " Execute the builtin word motion and get the new position
    execute "normal! " . a:motion
    let newLine=line('.')

    " If the line as changed go back to the previous line
    if initialLine != newLine
        execute "normal! " . a:back_motion
    endif
endfunction

nnoremap <silent> w :<C-u>call MyOnelineMotion('n', 'w', 'k$')<CR>
nnoremap <silent> W :<C-u>call MyOnelineMotion('n', 'W', 'k$')<CR>
nnoremap <silent> w :<C-u>call MyOnelineMotion('v', 'w', 'k$')<CR>
nnoremap <silent> W :<C-u>call MyOnelineMotion('v', 'W', 'k$')<CR>
nnoremap <silent> b :<C-u>call MyOnelineMotion('n', 'b', 'j^')<CR>
nnoremap <silent> B :<C-u>call MyOnelineMotion('n', 'B', 'j^')<CR>
nnoremap <silent> b :<C-u>call MyOnelineMotion('v', 'b', 'j^')<CR>
nnoremap <silent> B :<C-u>call MyOnelineMotion('v', 'B', 'j^')<CR>
