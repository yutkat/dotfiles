
"==============================================================
"          Initial Configuration                            {{{
"==============================================================

if has('unix')
  let $LANG = 'C'
else
  let $LANG = 'en'
endif
execute 'language ' $LANG
execute 'set langmenu='.$LANG
" Encode Settings
set encoding=utf-8
set fileencodings=ucs-bom,utf-8,euc-jp,iso-2022-jp,cp932,sjis,latin1
set fileformats=unix,dos,mac
scriptencoding utf-8

" fzf boarder bug
" if exists('&ambiwidth')
"   set ambiwidth=double
" endif

" }}}

