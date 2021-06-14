let g:floaterm_height = 0.8
let g:floaterm_width = 0.8
let g:floaterm_autoinsert = v:false

nnoremap <terminal>   <Nop>
nmap    <C-z> <terminal>
nnoremap <terminal>  <Cmd>FloatermToggle --name='floaterm'<CR>
nnoremap <terminal><C-z> <Cmd>FloatermToggle --name='floaterm'<CR>
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

function s:open_in_normal_window() abort
  let l:f = findfile(expand('<cfile>'))
  let l:num = matchstr(expand('<cWORD>'), expand('<cfile>') .. ':' .. '\zs\d*\ze')
  if !empty(f) && has_key(nvim_win_get_config(win_getid()), 'anchor')
    FloatermHide
    execute 'e ' . l:f
    if !empty(num)
      execute l:num
    endif
  endif
endfunction

augroup vimrc_floaterm
  autocmd!
  autocmd User FloatermOpen nnoremap <buffer> <silent> <Esc> <Cmd>FloatermToggle<CR>
  autocmd User FloatermOpen tnoremap <buffer> <silent> <C-z> <C-\><C-n>:FloatermToggle<CR>
  autocmd User FloatermOpen tnoremap <buffer> <silent> <F1> <C-\><C-n>:FloatermNew<CR>
  autocmd User FloatermOpen tnoremap <buffer> <silent> <F2> <C-\><C-n>:FloatermPrev<CR>
  autocmd User FloatermOpen tnoremap <buffer> <silent> <F3> <C-\><C-n>:FloatermNext<CR>
  autocmd QuitPre * FloatermKill!
  autocmd FileType floaterm nnoremap <silent><buffer> gf :call <SID>open_in_normal_window()<CR>
  autocmd TermOpen,TermEnter term://*/zsh startinsert
augroup END
