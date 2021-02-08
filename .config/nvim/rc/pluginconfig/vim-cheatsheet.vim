let s:cache_file_dir = expand('~/.cache/nvim/files/')
if !isdirectory(s:cache_file_dir)
  call system('mkdir -p ' . s:cache_file_dir)
endif
let g:cheatsheet#cheat_file = expand(s:cache_file_dir . 'cheatsheet.md')
command! CheatUpdate call system("curl -Ls https://raw.githubusercontent.com/yutakatay/katapedia/master/doc/Vim.md -o " . g:cheatsheet#cheat_file)
