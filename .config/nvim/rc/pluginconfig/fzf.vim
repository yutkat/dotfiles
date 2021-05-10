function! s:build_quickfix_list(lines)
  call setqflist(map(copy(a:lines), '{ "filename": v:val }'))
  copen
  cc
endfunction

let g:fzf_action = {
      \ 'ctrl-q': function('s:build_quickfix_list'),
      \ 'ctrl-t': 'tab split',
      \ 'ctrl-s': 'split',
      \ 'ctrl-x': 'split',
      \ 'ctrl-v': 'vsplit' }

augroup vimrc_fzf
  autocmd!
  autocmd FileType fzf tnoremap <silent> <buffer> <Esc> <C-g>
augroup END

command! -bar -bang FZFMapsN call fzf#vim#maps("n", <bang>0)
command! -bar -bang FZFMapsI call fzf#vim#maps("i", <bang>0)
command! -bar -bang FZFMapsX call fzf#vim#maps("x", <bang>0)
command! -bar -bang FZFMapsO call fzf#vim#maps("o", <bang>0)
command! -bar -bang FZFMapsV call fzf#vim#maps("v", <bang>0)
