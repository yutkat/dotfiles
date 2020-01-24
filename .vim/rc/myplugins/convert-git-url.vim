if exists('g:loaded_convert_git_url')
	finish
endif
let g:loaded_convert_git_url = 1

" Convert git url
function! ConvertGitUrl() abort
  let l:cur = expand("<cWORD>")
  if match(l:cur, '^git@') !=# -1
    echo l:cur
    s#git@github.com:#https://github.com/
  elseif match(l:cur, '^http') !=# -1
    echo l:cur
    s#https://github.com/#git@github.com:
  endif
endfunction

command! ConvertGitUrl :call ConvertGitUrl()
