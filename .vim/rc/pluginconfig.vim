
"--------------------------------------------------------------
"          Plugin Settings                                  {{{
"--------------------------------------------------------------

" plugin installed check
let s:plug = { "plugs": get(g:, 'plugs', {}) }
function! s:plug.is_installed(name)
  return has_key(self.plugs, a:name) ? isdirectory(self.plugs[a:name].dir) : 0
endfunction

" ======== matchit.vim ======== "
" Load matchit.vim, but only if the user hasn't installed a newer version.
if !exists('g:loaded_matchit') && findfile('plugin/matchit.vim', &rtp) ==# ''
  runtime! macros/matchit.vim
endif

" ======== neocomplete ======== "
if s:plug.is_installed('neocomplete.vim')
  " 新しく追加した neocomplete の設定
  ""Note: This option must set it in .vimrc(_vimrc).  NOT IN .gvimrc(_gvimrc)!
  " Disable AutoComplPop.
  let g:acp_enableAtStartup = 0
  " Use neocomplete.
  let g:neocomplete#enable_at_startup = 1
  " Use smartcase.
  let g:neocomplete#enable_smart_case = 1
  " Set minimum syntax keyword length.
  let g:neocomplete#sources#syntax#min_keyword_length = 3
  let g:neocomplete#lock_buffer_name_pattern = '\*ku\*'

  " Define dictionary.
  let g:neocomplete#sources#dictionary#dictionaries = {
        \ 'default' : '',
        \ 'vimshell' : $HOME.'/.vimshell_hist',
        \ 'scheme' : $HOME.'/.gosh_completions'
        \ }

  " Define keyword.
  if !exists('g:neocomplete#keyword_patterns')
    let g:neocomplete#keyword_patterns = {}
  endif
  let g:neocomplete#keyword_patterns['default'] = '\h\w*'

  " Plugin key-mappings.
  inoremap <expr><C-g>     neocomplete#undo_completion()
  inoremap <expr><C-l>     neocomplete#complete_common_string()
  " Recommended key-mappings.
  " <CR>: close popup and save indent.
  inoremap <silent> <CR> <C-r>=<SID>my_cr_function()<CR>
  function! s:my_cr_function()
    "return neocomplete#close_popup() . "\<CR>"
    " For no inserting <CR> key.
    return pumvisible() ? neocomplete#close_popup() : "\<CR>"
  endfunction
  " <TAB>: completion.
  inoremap <expr><TAB>  pumvisible() ? "\<C-n>" : "\<TAB>"
  inoremap <expr><S-TAB>  pumvisible() ? "\<C-p>" : "\<S-TAB>"
  " <C-h>, <BS>: close popup and delete backword char.
  inoremap <expr><C-h> neocomplete#smart_close_popup()."\<C-h>"
  inoremap <expr><BS> neocomplete#smart_close_popup()."\<C-h>"
  inoremap <expr><C-y>  neocomplete#close_popup()
  inoremap <expr><C-e>  neocomplete#cancel_popup()
  " Close popup by <Space>.
  "inoremap <expr><Space> pumvisible() ? neocomplete#close_popup() : "\<Space>"

  " For cursor moving in insert mode(Not recommended)
  "inoremap <expr><Left>  neocomplete#close_popup() . "\<Left>"
  "inoremap <expr><Right> neocomplete#close_popup() . "\<Right>"
  "inoremap <expr><Up>    neocomplete#close_popup() . "\<Up>"
  "inoremap <expr><Down>  neocomplete#close_popup() . "\<Down>"
  " Or set this.
  "let g:neocomplete#enable_cursor_hold_i = 1
  " Or set this.
  "let g:neocomplete#enable_insert_char_pre = 1

  " AutoComplPop like behavior.
  "let g:neocomplete#enable_auto_select = 1

  " Shell like behavior(not recommended).
  "set completeopt+=longest
  "let g:neocomplete#enable_auto_select = 1
  "let g:neocomplete#disable_auto_complete = 1
  "inoremap <expr><TAB>  pumvisible() ? "\<Down>" : "\<C-x>\<C-u>"

  " Enable omni completion.
  autocmd FileType css setlocal omnifunc=csscomplete#CompleteCSS
  autocmd FileType html,markdown setlocal omnifunc=htmlcomplete#CompleteTags
  autocmd FileType javascript setlocal omnifunc=javascriptcomplete#CompleteJS
  autocmd FileType python setlocal omnifunc=pythoncomplete#Complete
  autocmd FileType xml setlocal omnifunc=xmlcomplete#CompleteTags

  " Enable heavy omni completion.
  if !exists('g:neocomplete#sources#omni#input_patterns')
    let g:neocomplete#sources#omni#input_patterns = {}
  endif
  "let g:neocomplete#sources#omni#input_patterns.php = '[^. \t]->\h\w*\|\h\w*::'
  "let g:neocomplete#sources#omni#input_patterns.c = '[^.[:digit:] *\t]\%(\.\|->\)'
  "let g:neocomplete#sources#omni#input_patterns.cpp = '[^.[:digit:] *\t]\%(\.\|->\)\|\h\w*::'

  " For perlomni.vim setting.
  " https://github.com/c9s/perlomni.vim
  let g:neocomplete#sources#omni#input_patterns.perl = '\h\w*->\h\w*\|\h\w*::'
  let g:neocomplete#force_overwrite_completefunc=1
  "
endif

