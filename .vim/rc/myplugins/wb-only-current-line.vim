if exists('g:loaded_wb_only_current_line')
	finish
endif
let g:loaded_wb_only_current_line = 1

" Override w motion
function! MywMotion(mode)
    " Save the initial position
    if a:mode ==# 'v'
      normal! gv
    endif

    let initialLine=line('.')

    " Execute the builtin word motion and get the new position
    normal! w
    let newLine=line('.')

    " If the line as changed go back to the previous line
    if initialLine != newLine
        normal k$
    endif
endfunction

" Override b motion
function! MybMotion(mode)
    " Save the initial position
    if a:mode ==# 'v'
      normal! gv
    endif

    let initialLine=line('.')

    " Execute the builtin word motion and get the new position
    normal! b
    let newLine=line('.')

    " If the line as changed go back to the previous line
    if initialLine != newLine
        normal j^
    endif
endfunction

" Override W motion
function! MyWMotion(mode)
    " Save the initial position
    if a:mode ==# 'v'
      normal! gv
    endif

    let initialLine=line('.')

    " Execute the builtin word motion and get the new position
    normal! W
    let newLine=line('.')

    " If the line as changed go back to the previous line
    if initialLine != newLine
        normal k$
    endif
endfunction

" Override B motion
function! MyBMotion(mode)
    " Save the initial position
    if a:mode ==# 'v'
      normal! gv
    endif

    let initialLine=line('.')

    " Execute the builtin word motion and get the new position
    normal! B
    let newLine=line('.')

    " If the line as changed go back to the previous line
    if initialLine != newLine
        normal j^
    endif
endfunction

nnoremap <silent> w :<C-u>call MywMotion('n')<CR>
nnoremap <silent> b :<C-u>call MybMotion('n')<CR>
nnoremap <silent> W :<C-u>call MyWMotion('n')<CR>
nnoremap <silent> B :<C-u>call MyBMotion('n')<CR>
vnoremap <silent> w :<C-u>call MywMotion('v')<CR>
vnoremap <silent> b :<C-u>call MybMotion('v')<CR>
vnoremap <silent> W :<C-u>call MyWMotion('v')<CR>
vnoremap <silent> B :<C-u>call MyBMotion('v')<CR>
