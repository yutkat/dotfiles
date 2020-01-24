if exists('g:loaded_toggle_relative_number')
	finish
endif
let g:loaded_toggle_relative_number = 1


" line number toggle by mopp
function! s:toggle_relative_number() abort
    let b:relnum = !get(b:, 'relnum', 1)

    if b:relnum
        setlocal relativenumber
    else
        setlocal norelativenumber
    endif

    setlocal number
endfunction

command! ToggleRelativeNumber call s:toggle_relative_number()