" ======== neocomplcache ======== "
if s:plug.is_installed('neocomplcache.vim')
  let g:neocomplcache_max_list = 30
  let g:neocomplcache_auto_completion_start_length = 2
  let g:neocomplcache_force_overwrite_completefunc=1

  "Note: This option must set it in .vimrc(_vimrc).  NOT IN .gvimrc(_gvimrc)!
  " Disable AutoComplPop.
  let g:acp_enableAtStartup = 0
  " Use neocomplcache.
  let g:neocomplcache_enable_at_startup = 1
  " Use smartcase.
  let g:neocomplcache_enable_smart_case = 1
  " Set minimum syntax keyword length.
  let g:neocomplcache_min_syntax_length = 3
  let g:neocomplcache_lock_buffer_name_pattern = '\*ku\*'

  " Enable heavy features.
  " Use camel case completion.
  "let g:neocomplcache_enable_camel_case_completion = 1
  " Use underbar completion.
  "let g:neocomplcache_enable_underbar_completion = 1

  " Define dictionary.
  let g:neocomplcache_dictionary_filetype_lists = {
        \ 'default' : '',
        \ 'vimshell' : $HOME.'/.vimshell_hist',
        \ 'scheme' : $HOME.'/.gosh_completions'
        \ }

  " Define keyword.
  if !exists('g:neocomplcache_keyword_patterns')
    let g:neocomplcache_keyword_patterns = {}
  endif
  let g:neocomplcache_keyword_patterns['default'] = '\h\w*'

  " Plugin key-mappings.
  inoremap <expr><C-g>     neocomplcache#undo_completion()
  inoremap <expr><C-l>     neocomplcache#complete_common_string()

  " Recommended key-mappings.
  " <CR>: close popup and save indent.
  inoremap <silent> <CR> <C-r>=<SID>my_cr_function()<CR>
  function! s:my_cr_function()
    "return neocomplcache#smart_close_popup() . "\<CR>"
    " For no inserting <CR> key.
    return pumvisible() ? neocomplcache#close_popup() : "\<CR>"
  endfunction
  " <TAB>: completion.
  inoremap <expr><TAB>  pumvisible() ? "\<C-n>" : "\<TAB>"
  inoremap <expr><S-TAB>  pumvisible() ? "\<C-p>" : "\<S-TAB>"
  " <C-h>, <BS>: close popup and delete backword char.
  inoremap <expr><C-h> neocomplcache#smart_close_popup()."\<C-h>"
  inoremap <expr><BS> neocomplcache#smart_close_popup()."\<C-h>"
  inoremap <expr><C-y>  neocomplcache#close_popup()
  inoremap <expr><C-e>  neocomplcache#cancel_popup()
  " Close popup by <Space>.
  "inoremap <expr><Space> pumvisible() ? neocomplcache#close_popup() : "\<Space>"

  " For cursor moving in insert mode(Not recommended)
  "inoremap <expr><Left>  neocomplcache#close_popup() . "\<Left>"
  "inoremap <expr><Right> neocomplcache#close_popup() . "\<Right>"
  "inoremap <expr><Up>    neocomplcache#close_popup() . "\<Up>"
  "inoremap <expr><Down>  neocomplcache#close_popup() . "\<Down>"
  " Or set this.
  "let g:neocomplcache_enable_cursor_hold_i = 1
  " Or set this.
  "let g:neocomplcache_enable_insert_char_pre = 1

  " AutoComplPop like behavior.
  "let g:neocomplcache_enable_auto_select = 1

  " Shell like behavior(not recommended).
  "set completeopt+=longest
  "let g:neocomplcache_enable_auto_select = 1
  "let g:neocomplcache_disable_auto_complete = 1
  "inoremap <expr><TAB>  pumvisible() ? "\<Down>" : "\<C-x>\<C-u>"

  " Enable omni completion.
  autocmd FileType css setlocal omnifunc=csscomplete#CompleteCSS
  autocmd FileType html,markdown setlocal omnifunc=htmlcomplete#CompleteTags
  autocmd FileType javascript setlocal omnifunc=javascriptcomplete#CompleteJS
  autocmd FileType python setlocal omnifunc=pythoncomplete#Complete
  autocmd FileType xml setlocal omnifunc=xmlcomplete#CompleteTags

  " Enable heavy omni completion.
  if !exists('g:neocomplcache_force_omni_patterns')
    let g:neocomplcache_force_omni_patterns = {}
  endif
  let g:neocomplcache_force_omni_patterns.php = '[^. \t]->\h\w*\|\h\w*::'
  let g:neocomplcache_force_omni_patterns.c = '[^.[:digit:] *\t]\%(\.\|->\)'
  let g:neocomplcache_force_omni_patterns.cpp = '[^.[:digit:] *\t]\%(\.\|->\)\|\h\w*::'

  " For perlomni.vim setting.
  " https://github.com/c9s/perlomni.vim
  let g:neocomplcache_force_omni_patterns.perl = '\h\w*->\h\w*\|\h\w*::'
endif

