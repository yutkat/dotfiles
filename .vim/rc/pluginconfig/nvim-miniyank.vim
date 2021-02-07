let g:miniyank_filename = $HOME.'/.cache/miniyank.mpack'
if exists('*trim')
  let s:miniyank_filename_size = trim(system('du ' . g:miniyank_filename . ' | cut -f1'))
  if s:miniyank_filename_size > 1000
    echom 'Remove large miniyank.mpack file: ' . s:miniyank_filename_size . '[KB]'
    call system('rm -f ' . g:miniyank_filename)
  endif
endif
let g:miniyank_maxitems = 100
map p <Plug>(miniyank-autoput)
map P <Plug>(miniyank-autoPut)
map <LocalLeader>p <Plug>(miniyank-startput)
map <LocalLeader>P <Plug>(miniyank-startPut)
nmap <C-p> <Plug>(miniyank-cycle)
nmap <C-n> <Plug>(miniyank-cycleback)
