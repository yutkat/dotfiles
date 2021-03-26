

"==============================================================
"          Statusline                                       {{{
"==============================================================

" ステータスライン関連
set laststatus=2
set shortmess=aItToOF
"set cmdheight=2

" use plugin

""set statusline=%t\ %m%r%h%w[%Y][%{&fenc}][%{&ff}]<%F>%=%c,%l%11p%%
""set statusline=%<[%n]%m%r%h%w%{'['.(&fenc!=''?&fenc:&enc).':'.&ff.']'}%y\ %F%=%l,%c%V%8P
"" ステータスラインの表示
"  set statusline=%<     " 行が長すぎるときに切り詰める位置
"  set statusline+=[%n]  " バッファ番号
"  set statusline+=%m    " %m 修正フラグ
"  set statusline+=%r    " %r 読み込み専用フラグ
"
"  set statusline+=%h    " %h ヘルプバッファフラグ
"  set statusline+=%w    " %w プレビューウィンドウフラグ
"  set statusline+=%{'['.(&fenc!=''?&fenc:&enc).':'.&ff.']'}  " fencとffを表示
"  set statusline+=%y    " バッファ内のファイルのタイプ
"  set statusline+=\     " 空白スペース
"if winwidth(0) >= 130
"  set statusline+=%F    " バッファ内のファイルのフルパス
"else
"  set statusline+=%t    " ファイル名のみ
"endif
"  set statusline+=%=    " 左寄せ項目と右寄せ項目の区切り
"  set statusline+=%{exists('g:loaded_fugitive')?fugitive#statusline():''} " Gitブランチ名を表示
"  set statusline+=\ \   " 空白スペース2個
"  set statusline+=%1l   " 何行目にカーソルがあるか
"  set statusline+=/
"  set statusline+=%L    " バッファ内の総行数
"  set statusline+=,
"  set statusline+=%c    " 何列目にカーソルがあるか
"  set statusline+=%V    " 画面上の何列目にカーソルがあるか
"  set statusline+=\ \   " 空白スペース2個
"  set statusline+=%P    " ファイル内の何％の位置にあるか

" jamessan's
"set statusline=   " clear the statusline for when vimrc is reloaded
"set statusline+=%-3.3n\                      " buffer number
"set statusline+=%f\                          " file name
"set statusline+=%h%m%r%w                     " flags
"set statusline+=[%{strlen(&ft)?&ft:'none'},  " filetype
"set statusline+=%{strlen(&fenc)?&fenc:&enc}, " encoding
"set statusline+=%{&fileformat}]              " file format
"set statusline+=%=                           " right align
"set statusline+=%{synIDattr(synID(line('.'),col('.'),1),'name')}\  " highlight
"set statusline+=%b,0x%-8B\                   " current char
"set statusline+=%-14.(%l,%c%V%)\ %<%P        " offset

" }}}

