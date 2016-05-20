
"==============================================================
"          Initial Configuration                            {{{
"==============================================================

set nocompatible            " 必ず最初に書く
if has('unix')
  let $LANG = "C"
else
  let $LANG = "en"
endif
execute "language " $LANG
execute "set langmenu=".$LANG
let mapleader = "\<Space>"
let maplocalleader = "\\"

" }}}

