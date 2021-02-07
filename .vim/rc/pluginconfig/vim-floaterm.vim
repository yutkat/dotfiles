let g:floaterm_height = 0.8
let g:floaterm_width = 0.8

nnoremap <terminal>   <Nop>
nmap    <C-z> <terminal>
nnoremap <terminal>  <Cmd>FloatermToggle<CR>
nnoremap <terminal><C-z> <Cmd>FloatermToggle<CR>
nnoremap <terminal>a <Cmd>FloatermNew<CR>
nnoremap <terminal>p <Cmd>FloatermPrev<CR>
nnoremap <terminal>n <Cmd>FloatermNext<CR>
nnoremap <terminal>l <Cmd>FloatermLast<CR>
      nnoremap <silent>   <F7>    :FloatermNew<CR>
      tnoremap <silent>   <F7>    <C-\><C-n>:FloatermNew<CR>
      nnoremap <silent>   <F8>    :FloatermPrev<CR>
      tnoremap <silent>   <F8>    <C-\><C-n>:FloatermPrev<CR>
      nnoremap <silent>   <F9>    :FloatermNext<CR>
      tnoremap <silent>   <F9>    <C-\><C-n>:FloatermNext<CR>
command! Wqa execute ':FloatermKill!' | wqa
cnoreabbrev wqa Wqa
augroup vimrc_floaterm
  autocmd!
  autocmd User FloatermOpen nnoremap <buffer> <silent> <Esc> <Cmd>FloatermToggle<CR>
  autocmd User FloatermOpen tnoremap <buffer> <silent> <C-z> <C-\><C-n>:FloatermToggle<CR>
  autocmd User FloatermOpen tnoremap <buffer> <silent> <F1> <C-\><C-n>:FloatermNew<CR>
  autocmd User FloatermOpen tnoremap <buffer> <silent> <F2> <C-\><C-n>:FloatermPrev<CR>
  autocmd User FloatermOpen tnoremap <buffer> <silent> <F3> <C-\><C-n>:FloatermNext<CR>
  autocmd QuitPre * FloatermKill!
augroup END