" ======== unite ======== "
if s:plug.is_installed('unite.vim')
  let g:unite_enable_start_insert=1
  let g:unite_source_file_mru_limit = 200
  " The prefix key.
  nnoremap    [unite]   <Nop>
  nmap    <Leader>u [unite]
  " unite.vim keymap
  let g:unite_source_history_yank_enable =1
  nnoremap <silent> [unite]u :<C-u>Unite<Space>file<CR>
  nnoremap <silent> [unite]g :<C-u>Unite<Space>grep<CR>
  nnoremap <silent> [unite]f :<C-u>Unite<Space>buffer<CR>
  nnoremap <silent> [unite]b :<C-u>Unite<Space>bookmark<CR>
  nnoremap <silent> [unite]a :<C-u>UniteBookmarkAdd<CR>
  nnoremap <silent> [unite]m :<C-u>Unite<Space>file_mru<CR>
  nnoremap <silent> [unite]h :<C-u>Unite<Space>history/yank<CR>
  nnoremap <silent> [unite]r :<C-u>Unite -buffer-name=register register<CR>
  nnoremap <silent> [unite]c :<C-u>UniteWithBufferDir -buffer-name=files file<CR>
  nnoremap <silent> ,vr :UniteResume<CR>
  " unite-build map
  nnoremap <silent> ,vb :Unite build<CR>
  nnoremap <silent> ,vcb :Unite build:!<CR>
  nnoremap <silent> ,vch :UniteBuildClearHighlight<CR>
  "let g:unite_source_grep_command = 'ag'
  "let g:unite_source_grep_default_opts = '--nocolor --nogroup'
  "let g:unite_source_grep_max_candidates = 200
  "let g:unite_source_grep_recursive_opt = ''
  " unite-grepの便利キーマップ
  vnoremap /g y:Unite grep::-iHRn:<C-R>=escape(@", '\\.*$^[]')<CR><CR>
endif

" ======== yankround ======== "
if s:plug.is_installed('yankround.vim')
  nmap p <Plug>(yankround-p)
  xmap p <Plug>(yankround-p)
  nmap P <Plug>(yankround-P)
  nmap gp <Plug>(yankround-gp)
  xmap gp <Plug>(yankround-gp)
  nmap gP <Plug>(yankround-gP)
  nmap <C-p> <Plug>(yankround-prev)
  nmap <C-n> <Plug>(yankround-next)
  let g:yankround_max_history = 100
  let g:yankround_dir = '~/.cache/yankround'
  nnoremap <silent>g<C-p> :<C-u>CtrlPYankRound<CR>
  "nnoremap <silent><SID>(ctrlp) :<C-u>CtrlP<CR>
  "nmap <expr><C-p> yankround#is_active() ? "\<Plug>(yankround-prev)" : "<SID>(ctrlp)"
endif

" ======== cscope  ======== "
if has("cscope")
  set nocst
  set csto=0
  set csre
  set nocsverb
  " add any database in current directory
  if filereadable("cscope.out")
    cs add cscope.out
    " else add database pointed to by environment
  elseif $CSCOPE_DB != ""
    cs add $CSCOPE_DB
  endif
  set csverb
  " To open quickfix annoying
  " set cscopequickfix=s-,c-,d-,i-,t-,e-
  nnoremap [cscope] <Nop>
  nmap <LocalLeader>c [cscope]
  nmap [cscope]s :cs find s <C-R>=expand("<cword>")<CR><CR>
  nmap [cscope]g :cs find g <C-R>=expand("<cword>")<CR><CR>
  nmap [cscope]c :cs find c <C-R>=expand("<cword>")<CR><CR>
  nmap [cscope]t :cs find t <C-R>=expand("<cword>")<CR><CR>
  nmap [cscope]e :cs find e <C-R>=expand("<cword>")<CR><CR>
  nmap [cscope]f :cs find f <C-R>=expand("<cfile>")<CR><CR>
  nmap [cscope]i :cs find i ^<C-R>=expand("<cfile>")<CR>$<CR>
  nmap [cscope]d :cs find d <C-R>=expand("<cword>")<CR><CR>
endif

" ======== NERDTree ======== "
if s:plug.is_installed('The-NERD-tree')
  let g:NERDTreeWinPos = "left"
  " Change IDE mode
  nnoremap <F12> :TagbarToggle<CR>:NERDTreeToggle<CR><C-w>l
endif

" ======== quickrun ======== "
if s:plug.is_installed('vim-quickrun')
  let g:quickrun_config = {
        \ "_": {
        \     "outputter" : "multi:buffer:quickfix",
        \     "outputter/buffer/split" : ":botright 8sp",
        \     "runner" : "vimproc",
        \     "runner/vimproc/updatetime" : 40,
        \   },
        \ "unite": {
        \     "hook/close_unite_quickfix/enable_hook_loaded" : 1,
        \     "hook/unite_quickfix/enable_failure" : 1,
        \     "hook/unite_quickfix/no_focus" : 0,
        \     "hook/unite_quickfix/unite_options" : "-no-start-insert -no-quit -direction=botright -winheight=12 -max-multi-lines=32",
        \     "hook/close_quickfix/enable_exit" : 1,
        \     "hook/close_buffer/enable_failure" : 1,
        \     "hook/close_buffer/enable_empty_data" : 1,
        \   },
        \ }
endif

" ======== watchdogs ======== "
if s:plug.is_installed('vim-watchdogs')
  let g:quickrun_config["watchdogs_checker/_"] = {
        \   "outputter/quickfix/open_cmd" : "",
        \   "hook/qfstatusline_update/enable_exit":   1,
        \   "hook/qfstatusline_update/priority_exit": 4,
        \ }
  " 書き込み後にシンタックスチェックを行う
  let g:watchdogs_check_BufWritePost_enable = 1
  let g:watchdogs_check_BufWritePost_enable_on_wq = 0
  call watchdogs#setup(g:quickrun_config)
  let g:Qfstatusline#Text=0
endif

" ======== Vimfiler ======== "
if s:plug.is_installed('vimfiler')
  let g:vimfiler_as_default_explorer = 1
endif

" ======== vim-quickhl ======== "
if s:plug.is_installed('vim-quickhl')
  nmap <Leader>m <Plug>(quickhl-manual-this)
  xmap <Leader>m <Plug>(quickhl-manual-this)
  nmap <Leader>M <Plug>(quickhl-manual-reset)
  xmap <Leader>M <Plug>(quickhl-manual-reset)
  nnoremap <silent> <C-L> :nohlsearch<C-R>=has('diff')?'<Bar>diffupdate':''<CR><CR>:QuickhlManualReset<CR><C-L>

  "nmap <LocalLeader>J <Plug>(quickhl-cword-toggle)
  "nmap <LocalLeader>] <Plug>(quickhl-tag-toggle)
  "map <LocalLeader>H <Plug>(operator-quickhl-manual-this-motion)
endif

" ======== vim-expand-region ======== "
if s:plug.is_installed('vim-expand-region')
  vmap v <Plug>(expand_region_expand)
  vmap <C-v> <Plug>(expand_region_shrink)
endif

" ======== vim-easy-align ======== "
if s:plug.is_installed('vim-easy-align')
  " Start interactive EasyAlign in visual mode (e.g. vip<Enter>)
  vmap <Enter> <Plug>(EasyAlign)
  " Start interactive EasyAlign for a motion/text object (e.g. gaip)
  nmap ga <Plug>(EasyAlign)
endif

" ======== The-NERD-Commenter ======== "
if s:plug.is_installed('The-NERD-Commenter')
  let NERDSpaceDelims = 1
  let NERDShutUp = 1
endif

" ======== vim-easymotion ======== "
if s:plug.is_installed('vim-easymotion')
  " Disable default mappings
  " If you are true vimmer, you should explicitly map keys by yourself.
  " Do not rely on default bidings.
  let g:EasyMotion_do_mapping = 0

  " Or map prefix key at least(Default: <Leader><Leader>)
  " map <Leader> <Plug>(easymotion-prefix)

  " Jump to anywhere you want by just `4` or `3` key strokes without thinking!
  " `s{char}{char}{target}`
  nmap s <Plug>(easymotion-s2)
  xmap s <Plug>(easymotion-s2)
  omap z <Plug>(easymotion-s2)
  " Of course, you can map to any key you want such as `<Space>`
  " map <Space>(easymotion-s2)

  " Turn on case sensitive feature
  let g:EasyMotion_smartcase = 1

  " `JK` Motions: Extend line motions
  map <Leader>j <Plug>(easymotion-j)
  map <Leader>k <Plug>(easymotion-k)
  " keep cursor column with `JK` motions
  let g:EasyMotion_startofline = 0

  let g:EasyMotion_keys='hjklasdfgyuiopqwertnmzxcvbHJKLASDFGYUIOPQWERTNMZXCVB'
  " Show target key with upper case to improve readability
  let g:EasyMotion_use_upper = 1
  " Jump to first match with enter & space
  let g:EasyMotion_enter_jump_first = 1
  let g:EasyMotion_space_jump_first = 1

  " Extend search motions with vital-over command line interface
  " Incremental highlight of all the matches
  " Now, you don't need to repetitively press `n` or `N` with EasyMotion feature
  " `<Tab>` & `<S-Tab>` to scroll up/down a page with next match
  " :h easymotion-command-line
  nmap g/ <Plug>(easymotion-sn)
  xmap g/ <Plug>(easymotion-sn)
  omap g/ <Plug>(easymotion-tn)

  " 1 ストローク選択を優先する
  let g:EasyMotion_grouping=1

  " カラー設定変更
  hi EasyMotionTarget ctermbg=none ctermfg=red
  hi EasyMotionShade  ctermbg=none ctermfg=blue
endif

" ======== vim-gitgutter ======== "
if s:plug.is_installed('vim-gitgutter')
  let g:gitgutter_sign_added = '+'
  let g:gitgutter_sign_modified = '~'
  let g:gitgutter_sign_removed = '-'
  let g:gitgutter_realtime = 500
  let g:gitgutter_eager = 500
endif

" ======== lightline ======== "
if s:plug.is_installed('lightline.vim')
  let g:lightline = {
        \ 'colorscheme': 'wombat',
        \ 'enable': {
        \   'statusline': 1,
        \   'tabline': 0,
        \ },
        \ 'active': {
        \   'left': [ [ 'mode', 'paste' ], [ 'fugitive', 'gitgutter', 'filename' ], ['ctrlpmark'] ],
        \   'right': [ [ 'syntaxcheck', 'lineinfo' ], ['percent'], [ 'fileformat', 'fileencoding', 'filetype' ] ]
        \ },
        \ 'component_function': {
        \   'fugitive': 'MyFugitive',
        \   'gitgutter': 'MyGitGutter',
        \   'filename': 'MyFilename',
        \   'fileformat': 'MyFileformat',
        \   'filetype': 'MyFiletype',
        \   'fileencoding': 'MyFileencoding',
        \   'mode': 'MyMode',
        \   'ctrlpmark': 'CtrlPMark',
        \ },
        \ 'component_expand': {
        \   'syntaxcheck': 'qfstatusline#Update',
        \ },
        \ 'component_type': {
        \   'syntaxcheck': 'error',
        \ },
        \ 'subseparator': { 'left': '|', 'right': '|' }
        \ }

  " syntastic
  "      \ 'component_expand': {
  "      \   'syntastic': 'SyntasticStatuslineFlag',
  "      \ },
  "      \ 'component_type': {
  "      \   'syntastic': 'error',
  "      \ },

  function! MyModified()
    return &ft =~ 'help' ? '' : &modified ? '+' : &modifiable ? '' : '-'
  endfunction

  function! MyReadonly()
    return &ft !~? 'help' && &readonly ? 'RO' : ''
  endfunction

  function! MyFilename()
    let fname = expand('%:t')
    return fname == 'ControlP' ? g:lightline.ctrlp_item :
          \ fname == '__Tagbar__' ? g:lightline.fname :
          \ fname =~ '__Gundo\|NERD_tree' ? '' :
          \ &ft == 'vimfiler' ? vimfiler#get_status_string() :
          \ &ft == 'unite' ? unite#get_status_string() :
          \ &ft == 'vimshell' ? vimshell#get_status_string() :
          \ ('' != MyReadonly() ? MyReadonly() . ' ' : '') .
          \ ('' != fname ? fname : '[No Name]') .
          \ ('' != MyModified() ? ' ' . MyModified() : '')
  endfunction

  function! MyFugitive()
    try
      if expand('%:t') !~? 'Tagbar\|Gundo\|NERD' && &ft !~? 'vimfiler' && exists('*fugitive#head')
        let mark = ''  " edit here for cool mark
        let _ = fugitive#head()
        return strlen(_) ? mark._ : ''
      endif
    catch
    endtry
    return ''
  endfunction

  function! MyFileformat()
    return winwidth(0) > 70 ? &fileformat : ''
  endfunction

  function! MyFiletype()
    return winwidth(0) > 70 ? (strlen(&filetype) ? &filetype : 'no ft') : ''
  endfunction

  function! MyFileencoding()
    return winwidth(0) > 70 ? (strlen(&fenc) ? &fenc : &enc) : ''
  endfunction

  function! MyMode()
    let fname = expand('%:t')
    return fname == '__Tagbar__' ? 'Tagbar' :
          \ fname == 'ControlP' ? 'CtrlP' :
          \ fname == '__Gundo__' ? 'Gundo' :
          \ fname == '__Gundo_Preview__' ? 'Gundo Preview' :
          \ fname =~ 'NERD_tree' ? 'NERDTree' :
          \ &ft == 'unite' ? 'Unite' :
          \ &ft == 'vimfiler' ? 'VimFiler' :
          \ &ft == 'vimshell' ? 'VimShell' :
          \ winwidth(0) > 60 ? lightline#mode() : ''
  endfunction

  function! CtrlPMark()
    if expand('%:t') =~ 'ControlP'
      call lightline#link('iR'[g:lightline.ctrlp_regex])
      return lightline#concatenate([g:lightline.ctrlp_prev, g:lightline.ctrlp_item
            \ , g:lightline.ctrlp_next], 0)
    else
      return ''
    endif
  endfunction

  function! MyGitGutter()
    if ! exists('*GitGutterGetHunkSummary')
          \ || ! get(g:, 'gitgutter_enabled', 0)
          \ || winwidth('.') <= 90
      return ''
    endif
    let symbols = [
          \ g:gitgutter_sign_added . ' ',
          \ g:gitgutter_sign_modified . ' ',
          \ g:gitgutter_sign_removed . ' '
          \ ]
    let hunks = GitGutterGetHunkSummary()
    let ret = []
    for i in [0, 1, 2]
      if hunks[i] > 0
        call add(ret, symbols[i] . hunks[i])
      endif
    endfor
    return join(ret, ' ')
  endfunction

  let g:ctrlp_status_func = {
        \ 'main': 'CtrlPStatusFunc_1',
        \ 'prog': 'CtrlPStatusFunc_2',
        \ }

  function! CtrlPStatusFunc_1(focus, byfname, regex, prev, item, next, marked)
    let g:lightline.ctrlp_regex = a:regex
    let g:lightline.ctrlp_prev = a:prev
    let g:lightline.ctrlp_item = a:item
    let g:lightline.ctrlp_next = a:next
    return lightline#statusline(0)
  endfunction

  function! CtrlPStatusFunc_2(str)
    return lightline#statusline(0)
  endfunction

  let g:tagbar_status_func = 'TagbarStatusFunc'

  function! TagbarStatusFunc(current, sort, fname, ...) abort
    let g:lightline.fname = a:fname
    return lightline#statusline(0)
  endfunction

  " augroup AutoSyntastic
  " autocmd!
  " autocmd BufWritePost *.c,*.cpp,*.cc call s:syntastic()
  " augroup END
  " function! s:syntastic()
  " SyntasticCheck
  " call lightline#update()
  " endfunction

  let g:Qfstatusline#UpdateCmd = function('lightline#update')
  let g:unite_force_overwrite_statusline = 0
  let g:vimfiler_force_overwrite_statusline = 0
  let g:vimshell_force_overwrite_statusline = 0
