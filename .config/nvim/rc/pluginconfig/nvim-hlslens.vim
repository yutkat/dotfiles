noremap n <Cmd>execute('normal! ' . v:count1 . 'n')<CR>
      \<Cmd>lua require('hlslens').start()<CR>
noremap N <Cmd>execute('normal! ' . v:count1 . 'N')<CR>
      \<Cmd>lua require('hlslens').start()<CR>

if IsPluginInstalled('vim-asterisk')
  map *  <Plug>(asterisk-z*)<Cmd>lua require('hlslens').start()<CR>
  " map #  <Plug>(asterisk-z#)<Cmd>lua require('hlslens').start()<CR>
  map g* <Plug>(asterisk-gz*)<Cmd>lua require('hlslens').start()<CR>
  map g# <Plug>(asterisk-gz#)<Cmd>lua require('hlslens').start()<CR>
else
  noremap * *<Cmd>lua require('hlslens').start()<CR>
  " noremap # #<Cmd>lua require('hlslens').start()<CR>
  noremap g* g*<Cmd>lua require('hlslens').start()<CR>
endif
