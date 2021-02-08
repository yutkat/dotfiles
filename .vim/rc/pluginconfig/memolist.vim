let g:memolist_path = $HOME . '/.memo'
let g:memolist_memo_suffix = 'md'
let g:memolist_fzf = 1
command! MemoListSort silent! call fzf#run(fzf#wrap({'source': "find " . g:memolist_path . " -type f -printf '%T@ %p\n' | sort -k 1 -nr | sed 's/^[^ ]* //'"}))