endif

" ======== vim-trailing-whitespace ======== "
if s:plug.is_installed('vim-trailing-whitespace')
  augroup TrailWhiteSpace
    autocmd!
    autocmd BufWritePre * :FixWhitespace
  augroup END
endif

" ======== incsearch.vim ======== "
if s:plug.is_installed('incsearch.vim')
  map /  <Plug>(incsearch-forward)
  map ?  <Plug>(incsearch-backward)
  map g/ <Plug>(incsearch-stay)

  augroup incsearch-keymap
    autocmd!
    autocmd VimEnter * call s:incsearch_keymap()
  augroup END
  function! s:incsearch_keymap()
    "IncSearchNoreMap <Right> <Over>(incsearch-next)
    "IncSearchNoreMap <Left>  <Over>(incsearch-prev)
    "IncSearchNoreMap <Down>  <Over>(incsearch-scroll-f)
    "IncSearchNoreMap <Up>    <Over>(incsearch-scroll-b)
    IncSearchNoreMap <Tab>   <Over>(buffer-complete)
    IncSearchNoreMap <S-Tab> <Over>(buffer-complete-prev)
  endfunction
endif

" ======== incsearch-fuzzy.vim ======== "
if s:plug.is_installed('incsearch-fuzzy.vim')
  map z/ <Plug>(incsearch-fuzzy-/)
  map z? <Plug>(incsearch-fuzzy-?)
  map zg/ <Plug>(incsearch-fuzzy-stay)
