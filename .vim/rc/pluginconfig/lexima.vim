function! s:lexima_my_settings() abort
  call lexima#add_rule({'at': '\%#.*[-0-9a-zA-Z_,:]', 'char': '(', 'input': '('})
  call lexima#add_rule({'at': '\%#.*[-0-9a-zA-Z_,:]', 'char': '[', 'input': '['})
  call lexima#add_rule({'at': '\%#.*[-0-9a-zA-Z_,:]', 'char': '{', 'input': '{'})
  call lexima#add_rule({'at': '\%#.*[-0-9a-zA-Z_,:]', 'char': '"', 'input': '"'})
  call lexima#add_rule({'at': '\%#.*[-0-9a-zA-Z_,:]', 'char': '''', 'input': ''''})
  call lexima#add_rule({'at': '\%#.*[-0-9a-zA-Z_,:]', 'char': '`', 'input': '`'})
  call lexima#add_rule({'at': '\%#\n\s*}', 'char': '}', 'input': '}', 'delete': '}'})
endfunction

augroup vimrc_lexima
  autocmd!
  autocmd VimEnter * call s:lexima_my_settings()
augroup END
