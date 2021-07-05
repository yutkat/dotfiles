" nmap p <plug>(YoinkPaste_p)
" nmap P <plug>(YoinkPaste_P)
" nmap <C-p> <plug>(YoinkPostPasteSwapBack)
" nmap <C-n> <plug>(YoinkPostPasteSwapForward)
nmap <expr> p yoink#canSwap() ? '<plug>(YoinkPostPasteSwapBack)' : '<plug>(YoinkPaste_p)'
nmap <expr> P yoink#canSwap() ? '<plug>(YoinkPostPasteSwapForward)' : '<plug>(YoinkPaste_P)'

let g:yoinkMaxItems=100