endif

" ======== vim-rooter ======== "
if s:plug.is_installed('vim-rooter')
  " Change only current window's directory
  let g:rooter_use_lcd = 1
  " To stop vim-rooter changing directory automatically
  let g:rooter_manual_only = 1
  " files/directories for the root directory
  let g:rooter_patterns = ['tags', '.git', '.git/', '_darcs/', '.hg/', '.bzr/', 'Makefile', 'GNUMakefile', 'GNUmakefile', '.svn/']
  " Automatically change the directory
  "autocmd! BufEnter *.c,*.cc,*.cxx,*.cpp,*.h,*.hh,*.java,*.py,*.sh,*.rb,*.html,*.css,*.js :Rooter
endif

" ======== vim-choosewin ======== "
if s:plug.is_installed('vim-choosewin')
  nmap  <Leader>-  <Plug>(choosewin)
  " オーバーレイ機能を有効にしたい場合
  let g:choosewin_overlay_enable          = 1
  " オーバーレイ・フォントをマルチバイト文字を含むバッファでも綺麗に表示する。
  let g:choosewin_overlay_clear_multibyte = 1
endif

" ======== vim-localvimrc ======== "
if s:plug.is_installed('vim-localvimrc')
  let g:localvimrc_persistent=1
  let g:localvimrc_sandbox=0
