
if exists('g:loaded_hexedit')
	finish
endif
let g:loaded_hexedit= 1

function! s:split_16_byte() abort
  while len(expand("<cword>")) != 0
    let cur = line('.')
    normal! 016W
    if line('.') != cur
      break
    endif
    normal! i
  endwhile
endfunction

command! -bar -range=% HexSplit16BytePerLine :call s:split_16_byte()
command! -bar -range=% HexAdd0x :'<,'>s/\%V\(\w\)\(\w\)/0x\1\2/g
command! -bar -range=% AddCommaEachWord :'<,'>s/\%V\(\<\w*\>\)/\1\,/g
command! -bar -range=% ConvertHexForProg '<,'>HexAdd0x | '<,'>AddCommaEachWord | '<,'>HexSplit16BytePerLine


