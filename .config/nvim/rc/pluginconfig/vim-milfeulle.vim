nmap <S-F2> <Plug>(milfeulle-prev)
nmap <S-F3> <Plug>(milfeulle-next)
nmap <C-a> <Plug>(milfeulle-prev)
nmap <C-g> <Plug>(milfeulle-next)
nmap [j <Plug>(milfeulle-prev)
nmap ]j <Plug>(milfeulle-next)
let g:milfeulle_default_kind = 'buffer'
let g:milfeulle_default_jumper_name = 'win_tab_bufnr_pos'

augroup vimrc_milfeulle
	autocmd!
	" autocmd TextChanged,CursorMoved * :MilfeulleOverlay
	autocmd BufWinEnter,TextChanged * :MilfeulleOverlay
augroup END