endif

" ======== vim-altr ======== "
if s:plug.is_installed('vim-altr')
  map <F2> <Plug>(altr-forward)
  map <F3> <Plug>(altr-back)
endif

" ======== vim-anzu ======== "
if s:plug.is_installed('vim-anzu')
  " mapping
  nmap n <Plug>(anzu-n-with-echo)
  nmap N <Plug>(anzu-N-with-echo)
  nmap * <Plug>(anzu-star-with-echo)
  nmap # <Plug>(anzu-sharp-with-echo)
  " clear status
  "nmap <Esc><Esc> <Plug>(anzu-clear-search-status)
  " statusline
  if exists('anzu#search_status')
    set statusline=%{anzu#search_status()}
  endif
  " if start anzu-mode key mapping
  " anzu-mode is anzu(12/51) in screen
  " nmap n <Plug>(anzu-mode-n)
  " nmap N <Plug>(anzu-mode-N)
  let g:anzu_bottomtop_word = "search hit BOTTOM, continuing at TOP"
  let g:anzu_topbottom_word = "search hit TOP, continuing at BOTTOM"
  let g:anzu_status_format = "%p(%i/%l) %#WarningMsg#%w"
endif

" ======== neosnippet ======== "
if s:plug.is_installed('neosnippet')
  " Plugin key-mappings.
  imap <C-k>     <Plug>(neosnippet_expand_or_jump)
  smap <C-k>     <Plug>(neosnippet_expand_or_jump)
  xmap <C-k>     <Plug>(neosnippet_expand_target)
  " SuperTab like snippets behavior.
  "imap <expr><TAB>
  " \ pumvisible() ? "\<C-n>" :
  " \ neosnippet#expandable_or_jumpable() ?
  " \    "\<TAB>" : "\<Plug>(neosnippet_expand_or_jump)"
  smap <expr><TAB> neosnippet#expandable_or_jumpable() ?
        \ "\<Plug>(neosnippet_expand_or_jump)" : "\<TAB>"
  " For conceal markers.
  if has('conceal')
    set conceallevel=2 concealcursor=niv
  endif
endif

" ======== autopreview ======== "
if s:plug.is_installed('autopreview')
  let g:AutoPreview_enabled =0
  set updatetime=100
  set previewheight =8
  nnoremap <Leader>t :<C-u>AutoPreviewToggle<CR>
endif

" ======== vim-marching ======== "
if s:plug.is_installed('vim-marching')
  " clang コマンドの設定
  let g:marching_clang_command = "clang"
  " オプションを追加する
  " filetype=cpp に対して設定する場合
  let g:marching#clang_command#options = {
        \   "c"   : '-stdlib=libstdc --pedantic-errors',
        \   "cpp" : '-std=c++11 -stdlib=libstdc++ --pedantic-errors'
        \}
  " インクルードディレクトリのパスを設定
  let g:marching_include_paths = filter(copy(split(&path, ',')), "v:val !~ '^$'")
  " neocomplete.vim と併用して使用する場合
  let g:marching_enable_neocomplete = 1
  if !exists('g:neocomplete#force_omni_input_patterns')
    let g:neocomplete#force_omni_input_patterns = {}
  endif
  let g:neocomplete#force_omni_input_patterns.cpp =
        \ '[^.[:digit:] *\t]\%(\.\|->\)\w*\|\h\w*::\w*'
  " 処理のタイミングを制御する
  " 短いほうがより早く補完ウィンドウが表示される
  " ただし、marching.vim 以外の処理にも影響するので注意する
  set updatetime=100
  " オムニ補完時に補完ワードを挿入したくない場合
  imap <buffer> <C-x><C-o> <Plug>(marching_start_omni_complete)
  " キャッシュを削除してからオムに補完を行う
  imap <buffer> <C-x><C-x><C-o> <Plug>(marching_force_start_omni_complete)
  " 非同期ではなくて、同期処理でコード補完を行う場合
  " この設定の場合は vimproc.vim に依存しない
  " let g:marching_backend = "sync_clang_command"
endif

" ======== numbers ======== "
if s:plug.is_installed('numbers.vim')
  let g:enable_numbers = 0
endif

" ======== indentLine ======== "
if s:plug.is_installed('indentLine')
  let g:indentLine_enabled = 0
