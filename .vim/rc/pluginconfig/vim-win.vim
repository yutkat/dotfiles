nmap <leader>- <plug>WinWin
command! Win :call win#Win()
let g:win_ext_command_map = {"\<cr>": 'Win#exit'}
