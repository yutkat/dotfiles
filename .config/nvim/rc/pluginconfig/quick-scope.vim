nmap <leader>qs <plug>(QuickScopeToggle)
xmap <leader>qs <plug>(QuickScopeToggle)
let g:qs_max_chars = 100
let g:qs_lazy_highlight = 0
let g:qs_delay = 300
augroup vimrc_quick_scope
  autocmd!
  autocmd FileType nerdtree,buffergator,tagbar,qf let b:qs_local_disable=1
augroup END