endif

" ======== CmdlineComplete ======== "
if s:plug.is_installed('CmdlineComplete')
  cmap <C-y> <Plug>CmdlineCompleteBackward
  cmap <C-t> <Plug>CmdlineCompleteForward
endif

" ======== vim-milfeulle ======== "
if s:plug.is_installed('vim-milfeulle')
  nmap <F8> <Plug>(milfeulle-prev)
  nmap <F9> <Plug>(milfeulle-next)
  let g:milfeulle_default_kind = "buffer"
  let g:milfeulle_default_jumper_name = "win_tab_bufnr_pos"
endif

" ======== vim-ipmotion ======== "
if s:plug.is_installed('vim-ipmotion')
  let g:ip_boundary = '"\?\s*$\n"\?\s*$'
endif

" ======== vim-markdown ======== "
if s:plug.is_installed('vim-markdown')
  let g:vim_markdown_folding_disabled=1
endif

" ======== vim-brightest ======== "
if s:plug.is_installed('vim-brightest')
  let g:brightest_enable=0
  let g:brightest#highlight = {
        \   "group" : "BrightestUnderline"
        \}
endif

" ======== vim-hopping ======== "
if s:plug.is_installed('vim-hopping')
  " Example key mapping
  nmap <Space>/ <Plug>(hopping-start)
  " Keymapping
  let g:hopping#keymapping = {
        \   "\<C-n>" : "<Over>(hopping-next)",
        \   "\<C-p>" : "<Over>(hopping-prev)",
        \   "\<C-u>" : "<Over>(scroll-u)",
        \   "\<C-d>" : "<Over>(scroll-d)",
        \}
endif

" ======== vim-jplus ======== "
if s:plug.is_installed('vim-jplus')
  " J の挙動を jplus.vim で行う
  nmap J <Plug>(jplus)
  vmap J <Plug>(jplus)
  " getchar() を使用して挿入文字を入力します
  nmap <Leader>J <Plug>(jplus-getchar)
  vmap <Leader>J <Plug>(jplus-getchar)
  " input() を使用したい場合はこちらを使用して下さい
  " nmap <Leader>J <Plug>(jplus-input)
  " vmap <Leader>J <Plug>(jplus-input)
  " <Plug>(jplus-getchar) 時に左右に空白文字を入れたい場合
  " %d は入力した結合文字に置き換えられる
  let g:jplus#config = {
        \   "_" : {
        \       "delimiter_format" : '%d'
        \   }
        \}
endif

" ======== vim-trip ======== "
if s:plug.is_installed('vim-trip')
  nmap <C-a> <Plug>(trip-increment)
  nmap <C-x> <Plug>(trip-decrement)
endif

" ======== vim-buftabline ======== "
if s:plug.is_installed('vim-buftabline')
  let g:buftabline_show=1
  let g:buftabline_numbers=2
  let g:buftabline_indicators=1
  highlight TabLineSel ctermbg=252 ctermfg=235
  "highlight PmenuSel ctermbg=248 ctermfg=238
  highlight Tabline ctermbg=248 ctermfg=238
  highlight TabLineFill ctermbg=248 ctermfg=238
endif

" ======== vim-togglelist ======== "
if s:plug.is_installed('vim-togglelist')
  nmap <script> <silent> <Leader>l :call ToggleLocationList()<CR>
  nmap <script> <silent> <Leader>q :call ToggleQuickfixList()<CR>
  let g:toggle_list_copen_command="botright copen"
endif

" ======== vim-hier ======== "
if s:plug.is_installed('vim-hier')
  highlight clear SpellBad
  highlight SpellBad cterm=underline gui=undercurl ctermbg=NONE
        \ ctermfg=NONE guibg=NONE guifg=NONE guisp=NONE
endif

" ======== ctrlp.vim ======== "
if s:plug.is_installed('ctrlp.vim')
  nnoremap [ctrlp] <Nop>
  nmap <Leader>p [ctrlp]
  nnoremap [ctrlp]a :<C-u>CtrlP<Space>
  nnoremap [ctrlp]c :<C-u>CtrlPCurWD<CR>
  nnoremap [ctrlp]b :<C-u>CtrlPBuffer<CR>
  nnoremap [ctrlp]d :<C-u>CtrlPDir<CR>
  nnoremap [ctrlp]f :<C-u>CtrlP<CR>
  nnoremap [ctrlp]l :<C-u>CtrlPLine<CR>
  nnoremap [ctrlp]m :<C-u>CtrlPMRUFiles<CR>
  nnoremap [ctrlp]q :<C-u>CtrlPQuickfix<CR>
  nnoremap [ctrlp]s :<C-u>CtrlPMixed<CR>
  nnoremap [ctrlp]t :<C-u>CtrlPTag<CR>
  let g:ctrlp_clear_cache_on_exit = 0
  let g:ctrlp_mruf_max            = 500
  let g:ctrlp_match_window = 'bottom,order:btt,min:1,max:10,results:50'
  let g:ctrlp_map          = '[ctrlp]'
  let g:ctrlp_cmd          = "CtrlPLastMode"
  let g:ctrlp_extensions = ['funky', 'modified', 'cmdline', 'yankring', 'menu',
        \ 'tag', 'buffertag', 'quickfix', 'dir', 'rtscript',
        \ 'undo', 'line', 'changes', 'mixed', 'bookmarkdir']
endif

