
if exists('g:loaded_hexedit')
	finish
endif
let g:loaded_hexedit= 1

function! s:split_16_byte() abort
  let i = 0
  while expand("<cword>") != ''
    echo i
    echo expand("<cword>")
    let i = i + 1
    normal! 016Wi
  endwhile
endfunction

command! -range=% HexSplit16BytePerLine :call s:split_16_byte()
command! -range=% HexAdd0x :'<,'>s/\%V\(\w\)\(\w\)/0x\1\2/g
command! -range=% AddCommaEachWord :'<,'>s/\%V\(\<\w*\>\)/\1\,/g


