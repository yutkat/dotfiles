if !executable('ctags')
  let g:gen_tags#ctags_auto_gen = 1
endif
if !executable('gtags')
  let g:loaded_gentags#gtags = 1
endif
let g:gen_tags#gtags_default_map = 0