" ======== jedi-vim ======== "
if s:plug.is_installed('jedi-vim')
  let g:jedi#auto_initialization = 1
  let g:jedi#auto_vim_configuration = 1

  nnoremap [jedi] <Nop>
  xnoremap [jedi] <Nop>
  nmap <LocalLeader>j [jedi]
  xmap <LocalLeader>j [jedi]

  let g:jedi#completions_command = "<C-N>"
  let g:jedi#goto_assignments_command = "[jedi]g"
  let g:jedi#goto_definitions_command = "[jedi]d"
  let g:jedi#documentation_command = "[jedi]K"
  let g:jedi#rename_command = "[jedi]r"
  let g:jedi#usages_command = "[jedi]n"
  let g:jedi#popup_select_first = 0
  let g:jedi#popup_on_dot = 0

  autocmd FileType python setlocal completeopt-=preview

  " for w/ neocomplete
  if s:plug.is_installed('neocomplete.vim')
    autocmd FileType python setlocal omnifunc=jedi#completions
    let g:jedi#completions_enabled = 0
    let g:jedi#auto_vim_configuration = 0
    if !exists('g:neocomplete#force_omni_input_patterns')
      let g:neocomplete#force_omni_input_patterns = {}
    endif
    let g:neocomplete#force_omni_input_patterns.python =
          \ '\%([^. \t]\.\|^\s*@\|^\s*from\s.\+import \|^\s*from \|^\s*import \)\w*'
  endif
endif

" ======== camelcasemotion ======== "
if s:plug.is_installed('camelcasemotion')
  map <silent> <LocalLeader>w <Plug>CamelCaseMotion_w
  map <silent> <LocalLeader>b <Plug>CamelCaseMotion_b
  map <silent> <LocalLeader>e <Plug>CamelCaseMotion_e
  map <silent> <LocalLeader>ge <Plug>CamelCaseMotion_ge
endif

" ======== vim-hybrid ======== "
if s:plug.is_installed('vim-hybrid')
  highlight WarningMsg term=reverse cterm=reverse
endif

" ======== deoplete.nvim ======== "
if s:plug.is_installed('deoplete.nvim')
  let g:deoplete#enable_at_startup = 1
endif


" }}}


"--------------------------------------------------------------
"          Disable Plugin Settings                          {{{
"--------------------------------------------------------------

"" ======== vim-tags ======== "
"if s:plug.is_installed('vim-tags')
"let g:vim_tags_auto_generate = 1
"let g:vim_tags_use_vim_dispatch = 0
"endif

"" ======== syntastic ======== "
"if s:plug.is_installed('syntastic')
"let g:syntastic_always_populate_loc_list = 1
"let g:syntastic_enable_signs = 1
"let g:syntastic_auto_loc_list = 0
"let g:syntastic_check_on_open = 0
"let g:syntastic_check_on_wq = 0
"let g:syntastic_check_on_save = 1
"endif

"" ======== SrcExpl ======== "
"nmap <F8> :SrcExplToggle<CR>
"let g:SrcExpl_winHeight = 8
"let g:SrcExpl_refreshTime = 100
"let g:SrcExpl_gobackKey = "<SPACE>"
"let g:SrcExpl_pluginList = [
"        \ "__Tag_List__",
"        \ "NERD_tree_1",
"        \ "[quickrun output]",
"        \ "[unite] - default",
"        \ "vimfiler:default",
"        \ "ControlP",
"        \ "Source_Explorer"
"        \ ]
"let g:SrcExpl_searchLocalDef = 0
"let g:SrcExpl_isUpdateTags = 0
"let g:SrcExpl_updateTagsKey = "<F12>"
"let g:SrcExpl_updateTagsCmd = "ctags --sort=foldcase -R ."
"
"" ======== Trinity ======== "
"nmap <F8>   :TrinityToggleAll<CR>
"nmap <F9>   :TrinityToggleSourceExplorer<CR>
"nmap <F10>  :TrinityToggleTagList<CR>
"nmap <F11>  :TrinityToggleNERDTree<CR>
"nmap <C-j> <C-]>

"" ======== vim-clang ======== "
"let g:clang_c_options = '-std=c11'
"let g:clang_cpp_options = '-std=c++11 -stdlib=libc++ --pedantic-errors'
"" disable auto completion for vim-clang
"let g:clang_auto = 0
"" default 'longest' can not work with neocomplete
"let g:clang_c_completeopt = 'menuone,preview'
"let g:clang_cpp_completeopt = 'menuone,preview'
"" use neocomplete
"" input patterns
"if !exists('g:neocomplete#force_omni_input_patterns')
"  let g:neocomplete#force_omni_input_patterns = {}
"endif
"" for c and c++
"let g:neocomplete#force_omni_input_patterns.c =
"      \ '[^.[:digit:] *\t]\%(\.\|->\)\w*'
"let g:neocomplete#force_omni_input_patterns.cpp =
"      \ '[^.[:digit:] *\t]\%(\.\|->\)\w*\|\h\w*::\w*'

"" ======== Taglist ======== "
"if s:plug.is_installed('Taglist')
"  echo "a"
"let Tlist_Show_One_File = 1                   " 現在表示中のファイルのみのタグしか表示しない
"let Tlist_Exit_OnlyWindow = 1                 " taglistのウインドウだけならVimを閉じる
"let Tlist_WinWidth = 50
"endif

"" ======== im_control.vim ======== "
"if s:plug.is_installed('im_control.vim')
"" 「日本語入力固定モード」切替キー
"inoremap <silent> <C-j> <C-r>=IMState('FixMode')<CR>
"" PythonによるIBus制御指定
"let IM_CtrlIBusPython = 1
"
"" <ESC>押下後のIM切替開始までの反応が遅い場合はttimeoutlenを短く設定してみてください。
"set timeout timeoutlen=3000 ttimeoutlen=10
"endif

" }}}

