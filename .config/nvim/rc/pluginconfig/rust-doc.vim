let g:rust_doc#define_map_K = 0
augroup vimrc_rust_doc
  autocmd!
  autocmd FileType rust nnoremap <buffer> <C-S-F1> <Cmd>RustDocsCurrentWord<CR>
augroup END
