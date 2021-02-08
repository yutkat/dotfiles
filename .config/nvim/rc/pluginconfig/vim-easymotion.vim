nnoremap <easymotion>   <Nop>
nmap    S <easymotion>
" Disable default mappings
" If you are true vimmer, you should explicitly map keys by yourself.
" Do not rely on default bidings.
let g:EasyMotion_do_mapping = 0

" Or map prefix key at least(Default: <Leader><Leader>)
" map <Leader> <Plug>(easymotion-prefix)

" Jump to anywhere you want by just `4` or `3` key strokes without thinking!
" `s{char}{char}{target}`
nmap <easymotion>j <Plug>(easymotion-s2)
xmap <easymotion>j <Plug>(easymotion-s2)
" nmap ss <Plug>(easymotion-s2)
" xmap ss <Plug>(easymotion-s2)
omap z <Plug>(easymotion-s2)
" Of course, you can map to any key you want such as `<Space>`
" map <Space>(easymotion-s2)

" Turn on case sensitive feature
"let g:EasyMotion_smartcase = 1

" `JK` Motions: Extend line motions
" use relativenumber
"map <Leader>j <Plug>(easymotion-j)
"map <Leader>k <Plug>(easymotion-k)
" keep cursor column with `JK` motions
let g:EasyMotion_startofline = 0

let g:EasyMotion_keys='hjklasdfgyuiopqwertnmzxcvbHJKLASDFGYUIOPQWERTNMZXCVB'
" Show target key with upper case to improve readability
"let g:EasyMotion_use_upper = 1
" Jump to first match with enter & space
let g:EasyMotion_enter_jump_first = 1
let g:EasyMotion_space_jump_first = 1

" Extend search motions with vital-over command line interface
" Incremental highlight of all the matches
" Now, you don't need to repetitively press `n` or `N` with EasyMotion feature
" `<Tab>` & `<S-Tab>` to scroll up/down a page with next match
" :h easymotion-command-line
nmap <easymotion>/ <Plug>(easymotion-sn)
xmap <easymotion>/ <Plug>(easymotion-sn)
omap <easymotion>/ <Plug>(easymotion-tn)

" 1 ストローク選択を優先する
let g:EasyMotion_grouping=1

" カラー設定変更
" hi EasyMotionTarget ctermbg=NONE ctermfg=red guifg=#E4E500
" hi EasyMotionShade  ctermbg=NONE ctermfg=blue guifg=#444444
hi link EasyMotionTarget ErrorMsg
hi link EasyMotionShade  LineNr

" <Leader>f{char} to move to {char}
"map  <Leader>f <Plug>(easymotion-bd-f)
"nmap <Leader>f <Plug>(easymotion-overwin-f)
" s{char}{char} to move to {char}{char}
"nmap s <Plug>(easymotion-overwin-f2)
" Move to line
map <easymotion>k <Plug>(easymotion-bd-jk)
nmap <easymotion>k <Plug>(easymotion-overwin-line)
" Move to word
map  <easymotion>S <Plug>(easymotion-bd-w)
map  <easymotion>w <Plug>(easymotion-bd-w)

" etc
map <easymotion>. <Plug>(easymotion-repeat)
