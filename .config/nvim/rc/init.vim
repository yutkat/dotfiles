
"==============================================================
"          Initial Configuration                            {{{
"==============================================================

if has('unix')
  let $LANG = 'en_US.UTF-8'
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

let g:loaded_2html_plugin      = 1
let g:loaded_logiPat           = 1
let g:loaded_getscriptPlugin   = 1
let g:loaded_gzip              = 1
let g:loaded_man               = 1
let g:loaded_matchit           = 1
let g:loaded_matchparen        = 1
let g:loaded_netrwFileHandlers = 1
let g:loaded_netrwPlugin       = 1
let g:loaded_netrwSettings     = 1
let g:loaded_rrhelper          = 1
let g:loaded_shada_plugin      = 1
let g:loaded_spellfile_plugin  = 1
let g:loaded_tarPlugin         = 1
let g:loaded_tutor_mode_plugin = 1
let g:loaded_vimballPlugin     = 1
let g:loaded_zipPlugin         = 1

" fzf boarder bug
" if exists('&ambiwidth')
"   set ambiwidth=double
" endif

" }}}

