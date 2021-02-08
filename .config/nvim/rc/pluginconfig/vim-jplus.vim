" J の挙動を jplus.vim で行う
nmap gJ <Plug>(jplus)
vmap gJ <Plug>(jplus)
" getchar() を使用して挿入文字を入力します
" nmap <Leader>J <Plug>(jplus-getchar)
" vmap <Leader>J <Plug>(jplus-getchar)
" input() を使用したい場合はこちらを使用して下さい
nmap <Leader>J <Plug>(jplus-input)
vmap <Leader>J <Plug>(jplus-input)
" <Plug>(jplus-getchar) 時に左右に空白文字を入れたい場合
" %d は入力した結合文字に置き換えられる
let g:jplus#config = {
      \   '_' : {
      \       'delimiter_format' : '%d'
      \   }
      \}
