let g:git_messenger_no_default_mappings = v:true
nmap [git]m <Plug>(git-messenger)
function! s:setup_gitmessengerpopup() abort
  nmap <buffer><Esc> q
endfunction
augroup vimrc_git_messenger
  autocmd FileType gitmessengerpopup call <SID>setup_gitmessengerpopup()
augroup END
