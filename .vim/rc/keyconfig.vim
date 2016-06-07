
"==============================================================
"          Key config                                       {{{
"==============================================================

set <S-F1>=[1;2P
set <S-F2>=[1;2Q
set <S-F3>=[1;2R
set <S-F4>=[1;2S

if &term =~ "screen*"
  set <C-Left>=[1;5D
  set <C-Right>=[1;5C
  " noremap <Esc>[1;5D <C-Left>
  " noremap <Esc>[1;5C <C-Right>
  " noremap! <Esc>[1;5D <C-Left>
  " noremap! <Esc>[1;5C <C-Right>
endif

" Enable metakey
"execute "set <M-p>=\ep"
"execute "set <M-n>=\en"

