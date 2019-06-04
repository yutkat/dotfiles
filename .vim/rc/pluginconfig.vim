
"===============================================================
"          Plugin Settings                                   {{{
"===============================================================

" plugin installed check
let s:plug = { 'plugs': get(g:, 'plugs', {}) }
function! s:plug.is_installed(name)
  return has_key(self.plugs, a:name) ? isdirectory(self.plugs[a:name].dir) : 0
endfunction


"===============================
" ColorScheme                {{{
"===============================

"-------------------------------
" vim-hybrid
if s:plug.is_installed('vim-hybrid')
  let g:hybrid_custom_term_colors = 1
  let g:hybrid_reduced_contrast = 1
  set background=dark
  colorscheme hybrid
  highlight! VertSplit ctermfg=236 ctermbg=236
  " highlight! WarningMsg term=reverse cterm=reverse
  highlight! SpellBad cterm=underline ctermfg=247 ctermbg=NONE gui=underline guifg=#9e9e9e
  highlight! SpecialKey cterm=underline ctermfg=NONE ctermbg=NONE gui=underline guifg=NONE
  " iceberg
  " highlight! Todo ctermbg=234 ctermfg=150 guibg=#45493e guifg=#b4be82
  " highlight! Todo ctermbg=NONE ctermfg=150 guibg=NONE guifg=#b4be82
  " solarized dark
  " highlight! Todo ctermbg=NONE ctermfg=125 guibg=NONE guifg=#d33682
  " onedark
  " highlight! Todo ctermbg=NONE ctermfg=170 guibg=NONE guifg=#C678DD cterm=bold
  " papercolor
  " highlight! Todo ctermbg=NONE ctermfg=35 guibg=NONE guifg=#00af5f cterm=bold
  " gotham
  " highlight! Todo ctermbg=NONE ctermfg=67 guibg=NONE guifg=#888ca6 cterm=bold
  highlight! Todo ctermbg=NONE ctermfg=13 guibg=NONE guifg=#888ca6 cterm=bold
  " Alduin
  " highlight Todo guifg=#af5f00 guibg=NONE gui=reverse ctermfg=130 ctermbg=NONE cterm=reverse
  " space-vim-dark
  " highlight! Todo ctermbg=NONE ctermfg=172 guibg=NONE guifg=#C678DD cterm=bold
  " molokai
  " highlight! Todo ctermbg=NONE ctermfg=231 cterm=bold guifg=#FFFFFF guibg=NONE gui=bold
endif

" }}}


"==============================
" etc                       {{{
"==============================

"-------------------------------
" matchit.vim
if !exists('g:loaded_matchit') && findfile('plugin/matchit.vim', &rtp) ==# ''
  runtime! macros/matchit.vim
endif

"-------------------------------
" neocomplete
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
  " <Tab>: completion.
  inoremap <expr><Tab>  pumvisible() ? "\<C-n>" : "\<Tab>"
  inoremap <expr><S-Tab>  pumvisible() ? "\<C-p>" : "\<S-Tab>"
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
  "inoremap <expr><Tab>  pumvisible() ? "\<Down>" : "\<C-x>\<C-u>"

  " Enable omni completion.
  augroup MyNeocomplete
    autocmd!
    autocmd FileType css setlocal omnifunc=csscomplete#CompleteCSS
    autocmd FileType html,markdown setlocal omnifunc=htmlcomplete#CompleteTags
    autocmd FileType javascript setlocal omnifunc=javascriptcomplete#CompleteJS
    autocmd FileType python setlocal omnifunc=pythoncomplete#Complete
    autocmd FileType xml setlocal omnifunc=xmlcomplete#CompleteTags
  augroup END

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

"-------------------------------
" neocomplcache
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
  " <Tab>: completion.
  inoremap <expr><Tab>  pumvisible() ? "\<C-n>" : "\<Tab>"
  inoremap <expr><S-Tab>  pumvisible() ? "\<C-p>" : "\<S-Tab>"
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
  "inoremap <expr><Tab>  pumvisible() ? "\<Down>" : "\<C-x>\<C-u>"

  " Enable omni completion.
  augroup MyNeocomplcache
    autocmd!
    autocmd FileType css setlocal omnifunc=csscomplete#CompleteCSS
    autocmd FileType html,markdown setlocal omnifunc=htmlcomplete#CompleteTags
    autocmd FileType javascript setlocal omnifunc=javascriptcomplete#CompleteJS
    autocmd FileType python setlocal omnifunc=pythoncomplete#Complete
    autocmd FileType xml setlocal omnifunc=xmlcomplete#CompleteTags
  augroup END

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

"-------------------------------
" unite
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
  nnoremap <silent> <SubLeader>vr :UniteResume<CR>
  " unite-build map
  nnoremap <silent> <SubLeader>vb :Unite build<CR>
  nnoremap <silent> <SubLeader>vcb :Unite build:!<CR>
  nnoremap <silent> <SubLeader>vch :UniteBuildClearHighlight<CR>
  "let g:unite_source_grep_command = 'ag'
  "let g:unite_source_grep_default_opts = '--nocolor --nogroup'
  "let g:unite_source_grep_max_candidates = 200
  let g:unite_source_grep_recursive_opt = '-rI'
  " unite-grepの便利キーマップ
  vnoremap /g y:Unite grep::-iHRn:<C-R>=escape(@", '\\.*$^[]')<CR><CR>
  nmap <F8> :<C-u>UniteWithCursorWord<Space>grep:%<CR>
  nmap <S-F8> :<C-u>UniteWithCurrentDir<Space>grep<CR>
  nmap <C-F8> :<C-u>UniteWithBufferDir<Space>grep<CR>
  nmap <C-S-F8> :<C-u>UniteWithProjectDir<Space>grep<CR>
  " ファイルを開く時、ウィンドウを分割して開く
  augroup MyUnite
    autocmd!
    autocmd FileType unite nnoremap <silent> <buffer> <expr> <C-s> unite#do_action('split')
    autocmd FileType unite inoremap <silent> <buffer> <expr> <C-s> unite#do_action('split')
    " ファイルを開く時、ウィンドウを縦に分割して開く
    autocmd FileType unite nnoremap <silent> <buffer> <expr> <C-v> unite#do_action('vsplit')
    autocmd FileType unite inoremap <silent> <buffer> <expr> <C-v> unite#do_action('vsplit')
    " ESCキーを2回押すと終了する
    autocmd FileType unite nnoremap <silent> <buffer> <ESC><ESC> :q<CR>
    autocmd FileType unite inoremap <silent> <buffer> <ESC><ESC> <ESC>:q<CR>
  augroup END
endif

"-------------------------------
" yankround
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

"-------------------------------
" cscope
if has('cscope')
  set nocst
  set csto=0
  set csre
  set nocsverb
  " add any database in current directory
  if filereadable('cscope.out')
    cs add cscope.out
    " else add database pointed to by environment
  elseif $CSCOPE_DB !=? ''
    cs add $CSCOPE_DB
  endif
  set csverb
  " To open quickfix annoying
  " set cscopequickfix=s-,c-,d-,i-,t-,e-
  nnoremap [cscope] <Nop>
  nmap <SubLeader>c [cscope]
  nmap [cscope]s :cs find s <C-R>=expand("<cword>")<CR><CR>
  nmap [cscope]g :cs find g <C-R>=expand("<cword>")<CR><CR>
  nmap [cscope]c :cs find c <C-R>=expand("<cword>")<CR><CR>
  nmap [cscope]t :cs find t <C-R>=expand("<cword>")<CR><CR>
  nmap [cscope]e :cs find e <C-R>=expand("<cword>")<CR><CR>
  nmap [cscope]f :cs find f <C-R>=expand("<cfile>")<CR><CR>
  nmap [cscope]i :cs find i ^<C-R>=expand("<cfile>")<CR>$<CR>
  nmap [cscope]d :cs find d <C-R>=expand("<cword>")<CR><CR>
endif

"-------------------------------
" nerdtree
if s:plug.is_installed('nerdtree')
  let g:NERDTreeMapOpenSplit = '<C-s>'
  let g:NERDTreeMapOpenVSplit = '<C-v>'
  let g:NERDTreeDirArrowExpandable = '+'
  let g:NERDTreeDirArrowCollapsible = '~'
  let g:NERDTreeWinPos = 'left'
  " Change IDE mode
  nnoremap <F12> :Vista!!<CR>:NERDTreeToggle<CR><C-w>l
  augroup MyNerdtree
    autocmd!
    autocmd BufEnter * if (winnr("$") == 1 && exists('b:NERDTree') &&
          \ b:NERDTree.isTabTree()) | q | endif
  augroup END
endif

"-------------------------------
" quickrun
if s:plug.is_installed('vim-quickrun')
  let g:quickrun_config = {}
  let g:quickrun_config['_'] = {
        \   'outputter' : 'quickfix',
        \   'outputter/buffer/split' : ':botright 8sp',
        \ }
  if has('job')
    let g:quickrun_config['_']['runner'] = 'job'
  elseif s:plug.is_installed('vimproc')
    let g:quickrun_config['_']['runner'] = 'vimproc'
    let g:quickrun_config['_']['runner/vimproc/updatetime'] = 40
  endif
  if s:plug.is_installed('unite')
    let g:quickrun_config['unite'] = {
          \   'hook/close_unite_quickfix/enable_hook_loaded' : 1,
          \   'hook/unite_quickfix/enable_failure' : 1,
          \   'hook/unite_quickfix/no_focus' : 0,
          \   'hook/unite_quickfix/unite_options' : '-no-start-insert -no-quit -direction=botright -winheight=12 -max-multi-lines=32',
          \   'hook/close_quickfix/enable_exit' : 1,
          \   'hook/close_buffer/enable_failure' : 1,
          \   'hook/close_buffer/enable_empty_data' : 1,
          \ }
  endif
endif

"-------------------------------
" watchdogs
if s:plug.is_installed('vim-watchdogs')
  let g:quickrun_config['watchdogs_checker/_'] = {
        \   'outputter/quickfix/open_cmd' : '',
        \   'hook/qfstatusline_update/enable_exit':   1,
        \   'hook/qfstatusline_update/priority_exit': 4,
        \ }
  " 書き込み後にシンタックスチェックを行う
  let g:watchdogs_check_BufWritePost_enable = 0
  let g:watchdogs_check_BufWritePost_enable_on_wq = 0
  call watchdogs#setup(g:quickrun_config)
  let g:Qfstatusline#Text=0
endif

"-------------------------------
" Vimfiler
if s:plug.is_installed('vimfiler')
  let g:vimfiler_as_default_explorer = 1
endif

"-------------------------------
" vim-quickhl
if s:plug.is_installed('vim-quickhl')
  nmap <Leader>m <Plug>(quickhl-manual-this)
  xmap <Leader>m <Plug>(quickhl-manual-this)
  nmap <Leader>M <Plug>(quickhl-manual-reset)
  xmap <Leader>M <Plug>(quickhl-manual-reset)
  nnoremap <silent> <F5> :nohlsearch<C-r>=has('diff')?'<Bar>diffupdate':''<CR><CR>:QuickhlManualReset<CR><C-l>

  "nmap <SubLeader>J <Plug>(quickhl-cword-toggle)
  "nmap <SubLeader>] <Plug>(quickhl-tag-toggle)
  "map <SubLeader>H <Plug>(operator-quickhl-manual-this-motion)

  let g:quickhl_manual_colors = [
        \ 'gui=bold ctermbg=110 ctermfg=0',
        \ 'gui=bold ctermbg=143 ctermfg=0',
        \ 'gui=bold ctermbg=217 ctermfg=0',
        \ 'gui=bold ctermbg=173 ctermfg=0',
        \ 'gui=bold ctermbg=139 ctermfg=0',
        \ 'gui=bold ctermbg=167 ctermfg=0',
        \ 'gui=bold ctermbg=187 ctermfg=0'
        \ ]
endif

"-------------------------------
" vim-expand-region
if s:plug.is_installed('vim-expand-region')
  vmap v <Plug>(expand_region_expand)
  vmap <C-v> <Plug>(expand_region_shrink)
endif

"-------------------------------
" vim-easy-align
if s:plug.is_installed('vim-easy-align')
  " Start interactive EasyAlign in visual mode (e.g. vip<Enter>)
  vmap <Enter> <Plug>(EasyAlign)
  " Start interactive EasyAlign for a motion/text object (e.g. gaip)
  nmap ga <Plug>(EasyAlign)
endif

"-------------------------------
" nerdcommenter
if s:plug.is_installed('nerdcommenter')
  let g:NERDSpaceDelims = 1
  "let g:NERDCompactSexyComs = 1
  let g:NERDDefaultAlign = 'left'
  "let g:NERDAltDelims_java = 1
  "let g:NERDCustomDelimiters = {
  "      \ 'c': { 'left': '/**','right': '*/' },
  "      \ 'cpp': { 'left': '/**','right': '*/' } }
  let g:NERDCommentEmptyLines = 1
  let g:NERDTrimTrailingWhitespace = 1
  nmap <C-_> <Leader>c<Leader>
  vmap <C-_> <Leader>c<Leader>
endif

"-------------------------------
" vim-easymotion
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
  hi EasyMotionTarget ctermbg=NONE ctermfg=red
  hi EasyMotionShade  ctermbg=NONE ctermfg=blue

  " <Leader>f{char} to move to {char}
  "map  <Leader>f <Plug>(easymotion-bd-f)
  "nmap <Leader>f <Plug>(easymotion-overwin-f)
  " s{char}{char} to move to {char}{char}
  "nmap s <Plug>(easymotion-overwin-f2)
  " Move to line
  map <Leader>L <Plug>(easymotion-bd-jk)
  nmap <Leader>L <Plug>(easymotion-overwin-line)
  " Move to word
  map  <Leader>w <Plug>(easymotion-bd-w)
  nmap <Leader>w <Plug>(easymotion-overwin-w)

  " etc
  map <Leader>s <Plug>(easymotion-repeat)
endif

"-------------------------------
" vim-gitgutter
if s:plug.is_installed('vim-gitgutter')
  let g:gitgutter_sign_added = '+'
  let g:gitgutter_sign_modified = '~'
  let g:gitgutter_sign_removed = '-'
  let g:gitgutter_realtime = 500
  let g:gitgutter_eager = 500
  let g:gitgutter_diff_args = '-w'
  highlight GitGutterAdd      ctermfg=65 ctermbg=NONE guifg=#5F875F guibg=NONE
  highlight GitGutterChange   ctermfg=60 ctermbg=NONE guifg=#5F5F87 guibg=NONE
  highlight GitGutterDelete   ctermfg=9  ctermbg=NONE guifg=#cc6666 guibg=NONE
endif

"-------------------------------
" lightline
if s:plug.is_installed('lightline.vim')
  let g:lightline = {
        \ 'colorscheme': 'wombat',
        \ 'enable': {
        \   'statusline': 1,
        \   'tabline': 1,
        \ },
        \ 'active': {
        \   'left': [ [ 'mode', 'paste' ], [ 'gina', 'gitgutter', 'filename' ], ['ctrlpmark'] ],
        \   'right': [
        \              [ 'lineinfo' ], ['percent'],
        \              [ 'cocstatus', 'ale_error', 'ale_warning', 'fileformat', 'fileencoding', 'filetype' ]
        \   ]
        \ },
        \ 'component_function': {
        \   'gina': 'LightLineGina',
        \   'gitgutter': 'LightLineGitGutter',
        \   'filename': 'LightLineFilename',
        \   'fileformat': 'LightLineFileformat',
        \   'filetype': 'LightLineFiletype',
        \   'fileencoding': 'LightLineFileencoding',
        \   'mode': 'LightLineMode',
        \   'ctrlpmark': 'CtrlPMark',
        \   'cocstatus': 'coc#status',
        \   'blame': 'LightlineGitBlame',
        \ },
        \ 'component_expand': {
        \   'ale_error':   'AleError',
        \   'ale_warning': 'AleWarning',
        \   'ale_ok':      'AleOk',
        \ },
        \ 'component_type': {
        \   'ale_error':   'error',
        \   'ale_warning': 'warning',
        \   'ale_ok':      'ok',
        \ },
        \ 'subseparator': { 'left': '|', 'right': '|' }
        \ }
  let g:lightline.tab = {
        \ 'active': [ 'tabnum', 'filename', 'modified' ],
        \ 'inactive': [ 'tabnum', 'filename', 'modified' ] }

  " syntastic
  "      \ 'component_expand': {
  "      \   'syntastic': 'SyntasticStatuslineFlag',
  "      \ },
  "      \ 'component_type': {
  "      \   'syntastic': 'error',
  "      \ },

  function! LightLineModified()
    return &ft =~? 'help' ? '' : &modified ? '+' : &modifiable ? '' : '-'
  endfunction

  function! LightLineReadonly()
    return &ft !~? 'help' && &readonly ? 'RO' : ''
  endfunction

  function! LightLineFilename()
    if winwidth(0) < 50
      let fname = expand('%:t')
    elseif winwidth(0) > 150
      let fname = expand('%')
    else
      let fname = pathshorten(expand('%'))
    endif
    return fname ==? 'ControlP' && has_key(g:lightline, 'ctrlp_item') ? g:lightline.ctrlp_item :
          \ fname ==? '__Tagbar__' ? g:lightline.fname :
          \ fname ==? '__vista__' ? '' :
          \ fname =~? '__Gundo\|NERD_tree' ? '' :
          \ &ft ==? 'vimfiler' ? vimfiler#get_status_string() :
          \ &ft ==? 'unite' ? unite#get_status_string() :
          \ &ft ==? 'vimshell' ? vimshell#get_status_string() :
          \ &ft ==? 'undotree' ? (exists('*t:undotree.GetStatusLine') ? t:undotree.GetStatusLine() : fname) :
          \ ('' !=? LightLineReadonly() ? LightLineReadonly() . ' ' : '') .
          \ ('' !=? fname ? fname : '[No Name]') .
          \ ('' !=? LightLineModified() ? ' ' . LightLineModified() : '')
  endfunction

  function! LightLineGina()
    try
      if expand('%:t') !~? 'Tagbar\|Vista\|Gundo\|NERD' && &ft !~? 'vimfiler' && exists(':Gina')
        let mark = ''  " edit here for cool mark
        let branch = gina#component#repo#branch()
        return branch !=# '' ? mark.branch : ''
      endif
    catch
    endtry
    return ''
  endfunction

  function! LightLineFugitive()
    try
      if expand('%:t') !~? 'Tagbar\|Vista\|Gundo\|NERD' && &ft !~? 'vimfiler' && exists('*fugitive#head')
        let mark = ''  " edit here for cool mark
        let branch = fugitive#head()
        return branch !=# '' ? mark.branch : ''
      endif
    catch
    endtry
    return ''
  endfunction

  function! LightLineFileformat()
    return winwidth(0) > 70 ? &fileformat : ''
  endfunction

  function! LightLineFiletype()
    return winwidth(0) > 70 ? (&filetype !=# '' ? &filetype : 'no ft') : ''
  endfunction

  function! LightLineFileencoding()
    return winwidth(0) > 70 ? (&fenc !=# '' ? &fenc : &enc) : ''
  endfunction

  function! LightLineMode()
    let fname = expand('%:t')
    return fname =~? '__Tagbar__' ? 'Tagbar' :
          \ fname ==? '__vista__' ? 'Vista' :
          \ fname ==? 'ControlP' ? 'CtrlP' :
          \ fname ==? '__Gundo__' ? 'Gundo' :
          \ fname ==? '__Gundo_Preview__' ? 'Gundo Preview' :
          \ fname =~? 'NERD_tree' ? 'NERDTree' :
          \ fname =~? 'buffergator-buffers' ? 'BufferGator' :
          \ (&ft ==? 'qf' && getwininfo(win_getid())[0].loclist) ? 'Location' :
          \ &ft ==? 'qf' ? 'QuickFix' :
          \ &ft ==? 'unite' ? 'Unite' :
          \ &ft ==? 'vimfiler' ? 'VimFiler' :
          \ &ft ==? 'vimshell' ? 'VimShell' :
          \ winwidth(0) > 60 ? lightline#mode() : ''
  endfunction

  function! CtrlPMark()
    if expand('%:t') =~? 'ControlP' && has_key(g:lightline, 'ctrlp_item')
      call lightline#link('iR'[g:lightline.ctrlp_regex])
      return lightline#concatenate([g:lightline.ctrlp_prev, g:lightline.ctrlp_item
            \ , g:lightline.ctrlp_next], 0)
    else
      return ''
    endif
  endfunction

  function! LightLineGitGutter()
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

  function! AleError() abort
    return s:ale_string(0)
  endfunction

  function! AleWarning() abort
    return s:ale_string(1)
  endfunction

  function! AleOk() abort
    return s:ale_string(2)
  endfunction

  function! s:ale_string(mode)
    if !exists('g:ale_buffer_info')
      return ''
    endif

    let g:ale_statusline_format = ['Err' .' %d', 'Warn' . ' %d', 'OK' . '  ']

    let l:buffer = bufnr('%')
    let [l:error_count, l:warning_count] = ale#statusline#Count(l:buffer)
    let [l:error_format, l:warning_format, l:no_errors] = g:ale_statusline_format

    if a:mode == 0 " Error
      return l:error_count ? printf(l:error_format, l:error_count) : ''
    elseif a:mode == 1 " Warning
      return l:warning_count ? printf(l:warning_format, l:warning_count) : ''
    endif

    return l:error_count == 0 && l:warning_count == 0 ? l:no_errors : ''
  endfunction

  augroup LightLineOnALE
    autocmd!
    autocmd User ALELint call lightline#update()
  augroup END

  augroup MyGutentagsStatusLineRefresher
    autocmd!
    autocmd User GutentagsUpdating call lightline#update()
    autocmd User GutentagsUpdated call lightline#update()
  augroup END

  " augroup AutoSyntastic
  " autocmd!
  " autocmd BufWritePost *.c,*.cpp,*.cc call s:syntastic()
  " augroup END
  " function! s:syntastic()
  " SyntasticCheck
  " call lightline#update()
  " endfunction

  function! LightlineGitBlame() abort
    let blame = get(b:, 'coc_git_blame', '')
    " return blame
    return winwidth(0) > 120 ? blame : ''
  endfunction

  let g:Qfstatusline#UpdateCmd = function('lightline#update')
  let g:unite_force_overwrite_statusline = 0
  let g:vimfiler_force_overwrite_statusline = 0
  let g:vimshell_force_overwrite_statusline = 0
  set noshowmode
endif

"-------------------------------
" vim-trailing-whitespace
if s:plug.is_installed('vim-trailing-whitespace')
  let g:extra_whitespace_ignored_filetypes =
        \ ['unite', 'markdown', 'vimfiler', 'qf',
        \ 'tagbar', 'nerdtree', 'vimshell']
  augroup TrailWhiteSpace
    autocmd!
    autocmd BufWritePre * :FixWhitespace
  augroup END
endif

"-------------------------------
" incsearch.vim
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

"-------------------------------
" incsearch-fuzzy.vim
if s:plug.is_installed('incsearch-fuzzy.vim')
  map z/ <Plug>(incsearch-fuzzy-/)
  map z? <Plug>(incsearch-fuzzy-?)
  map zg/ <Plug>(incsearch-fuzzy-stay)
endif

"-------------------------------
" vim-rooter
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

"-------------------------------
" vim-choosewin
if s:plug.is_installed('vim-choosewin')
  nmap  <Leader>-  <Plug>(choosewin)
  " オーバーレイ機能を有効にしたい場合
  let g:choosewin_overlay_enable          = 1
  " オーバーレイ・フォントをマルチバイト文字を含むバッファでも綺麗に表示する。
  let g:choosewin_overlay_clear_multibyte = 1
endif

"-------------------------------
" vim-localvimrc
if s:plug.is_installed('vim-localvimrc')
  let g:localvimrc_persistent=1
  let g:localvimrc_sandbox=0
endif

"-------------------------------
" vim-altr
if s:plug.is_installed('vim-altr')
  map <F6> <Plug>(altr-forward)
  map <S-F6> <Plug>(altr-back)
  " map <F3> <Plug>(altr-back)
endif

"-------------------------------
" vim-anzu
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
  let g:anzu_bottomtop_word = 'search hit BOTTOM, continuing at TOP'
  let g:anzu_topbottom_word = 'search hit TOP, continuing at BOTTOM'
  let g:anzu_status_format = '%p(%i/%l) %#WarningMsg#%w'
endif

"-------------------------------
" vim-asterisk
if s:plug.is_installed('vim-asterisk')
  nmap *  <Plug>(asterisk-z*)<Plug>(anzu-update-search-status-with-echo)
  nmap #  <Plug>(asterisk-z#)<Plug>(anzu-update-search-status-with-echo)
  nmap g* <Plug>(asterisk-gz*)<Plug>(anzu-update-search-status-with-echo)
  nmap g# <Plug>(asterisk-gz#)<Plug>(anzu-update-search-status-with-echo)
endif

"-------------------------------
" neosnippet
if s:plug.is_installed('neosnippet')
  let g:neosnippet#enable_snipmate_compatibility = 1
  let g:neosnippet#enable_completed_snippet = 1
  " let g:neosnippet#enable_complete_done = 1
  let g:neosnippet#expand_word_boundary = 1
  " Plugin key-mappings.
  imap <C-s>     <Plug>(neosnippet_expand_or_jump)
  smap <C-s>     <Plug>(neosnippet_expand_or_jump)
  xmap <C-s>     <Plug>(neosnippet_expand_target)
  " SuperTab like snippets behavior.
  "imap <expr><Tab>
  " \ pumvisible() ? "\<C-n>" :
  " \ neosnippet#expandable_or_jumpable() ?
  " \    "\<Tab>" : "\<Plug>(neosnippet_expand_or_jump)"
  smap <expr><Tab> neosnippet#expandable_or_jumpable() ?
        \ "\<Plug>(neosnippet_expand_or_jump)" : "\<Tab>"
  " For conceal markers.
  if has('conceal')
    set conceallevel=2 concealcursor=niv
  endif
  let g:neosnippet#snippets_directory=[
        \ '~/.vim/snippets',
        \ g:plug_home . '/neosnippet-snippets/neosnippets',
        \ g:plug_home . '/vim-snippets/snippets'
        \ ]
endif

"-------------------------------
" autopreview
if s:plug.is_installed('autopreview')
  let g:AutoPreview_enabled =0
  set updatetime=100
  set previewheight =8
  nnoremap <SubLeader>t :<C-u>AutoPreviewToggle<CR>
endif

"-------------------------------
" numbers
if s:plug.is_installed('numbers.vim')
  let g:enable_numbers = 0
endif

"-------------------------------
" indentLine
if s:plug.is_installed('indentLine')
  let g:indentLine_enabled = 0
endif

"-------------------------------
" CmdlineComplete
if s:plug.is_installed('CmdlineComplete')
  cmap <C-y> <Plug>CmdlineCompleteBackward
  cmap <C-t> <Plug>CmdlineCompleteForward
endif

"-------------------------------
" vim-milfeulle
if s:plug.is_installed('vim-milfeulle')
  nmap <S-F2> <Plug>(milfeulle-prev)
  nmap <S-F3> <Plug>(milfeulle-next)
  let g:milfeulle_default_kind = 'buffer'
  let g:milfeulle_default_jumper_name = 'win_tab_bufnr_pos'
endif

"-------------------------------
" vim-ipmotion
if s:plug.is_installed('vim-ipmotion')
  let g:ip_boundary = '"\?\s*$\n"\?\s*$'
endif

"-------------------------------
" vim-brightest
if s:plug.is_installed('vim-brightest')
  let g:brightest_enable = 0
  let g:brightest#highlight = {
        \   'group' : 'BrightestUnderline'
        \}
endif

"-------------------------------
" vim-hopping
if s:plug.is_installed('vim-hopping')
  " Example key mapping
  nmap <Space>/ <Plug>(hopping-start)
  " Keymapping
  let g:hopping#keymapping = {
        \   "\<C-n>" : '<Over>(hopping-next)',
        \   "\<C-p>" : '<Over>(hopping-prev)',
        \   "\<C-u>" : '<Over>(scroll-u)',
        \   "\<C-d>" : '<Over>(scroll-d)',
        \}
endif

"-------------------------------
" vim-jplus
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
        \   '_' : {
        \       'delimiter_format' : '%d'
        \   }
        \}
endif

"-------------------------------
" vim-trip
if s:plug.is_installed('vim-trip')
  nmap + <Plug>(trip-increment)
  nmap - <Plug>(trip-decrement)
endif

"-------------------------------
" vim-buftabline
if s:plug.is_installed('vim-buftabline')
  let g:buftabline_show = 1
  let g:buftabline_numbers = 2
  let g:buftabline_indicators = 1
  highlight TabLineSel ctermbg=252 ctermfg=235
  highlight PmenuSel ctermbg=236 ctermfg=244
  highlight Tabline ctermbg=248 ctermfg=238
  highlight TabLineFill ctermbg=248 ctermfg=238
  nmap <Leader>1 <Plug>BufTabLine.Go(1)
  nmap <Leader>2 <Plug>BufTabLine.Go(2)
  nmap <Leader>3 <Plug>BufTabLine.Go(3)
  nmap <Leader>4 <Plug>BufTabLine.Go(4)
  nmap <Leader>5 <Plug>BufTabLine.Go(5)
  nmap <Leader>6 <Plug>BufTabLine.Go(6)
  nmap <Leader>7 <Plug>BufTabLine.Go(7)
  nmap <Leader>8 <Plug>BufTabLine.Go(8)
  nmap <Leader>9 <Plug>BufTabLine.Go(9)
  nmap <Leader>0 <Plug>BufTabLine.Go(10)
endif

"-------------------------------
" vim-togglelist
if s:plug.is_installed('vim-togglelist')
  nmap <script> <silent> <SubLeader>l :call ToggleLocationList()<CR>
  nmap <script> <silent> <SubLeader>q :call ToggleQuickfixList()<CR>
  let g:toggle_list_copen_command='botright copen'
endif

"-------------------------------
" Valloric/ListToggle
if s:plug.is_installed('ListToggle')
  let g:lt_location_list_toggle_map = '<SubLeader>l'
  let g:lt_quickfix_list_toggle_map = '<SubLeader>q'
endif

"-------------------------------
" vim-hier
if s:plug.is_installed('vim-hier')
  highlight clear SpellBad
  highlight SpellBad cterm=underline gui=undercurl ctermbg=NONE
        \ ctermfg=NONE guibg=NONE guifg=NONE guisp=NONE
endif

"-------------------------------
" ctrlp.vim
if s:plug.is_installed('ctrlp.vim')
  nnoremap [ctrlp] <Nop>
  nmap <SubLeader>p [ctrlp]
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
  let g:ctrlp_map          = '<Leader>p'
  let g:ctrlp_cmd          = 'CtrlPLastMode'
  let g:ctrlp_extensions = ['yankring', 'cmdline', 'funky',
        \ 'tag', 'buffertag', 'undo', 'changes', 'mixed']
  " disable 'modified', 'menu', 'quickfix', 'bookmarkdir', 'dir',
  "         'rtscript', 'line',
endif

"-------------------------------
" jedi-vim
if s:plug.is_installed('jedi-vim')
  let g:jedi#auto_initialization = 1
  let g:jedi#auto_vim_configuration = 1

  nnoremap [jedi] <Nop>
  xnoremap [jedi] <Nop>
  nmap <SubLeader>j [jedi]
  xmap <SubLeader>j [jedi]

  let g:jedi#completions_command = '<C-N>'
  let g:jedi#goto_assignments_command = '[jedi]g'
  let g:jedi#goto_definitions_command = '[jedi]d'
  let g:jedi#documentation_command = '[jedi]K'
  let g:jedi#rename_command = '[jedi]r'
  let g:jedi#usages_command = '[jedi]n'
  let g:jedi#popup_select_first = 0
  let g:jedi#popup_on_dot = 0

  augroup MyJedi
    autocmd!
    autocmd FileType python setlocal completeopt-=preview
    if (v:version == 704 && has('patch775')) || v:version >= 705
      autocmd FileType python setlocal completeopt+=noselect
    endif
  augroup END

  " for w/ neocomplete
  if s:plug.is_installed('neocomplete.vim')
    augroup MyJedi2
      autocmd!
      autocmd FileType python setlocal omnifunc=jedi#completions
    augroup END
    let g:jedi#completions_enabled = 0
    let g:jedi#auto_vim_configuration = 0
    if !exists('g:neocomplete#force_omni_input_patterns')
      let g:neocomplete#force_omni_input_patterns = {}
    endif
    let g:neocomplete#force_omni_input_patterns.python =
          \ '\%([^. \t]\.\|^\s*@\|^\s*from\s.\+import \|^\s*from \|^\s*import \)\w*'
  endif
endif

"-------------------------------
" camelcasemotion
if s:plug.is_installed('camelcasemotion')
  map <silent> <SubLeader>w <Plug>CamelCaseMotion_w
  map <silent> <SubLeader>b <Plug>CamelCaseMotion_b
  map <silent> <SubLeader>e <Plug>CamelCaseMotion_e
  map <silent> <SubLeader>ge <Plug>CamelCaseMotion_ge
endif

"-------------------------------
" auto-pairs
if s:plug.is_installed('auto-pairs')
  let g:AutoPairsShortcutToggle = ''
  " let g:AutoPairsOnlyAtEOL = 1
  let g:AutoPairsOnlyBeforeClose = 1
  command! AutoPairsToggle call AutoPairsToggle()
endif

"-------------------------------
" vim-diminactive
if s:plug.is_installed('vim-diminactive')
  let g:diminactive = 0
  let g:diminactive_enable_focus = 1
endif

"-------------------------------
" vim-session
if s:plug.is_installed('vim-session')
  function! s:session_config(dir)
    " session保存ディレクトリをそのディレクトリの設定
    let g:session_directory = a:dir
    " vimを辞める時に自動保存
    " let g:session_autosave = 'yes'
    " 引数なしでvimを起動した時にsession保存ディレクトリのdefault.vimを開く
    "let g:session_autoload = 'yes'
    " 1分間に1回自動保存
    " let g:session_autosave_periodic = 1
    let g:session_autosave = 'no'
    let g:session_autoload = 'no'
  endfunction
  " 現在のディレクトリ直下の .vimsessions/ を取得
  let s:local_session_directory =
        \ xolox#misc#path#merge(getcwd(), '.vimsessions')
  let s:global_session_directory = expand('~/.vim/sessions')

  if isdirectory(s:local_session_directory)
    call s:session_config(s:local_session_directory)
  elseif isdirectory(s:global_session_directory)
    call s:session_config(s:global_session_directory)
  else
    let g:session_autosave = 'no'
    let g:session_autoload = 'no'
  endif
  unlet s:local_session_directory
  unlet s:global_session_directory
endif

"-------------------------------
" tagbar
if s:plug.is_installed('tagbar')
	highlight link TagbarHighlight PmenuSel
	let g:tagbar_type_markdown = {
				\ 'ctagstype': 'markdown',
				\ 'ctagsbin' : 'markdown2ctags',
				\ 'ctagsargs' : '-f - --sort=yes',
				\ 'kinds' : [
				\ 's:sections',
				\ 'i:images'
				\ ],
				\ 'sro' : '|',
				\ 'kind2scope' : {
				\ 's' : 'section',
				\ },
				\ 'sort': 0,
				\ }
endif

"-------------------------------
" vim-bbye
if s:plug.is_installed('vim-bbye')
  nnoremap <Leader>bd :Bdelete<CR>
  nmap <F4> :Bdelete<CR>
  nmap <S-F4> :Bdelete!<CR>
  nmap <C-F4> :Bdelete!<CR>
endif

"-------------------------------
" accelerated-jk
if s:plug.is_installed('accelerated-jk')
  nmap j <Plug>(accelerated_jk_gj)
  nmap k <Plug>(accelerated_jk_gk)
endif

"-------------------------------
" vim-ref
if s:plug.is_installed('vim-ref')
  function! RefDoc()
    if &filetype =~? 'perl'
      execute 'Ref perldoc'
    elseif &filetype =~? 'python'
      execute 'Ref pydoc'
    elseif &filetype =~? 'ruby'
      execute 'Ref refe'
    elseif &filetype =~? 'cpp'
      if has('nvim')
        execute 'terminal cppman ' .expand('<cword>')
      else
        execute '!cppman ' .expand('<cword>')
      endif
    elseif &filetype =~? 'go'
      execute 'GoDoc'
    elseif &filetype =~? 'rust'
      execute 'call LanguageClient_textDocument_hover()'
    else
      execute 'Ref man'
    endif
  endfunction
  map <F1> :<C-u>call RefDoc()<CR>

  let g:ref_lynx_use_cache = 1

  let g:ref_source_webdict_sites = {
        \   'weblio' : {
        \     'url' : 'http://ejje.weblio.jp/content/%s'
        \   },
        \   'wikij': {
        \     'url': 'http://ja.wikipedia.org/wiki/%s',
        \   },
        \   'wiki': {
        \     'url': 'http://en.wikipedia.org/wiki/%s',
        \   },
        \   'docs_rs': {
        \     'url': 'https://docs.rs/%s',
        \   }
        \ }
  function! g:ref_source_webdict_sites.weblio.filter(output)
    return join(split(a:output, "\n")[24 :], "\n")
  endfunction

  function! g:ref_source_webdict_sites.wiki.filter(output)
    return join(split(a:output, "\n")[17 :], "\n")
  endfunction

  function! g:ref_source_webdict_sites.docs_rs.filter(output)
    return join(split(a:output, "\n")[14 :], "\n")
  endfunction

  let g:ref_source_webdict_sites.default = 'weblio'
	nnoremap <silent><expr> <Leader>re ':Ref webdict weblio ' . expand('<cword>') . '<CR>'
	vnoremap <silent> <Leader>re "zy:Ref webdict weblio <C-r>"<CR>
	nnoremap <silent><expr> <Leader>rwj ':Ref webdict wikij ' . expand('<cword>') . '<CR>'
	vnoremap <silent> <Leader>rwj "zy:Ref webdict wikij <C-r>"<CR>
	nnoremap <silent><expr> <Leader>rw ':Ref webdict wiki ' . expand('<cword>') . '<CR>'
	vnoremap <silent> <Leader>rw "zy:Ref webdict wiki <C-r>"<CR>

	nnoremap <silent><expr> <S-F1> ':Ref webdict weblio ' . expand('<cword>') . '<CR>'
	vnoremap <silent> <S-F1> "zy:Ref webdict weblio <C-r>"<CR>
	nnoremap <silent><expr> <C-F1> ':Ref webdict wiki ' . expand('<cword>') . '<CR>'

	command! Weblio :execute 'Ref webdict weblio ' . expand('<cword>')
	command! -nargs=1 Weblioj :execute 'Ref webdict weblio ' '<args>'
	command! -nargs=1 Weblioe :execute 'Ref webdict weblio ' '<args>'
	command! Wikij :execute 'Ref webdict wikij ' . expand('<cword>')
	command! Wiki :execute 'Ref webdict wiki ' . expand('<cword>')

	command! RustDocsCurrentWord :execute 'Ref webdict docs_rs ' . expand('<cword>')
	command! -nargs=1 RustDocs :execute 'Ref webdict docs_rs ' '<args>'
endif

"-------------------------------
" clever-f.vim
if s:plug.is_installed('clever-f.vim')
  let g:clever_f_ignore_case = 0
  let g:clever_f_across_no_line = 1
  let g:clever_f_fix_key_direction = 1
endif

"-------------------------------
" accelerated-jk
if s:plug.is_installed('accelerated-jk')
  let g:accelerated_jk_acceleration_table = [30,60,80,85,90,95,100]
endif

"-------------------------------
" vim-buffergator
if s:plug.is_installed('vim-buffergator')
  let g:buffergator_viewport_split_policy = 'T'
  let g:buffergator_hsplit_size = 10
  let g:buffergator_suppress_keymaps = 1
  nmap <S-F12> :BuffergatorToggle<CR>
  " nmap <S-F9> :<CR>
  " nmap <C-F9> :<CR>
  " nmap <C-S-F9> :<CR>
endif

"-------------------------------
" vim-clang
if s:plug.is_installed('vim-clang')
  let g:clang_c_options = '-std=c11'
  let g:clang_cpp_options = '-std=c++11 -stdlib=libc++'
  " disable auto completion for vim-clang
  let g:clang_auto = 0
  " default 'longest' can not work with neocomplete
  let g:clang_c_completeopt = 'menuone,preview'
  let g:clang_cpp_completeopt = 'menuone,preview'
  if (v:version == 704 && has('patch775')) || v:version >= 705
    let g:clang_c_completeopt .= ',noselect'
    let g:clang_cpp_completeopt .= ',noselect'
  endif
  let g:clang_diagsopt = ''
  " use neocomplete
  " input patterns
  if s:plug.is_installed('neocomplete.vim')
    if !exists('g:neocomplete#force_omni_input_patterns')
      let g:neocomplete#force_omni_input_patterns = {}
    endif
    " for c and c++
    let g:neocomplete#force_omni_input_patterns.c =
          \ '[^.[:digit:] *\t]\%(\.\|->\)\w*'
    let g:neocomplete#force_omni_input_patterns.cpp =
          \ '[^.[:digit:] *\t]\%(\.\|->\)\w*\|\h\w*::\w*'
  endif
  let g:clang_enable_format_command = 0
  set nosplitbelow
endif

"-------------------------------
" vim-snowdrop
if s:plug.is_installed('vim-snowdrop')
  let s:libclang_file =
        \ substitute(system("ldconfig -p | grep libclang | awk '{print $4}'"),
        \ '\n\+$', '', '')
  let g:snowdrop#libclang_directory =
        \ substitute(system('dirname ' . s:libclang_file), '\n\+$', '', '')
  let g:snowdrop#libclang_file =
        \ substitute(system('basename ' . s:libclang_file), '\n\+$', '', '')
  let g:snowdrop#command_options = {
        \   'cpp' : '-std=c++11',
        \}
endif

"-------------------------------
" gtags.vim
if s:plug.is_installed('gtags.vim')
  nmap <Leader>] :GtagsCursor<CR>
  nmap <SubLeader>] :Gtags -r <C-r><C-w><CR>
endif

"-------------------------------
" neomake
if s:plug.is_installed('neomake')
  " Auto check
  augroup MyNeomake
    autocmd!
    "autocmd! BufWritePost * Neomake
  augroup END
  let g:neomake_error_sign = {'text': 'x', 'texthl': 'NeomakeErrorSign'}
  let g:neomake_warning_sign = {
        \   'text': '!',
        \   'texthl': 'NeomakeWarningSign',
        \ }
  let g:neomake_message_sign = {
        \   'text': '>',
        \   'texthl': 'NeomakeMessageSign',
        \ }
  let g:neomake_info_sign = {'text': 'i', 'texthl': 'NeomakeInfoSign'}
endif

"-------------------------------
" ferret
if s:plug.is_installed('ferret')
  let g:FerretMap = 0
endif

"-------------------------------
" denite.nvim
if s:plug.is_installed('denite.nvim')
  if executable('ag')
    call denite#custom#var('file_rec', 'command',
          \ ['ag', '--follow', '--nocolor', '--nogroup', '-g', ''])

    " call denite#custom#var('grep', 'command', ['ag'])
    " call denite#custom#var('grep', 'recursive_opts', [])
    " call denite#custom#var('grep', 'final_opts', [])
    " call denite#custom#var('grep', 'separator', [])
    " call denite#custom#var('grep', 'default_opts',
    "       \ ['--nocolor', '--nogroup'])
  endif

  nnoremap    [denite]   <Nop>
  nmap    <Leader>u [denite]
  nnoremap <silent> [denite]f :<C-u>Denite file_rec<CR>
  nnoremap <silent> [denite]g :<C-u>Denite grep<CR>
  nnoremap <silent> [denite]l :<C-u>Denite line<CR>
  nnoremap <silent> [denite]u :<C-u>Denite file_mru<CR>
  nnoremap <silent> [denite]y :<C-u>Denite neoyank<CR>
  nmap <F8> :<C-u>DeniteCursorWord<Space>grep<CR>
  nmap <S-F8> :<C-u>DeniteProjectDir<Space>grep<CR>
endif

"-------------------------------
" deoplete.nvim
if s:plug.is_installed('deoplete.nvim')
  " Use deoplete.
  let g:deoplete#enable_at_startup = 1
  " Use smartcase.
  let g:deoplete#enable_smart_case = 1
  " <C-h>, <BS>: close popup and delete backword char.
  inoremap <expr><C-h> deoplete#smart_close_popup()."\<C-h>"
  inoremap <expr><BS>  deoplete#smart_close_popup()."\<C-h>"
  inoremap <expr><Tab>  pumvisible() ? "\<C-n>" : "\<Tab>"
  inoremap <expr><C-Space>  pumvisible() ? "\<C-n>" : "\<Tab>"
  inoremap <expr><S-Tab>  pumvisible() ? "\<C-p>" : "\<S-Tab>"
  " too slow neosnippet#expandable_or_jumpable()
  " inoremap <expr><Tab> pumvisible() ? "\<C-n>" :
  "       \ neosnippet#expandable_or_jumpable() ? "\<Plug>(neosnippet_expand_or_jump)" :"\<Tab>"
  " inoremap <expr><C-Space>  pumvisible() ? "\<C-n>" :
  "       \ neosnippet#expandable_or_jumpable() ? "\<Plug>(neosnippet_expand_or_jump)" :"\<Tab>"
  " inoremap <expr><S-Tab>  pumvisible() ? "\<C-p>" :
  "       \ neosnippet#expandable_or_jumpable() ? "\<Plug>(neosnippet_expand_or_jump)" :"\<S-Tab>"
  inoremap <expr><C-y>  deoplete#close_popup()
  inoremap <expr><C-e>  deoplete#cancel_popup()
  " <CR>: close popup and save indent.
  inoremap <silent> <CR> <C-r>=<SID>my_cr_function()<CR>
  " too slow and https://github.com/Shougo/neosnippet.vim/issues/436#issuecomment-403327057
  " imap <expr><CR> pumvisible() ? deoplete#close_popup() :
  "       \ neosnippet#expandable() ? "\<Plug>(neosnippet_expand_or_jump)" : "\<CR>"
  function! s:my_cr_function() abort
    return pumvisible() ? deoplete#close_popup() : "\<CR>"
  endfunction
  command! DeopleteDisable :call deoplete#disable()
  command! DeopleteEnable :call deoplete#enable()
  call deoplete#custom#option('auto_complete_delay', 20)
  call deoplete#custom#option('auto_refresh_delay', 10)
endif

"-------------------------------
" completor.vim
if s:plug.is_installed('completor.vim')
  let g:completor_gocode_binary = $GOPATH . '/bin/gocode'
  let g:completor_racer_binary = $HOME . '/.cargo/bin/racer'
  inoremap <expr> <Tab> pumvisible() ? "\<C-n>" : "\<Tab>"
  inoremap <expr> <S-Tab> pumvisible() ? "\<C-p>" : "\<S-Tab>"
  inoremap <expr> <cr> pumvisible() ? "\<C-y>" : "\<cr>"
endif

"-------------------------------
" python-mode
if s:plug.is_installed('python-mode')
  let g:pymode_folding = 0
  let g:pymode_rope_completion = 0
  let g:pymode_python = 'python3'
endif

"-------------------------------
" vim-operator-flashy
if s:plug.is_installed('vim-operator-flashy')
  map y <Plug>(operator-flashy)
  nmap Y <Plug>(operator-flashy)$
endif

"-------------------------------
" deoplete-clang
if s:plug.is_installed('deoplete-clang')
  let g:deoplete#sources#clang#libclang_path =
        \ substitute(system("ldconfig -p | \grep libclang.so | awk '{print $4}' | head -n 1"),
        \ '\n\+$', '', '')
  if isdirectory('/usr/lib64/clang')
    let g:deoplete#sources#clang#clang_header = '/usr/lib64/clang/'
  else
    let g:deoplete#sources#clang#clang_header = '/usr/lib/clang/'
  endif
endif

"-------------------------------
" deoplete-go
if s:plug.is_installed('deoplete-go')
  let g:deoplete#sources#go#gocode_binary = $GOPATH . '/bin/gocode'
endif

"-------------------------------
" EnhancedJumps
if s:plug.is_installed('EnhancedJumps')
  nmap <S-F2> g<C-o>
  nmap <S-F3> g<C-i>
endif

"-------------------------------
" echodoc.vim
if s:plug.is_installed('echodoc.vim')
  set noshowmode
  let g:echodoc_enable_at_startup = 1
  if has('nvim')
    let g:echodoc#type = 'virtual'
  endif
  set signcolumn=yes
endif

"-------------------------------
" rust.vim
if s:plug.is_installed('rust.vim')
  let g:rustfmt_autosave = 1
  if executable('rustfmt')
    let g:rustfmt_command = 'rustfmt'
  elseif filereadable($HOME . '/.cargo/bin/rustfmt')
    let g:rustfmt_command = $HOME . '/.cargo/bin/rustfmt'
  elseif filereadable('/usr/bin/rustfmt')
    let g:rustfmt_command = '/usr/bin/rustfmt'
  endif
  let g:rust_clip_command = 'xclip -selection clipboard'
endif

"-------------------------------
" vim-racer
if s:plug.is_installed('vim-racer')
  set hidden
  let g:racer_cmd = $HOME . '/.cargo/bin/racer'
  let g:racer_experimental_completer = 1
endif

"-------------------------------
" vim-go
if s:plug.is_installed('vim-go')
  let g:go_fmt_command = 'goimports'
  let g:go_hightlight_functions = 1
  let g:go_hightlight_methods = 1
  let g:go_hightlight_structs = 1
  let g:go_hightlight_interfaces = 1
  let g:go_hightlight_operators = 1
  let g:go_hightlight_build_constraints = 1
endif

"-------------------------------
" is.vim
if s:plug.is_installed('is.vim')
  if s:plug.is_installed('vim-anzu')
    map n <Plug>(is-nohl)<Plug>(anzu-n-with-echo)
    map N <Plug>(is-nohl)<Plug>(anzu-N-with-echo)
  endif
  if s:plug.is_installed('vim-asterisk')
    map *  <Plug>(asterisk-z*)<Plug>(is-nohl-1)
    map g* <Plug>(asterisk-gz*)<Plug>(is-nohl-1)
    map #  <Plug>(asterisk-z#)<Plug>(is-nohl-1)
    map g# <Plug>(asterisk-gz#)<Plug>(is-nohl-1)
  endif
endif

"-------------------------------
" vim-edgemotion
if s:plug.is_installed('vim-edgemotion')
  map <C-j> <Plug>(edgemotion-j)
  map <C-k> <Plug>(edgemotion-k)
endif

"-------------------------------
" LanguageClient-neovim
if s:plug.is_installed('LanguageClient-neovim')
  " Automatically start language servers.
  let g:LanguageClient_autoStart = 1
  let g:LanguageClient_diagnosticsList = "Location"
  " let g:LanguageClient_diagnosticsList = "Quickfix"
  let g:LanguageClient_useFloatingHover = 1

  let g:LanguageClient_serverCommands = {}
  if executable('rls')
    " rustup component add rls rust-analysis rust-src
    let g:LanguageClient_serverCommands.rust = ['rustup', 'run', 'stable', 'rls']
  endif

  if executable('javascript-typescript-stdio')
    " yarn global add javascript-typescript-langserver   -or-
    " npm i -g javascript-typescript-langserver
    let g:LanguageClient_serverCommands.javascript = ['javascript-typescript-stdio']
    let g:LanguageClient_serverCommands.javascript.jsx = ['tcp://127.0.0.1:2089']
    let g:LanguageClient_serverCommands.typescript = ['javascript-typescript-stdio']
  endif

  if executable('html-languageserver')
    " npm i -g vscode-html-languageserver-bin
    let g:LanguageClient_serverCommands.html = ['html-languageserver', '--stdio']
  endif

  if executable('css-languageserver')
    " yarn global add vscode-css-languageserver-bin   -or-
    " npm i -g vscode-css-languageserver-bin
    let g:LanguageClient_serverCommands.css = ['css-languageserver', '--stdio']
    let g:LanguageClient_serverCommands.less = ['css-languageserver', '--stdio']
  endif

  if executable('cquery')
    " yay -S cquery
    let g:LanguageClient_serverCommands.cpp = ['cquery', '--log-file=/tmp/cq.log', '--init={"cacheDirectory":"/tmp/cquery/"}']
    let g:LanguageClient_serverCommands.c = ['cquery', '--log-file=/tmp/cq.log', '--init={"cacheDirectory":"/tmp/cquery/"}']
  endif

  if executable('pyls')
    " pip install python-language-server
    let g:LanguageClient_serverCommands.python = ['pyls']
  endif

  if executable('go-langserver')
    " go get -u github.com/sourcegraph/go-langserver
    let g:LanguageClient_serverCommands.go = ['go-langserver']
  endif

  let s:lsp_filetypes = join(keys(g:LanguageClient_serverCommands), ",")
  if s:lsp_filetypes != ""
		function! SetLSPShortcuts()
			nnoremap <leader>ld :call LanguageClient#textDocument_definition()<CR>
			nnoremap <leader>lr :call LanguageClient#textDocument_rename()<CR>
			nnoremap <leader>lf :call LanguageClient#textDocument_formatting()<CR>
			nnoremap <leader>lt :call LanguageClient#textDocument_typeDefinition()<CR>
			nnoremap <leader>lx :call LanguageClient#textDocument_references()<CR>
			nnoremap <leader>la :call LanguageClient_workspace_applyEdit()<CR>
			nnoremap <leader>lc :call LanguageClient#textDocument_completion()<CR>
			nnoremap <leader>lh :call LanguageClient#textDocument_hover()<CR>
			nnoremap <leader>ls :call LanguageClient_textDocument_documentSymbol()<CR>
			nnoremap <leader>lm :call LanguageClient_contextMenu()<CR>
		endfunction()

		augroup LSP
			autocmd!
			execute 'autocmd FileType ' . s:lsp_filetypes . ' call SetLSPShortcuts()'
		augroup END
	endif
endif

"-------------------------------
" nvim-completion-manager
if s:plug.is_installed('nvim-completion-manager')
  " imap <expr> <CR>  (pumvisible() ?  "\<c-y>\<Plug>(expand_or_nl)" : "\<CR>")
  " imap <expr> <Plug>(expand_or_nl) (cm#completed_is_snippet() ? "\<C-U>":"\<CR>")
  " inoremap <c-c> <ESC>
  " inoremap <expr> <Tab> pumvisible() ? "\<C-n>" : "\<Tab>"
  " inoremap <expr> <S-Tab> pumvisible() ? "\<C-p>" : "\<S-Tab>"
endif

"-------------------------------
" ale
if s:plug.is_installed('ale')
  let g:ale_completion_enabled = 0
  let g:ale_rust_cargo_use_clippy = 1
  let g:ale_set_loclist = 0
endif

"-------------------------------
" delimitMate
if s:plug.is_installed('delimitMate')
  let delimitMate_smart_quotes = '\%(\w\|[^[:punct:][:space:]]\|\%(\\\\\)*\\\)\%#\|\%#\%(\w\|[^[:space:][:punct:]]\)'
  let delimitMate_smart_matchpairs = '^\%(\S\|\!\|[£$]\|[^[:space:][:punct:]]\)'
endif

"-------------------------------
" vim-table-mode
if s:plug.is_installed('vim-table-mode')
  let g:table_mode_corner = '|'
endif

"-------------------------------
" sonictemplate-vim
if s:plug.is_installed('sonictemplate-vim')
  let g:sonictemplate_vim_template_dir = ['~/.vim/template']
endif

"-------------------------------
" vim-dispatch
if s:plug.is_installed('vim-dispatch')
  nnoremap <Leader>R :Copen<Bar>Dispatch<CR>
endif

"-------------------------------
" vim-dirvish
if s:plug.is_installed('vim-dirvish')
  let g:dirvish_mode = ':sort r /[^\/]$/'
endif

"-------------------------------
" fzf.vim
if s:plug.is_installed('fzf.vim')
  let g:fzf_command_prefix = 'FZF'
  let g:fzf_action = {
        \ 'ctrl-t': 'tab split',
        \ 'ctrl-s': 'split',
        \ 'ctrl-x': 'split',
        \ 'ctrl-v': 'vsplit' }
  fun! FzfOmniFiles()
    let is_git = system('git status')
    if v:shell_error
      :FZFFiles
    else
      :FZFGFiles
    endif
  endfun
  nnoremap <Leader>p :call FzfOmniFiles()<CR>
  nnoremap <Leader><Leader>; :FZF<CR>
  nnoremap <Leader><Leader> :FZFCommands<CR>
  nnoremap <Leader>. :FZF<CR>
  nnoremap <Leader>ag :FZFAg <C-R>=expand("<cword>")<CR><CR>
  nnoremap <Leader>rg :FZFRg <C-R>=expand("<cword>")<CR><CR>
  nnoremap <Leader>fb :FZFBuffers<CR>
  nnoremap <Leader>fc :FZFCommands<CR>
  command! -bar -bang FZFMapsN :call fzf#vim#maps("n", <bang>0)
  command! -bar -bang FZFMapsI :call fzf#vim#maps("i", <bang>0)
  command! -bar -bang FZFMapsX :call fzf#vim#maps("x", <bang>0)
  command! -bar -bang FZFMapsO :call fzf#vim#maps("o", <bang>0)
  command! -bar -bang FZFMapsV :call fzf#vim#maps("v", <bang>0)
  augroup MyFzf
    autocmd!
    autocmd FileType fzf tnoremap <buffer> <Esc> <Esc>
  augroup END

  command! FZFOmniFiles call FzfOmniFiles()
  command! FZFMruSimple call fzf#run({
        \ 'source':  reverse(s:all_files()),
        \ 'sink':    'edit',
        \ 'options': '-m -x +s',
        \ 'down':    '40%' })

  function! s:all_files()
    return extend(
          \ filter(copy(v:oldfiles),
          \        "v:val !~ 'fugitive:\\|NERD_tree\\|^/tmp/\\|.git/'"),
          \ map(filter(range(1, bufnr('$')), 'buflisted(v:val)'), 'bufname(v:val)'))
  endfunction
  nnoremap <Leader>; :FZFMruSimple<CR>

  let $FZF_DEFAULT_OPTS = '--preview
        \ "if [[ ! -e {} ]]; then
        \   echo \"\";
        \ elif [[ $(file --mime {}) =~ directory ]]; then
        \   echo {} is a directory;
        \ elif [[ $(file --mime {}) =~ binary ]]; then
        \   echo {} is a binary file;
        \ else
        \   (highlight -O ansi -l {} || coderay {} || rougify {} || bat --color=always {} || cat {}) 2> /dev/null
        \ fi | head -500"'

endif

"-------------------------------
" vim-markdown
if s:plug.is_installed('vim-markdown')
  let g:vim_markdown_folding_disabled = 1
  let g:markdown_enable_mappings = 0
endif

"-------------------------------
" vim-startify.vim
if s:plug.is_installed('vim-startify')
  if filereadable(expand('~/.vim/rc/files/startify_custom_header.txt'))
    let g:startify_custom_header = startify#fortune#boxed() +
          \ readfile(expand('~/.vim/rc/files/startify_custom_header.txt'))
  endif
  let g:startify_custom_footer = ['', "                                 powered by vim-startify", '']
  let g:startify_session_dir = '~/.vim/sessions'

  let g:startify_commands = [
        \ {'p': ['FZFProjectFiles', 'FZFOmniFiles']},
        \ {'c': ['FZFCurrentFiles', 'FZF']},
        \ {'r': ['FZFRecentFiles', 'FZFMru']},
        \ {'m': ['Memo', 'MemoNew tmp']},
        \ {'l': ['MemoList', 'MemoList']},
        \ ]
endif

"-------------------------------
" deoplete-rust
if s:plug.is_installed('deoplete-rust')
  let g:deoplete#sources#rust#racer_binary=$HOME . '/.cargo/bin/racer'
	let g:deoplete#sources#rust#rust_source_path= substitute(system("rustup which rustc | xargs dirname"), '\n\+$', '', '')
        \ . '/../lib/rustlib/src/rust/src'
	let g:deoplete#sources#rust#show_duplicates=1
endif

"-------------------------------
" vim-polyglot
if s:plug.is_installed('vim-polyglot')
  let g:polyglot_disabled = ['markdown', 'go', 'rust']
endif

"-------------------------------
" cohama/lexima.vim
if s:plug.is_installed('lexima.vim')
  call lexima#add_rule({'at': '\%#.*[-0-9a-zA-Z_,:]', 'char': '(', 'input': '('})
  call lexima#add_rule({'at': '\%#.*[-0-9a-zA-Z_,:]', 'char': '[', 'input': '['})
  call lexima#add_rule({'at': '\%#.*[-0-9a-zA-Z_,:]', 'char': '{', 'input': '{'})
  call lexima#add_rule({'at': '\%#.*[-0-9a-zA-Z_,:]', 'char': '"', 'input': '"'})
  call lexima#add_rule({'at': '\%#.*[-0-9a-zA-Z_,:]', 'char': '''', 'input': ''''})
  call lexima#add_rule({'at': '\%#.*[-0-9a-zA-Z_,:]', 'char': '`', 'input': '`'})
  call lexima#add_rule({'at': '\%#\n\s*}', 'char': '}', 'input': '}', 'delete': '}'})
endif

"-------------------------------
" vim-terraform
if s:plug.is_installed('vim-terraform')
  let g:terraform_fmt_on_save = 1
endif

"-------------------------------
" vim-test
if s:plug.is_installed('vim-test')
  let g:test#strategy = 'dispatch'
  nnoremap <Leader>tn :TestNearest<CR>
  nnoremap <Leader>tf :TestFile<CR>
  nnoremap <Leader>ts :TestSuite<CR>
  nnoremap <Leader>tl :TestLast<CR>
  nnoremap <Leader>tv :TestVisit<CR>
  let g:test#rust#cargotest#options = '-- --nocapture'
endif

"-------------------------------
" vim-better-whitespace
if s:plug.is_installed('vim-better-whitespace')
  let g:better_whitespace_enabled = 1
  let g:strip_whitespace_on_save = 1
endif

"-------------------------------
" vim-cheatsheet
if s:plug.is_installed('vim-cheatsheet')
  if filereadable(expand('~/.vim/rc/files/cheatsheet.md'))
    let g:cheatsheet#cheat_file = expand('~/.vim/rc/files/cheatsheet.md')
  endif
endif

"-------------------------------
" vim-matchup
if s:plug.is_installed('vim-matchup')
  let g:loaded_matchit = 1
  hi MatchParenCur cterm=underline gui=underline
  hi MatchWordCur cterm=underline gui=underline
endif

"-------------------------------
" vim-gutentags
if s:plug.is_installed('vim-gutentags')
  let g:gutentags_enabled = 1
  let g:gutentags_modules = []
  if executable('ctags')
    let g:gutentags_modules += ['ctags']
  endif
  if executable('cscope')
    let g:gutentags_modules += ['cscope']
  endif
  if executable('gtags-cscope') && executable('gtags')
    let g:gutentags_modules += ['gtags_cscope']
  endif
  let g:gutentags_cache_dir = expand('~/.cache/tags')
  if !isdirectory(g:gutentags_cache_dir)
    call mkdir(g:gutentags_cache_dir, 'p')
  endif
  let g:gutentags_gtags_dbpath = g:gutentags_cache_dir
  let g:gutentags_define_advanced_commands = 1
  let g:gutentags_ctags_extra_args = ['--fields=+niazS', '--extra=+q']
  let g:gutentags_ctags_extra_args += ['--c++-kinds=+px']
  let g:gutentags_ctags_extra_args += ['--c-kinds=+px']
  let g:gutentags_ctags_extra_args += ['/usr/include', '/usr/local/include']
  " lazy load for vim-plug
  " command! GutentagsSetup :call gutentags#setup_gutentags()
  " augroup MyGutentags
  "   autocmd!
	"   autocmd! User vim-gutentags call gutentags#setup_gutentags()
	" augroup END
endif

"-------------------------------
" gutentags_plus
if s:plug.is_installed('gutentags_plus')
  let g:gutentags_plus_nomap = 1
endif

"-------------------------------
" memolist.vim
if s:plug.is_installed('memolist.vim')
  let g:memolist_path = "$HOME/.memo"
  let g:memolist_memo_suffix = "md"
  let g:memolist_fzf = 1
endif

"-------------------------------
" vim-illuminate
if s:plug.is_installed('vim-illuminate')
  let g:Illuminate_ftblacklist = ['nerdtree']
endif

"-------------------------------
" repmo-vim
if s:plug.is_installed('repmo-vim')
  map <expr> , repmo#LastKey(';')|sunmap ,
endif

"-------------------------------
" quick-scope
if s:plug.is_installed('quick-scope')
  nmap <leader>qs <plug>(QuickScopeToggle)
  xmap <leader>qs <plug>(QuickScopeToggle)
  let g:qs_max_chars = 100
  let g:qs_lazy_highlight = 1
  set updatetime=100
  highlight QuickScopePrimary guifg='#afff5f' gui=underline ctermfg=155 cterm=underline
	highlight QuickScopeSecondary guifg='#5fffff' gui=underline ctermfg=81 cterm=underline
  augroup MyQuickScope
    autocmd!
    autocmd FileType nerdtree,buffergator,tagbar,qf let b:qs_local_disable=1
  augroup END
endif

"-------------------------------
" deoplete-tabnine
if s:plug.is_installed('deoplete-tabnine')
  call deoplete#custom#source('tabnine', 'rank', 50)
  call deoplete#custom#source('tabnine', 'min_pattern_length', 2)
  call deoplete#custom#option('ignore_sources', {'_': ['around', 'buffer', 'tag']})
  " call deoplete#custom#option('ignore_sources', {'_': ['LanguageClient']})
endif

"-------------------------------
" operator-camelize.vim
if s:plug.is_installed('operator-camelize.vim')
  vnoremap <SubLeader>c <Plug>(operator-camelize)
  vnoremap <SubLeader>C <Plug>(operator-decamelize)
endif

"-------------------------------
" vim-operator-convert-case
if s:plug.is_installed('vim-operator-convert-case')
  nmap ,cc <Plug>(convert-case-loop)
endif

"-------------------------------
" fzf-mru.vim
if s:plug.is_installed('fzf-mru.vim')
  nnoremap <Leader>; :FZFMru<CR>
endif

"-------------------------------
" fzf-filemru
if s:plug.is_installed('fzf-filemru')
  let g:fzf_filemru_git_ls = 1
  nnoremap <Leader>. :FilesMru<CR>
  nnoremap <Leader>p :ProjectMru<CR>
  command! -nargs=* FZFFilesMru call s:fzf_filemru(<q-args>)
  command! -nargs=* FZFProjectMru call s:fzf_projectmru(<q-args>)
  command! -nargs=* -bang FZFUpdateMru call s:cmd_update_mru(<bang>0, <q-args>)
endif

"-------------------------------
" vim-qf
if s:plug.is_installed('vim-qf')
  nmap <SubLeader>q <Plug>(qf_qf_toggle_stay)
  nmap <SubLeader>l <Plug>(qf_loc_toggle_stay)
endif

"-------------------------------
" spelunker.vim
if s:plug.is_installed('spelunker.vim')
  let g:enable_spelunker_vim = 1
  " override
  command! AddCorrectSpell :execute "normal Zg"
  command! AddWrongSpell  :execute "normal Zw"
  command! ChangeCorrectSpell  :execute ':call feedkeys("Z=")'
  command! FixCorrectSpell  :execute ':ChangeCorrectSpell'
  command! CorrectSpell  :execute ':ChangeCorrectSpell'
endif

"-------------------------------
" vista.vim
if s:plug.is_installed('vista.vim')
  " Position to open the vista sidebar. On the right by default.
  " Change to 'vertical topleft' to open on the left.
  let g:vista_sidebar_position = 'vertical botright'
  " Width of vista sidebar.
  let g:vista_sidebar_width = 30
  " Set this flag to 0 to disable echoing when the cursor moves.
  let g:vista_echo_cursor = 1
  " Time delay for showing detailed symbol info at current cursor.
  let g:vista_cursor_delay = 400
  " Close the vista window automatically close when you jump to a symbol.
  let g:vista_close_on_jump = 0
  " Move to the vista window when it is opened.
  let g:vista_stay_on_open = 1
  " Blinking cursor 2 times with 100ms interval after jumping to the tag.
  let g:vista_blink = [2, 100]
  " How each level is indented and what to prepend.
  " This could make the display more compact or more spacious.
  " e.g., more compact: ["▸ ", ""]
  let g:vista_icon_indent = [" => ", " |-"]
  " Executive used when opening vista sidebar without specifying it.
  " Avaliable: 'coc', 'ctags'. 'ctags' by default.
  let g:vista_default_executive = 'ctags'
  " Declare the command including the executable and options used to generate ctags output
  " for some certain filetypes.The file path will be appened to your custom command.
  " For example:
  let g:vista_ctags_cmd = {
        \ 'haskell': 'hasktags -o - -c',
        \ }
  " To enable fzf's preview window set g:vista_fzf_preview.
  " The elements of g:vista_fzf_preview will be passed as arguments to fzf#vim#with_preview()
  " For example:
  let g:vista_fzf_preview = ['right:50%']
  " Fall back to other executives if the specified one gives empty data.
  " By default it's all the provided executives excluding the tried one.
  " let g:vista_finder_alternative_executives = ['coc']
endif

"-------------------------------
" asyncomplete.vim
if s:plug.is_installed('asyncomplete.vim')
  inoremap <expr> <Tab> pumvisible() ? "\<C-n>" : "\<Tab>"
  inoremap <expr> <S-Tab> pumvisible() ? "\<C-p>" : "\<S-Tab>"
  inoremap <expr> <cr> pumvisible() ? "\<C-y>" : "\<cr>"
  let g:asyncomplete_remove_duplicates = 1
  let g:asyncomplete_smart_completion = 1
  let g:asyncomplete_auto_popup = 1
  set completeopt+=preview
  autocmd! CompleteDone * if pumvisible() == 0 | pclose | endif
endif

"-------------------------------
" vim-xtabline
if s:plug.is_installed('vim-xtabline')
  " let g:xtabline_lazy = 1
  let g:xtabline_settings = {}
  let g:xtabline_settings.theme = 'codedark'
  let g:xtabline_settings.map_prefix = '<Leader>x'
  let g:xtabline_settings.enable_mappings = 1
  let g:xtabline_settings.bufline_format = ' N I< l +'
  nmap <F2> <Plug>(XT-Prev-Buffer)
  nmap <F3> <Plug>(XT-Next-Buffer)
  nmap <F4> <Plug>(XT-Close-Buffer)
  nmap <S-F4> <Plug>(XT-Close-Buffer)
  nmap <C-F4> <Plug>(XT-Close-Buffer)

  fun! s:xtabline_init_variables()
    let s:X    = g:xtabline
    let s:T    =  { -> s:X.Tabs[tabpagenr()-1] }       "current tab
    let s:oB   =  { -> s:T().buffers.order     }       "ordered buffers for tab
  endfun

  fun! Xtabline_move_buffer_next()
    call s:xtabline_init_variables()
    let b = bufnr("%") | let oB = s:oB() | let max = len(oB) - 1
    let i = index(oB, b)
    if i + 1 > max
      call xtabline#cmds#run('move_buffer', 0)
    else
      call xtabline#cmds#run('move_buffer', i + 1)
    endif
  endfun

  fun! Xtabline_move_buffer_prev()
    call s:xtabline_init_variables()
    let b = bufnr("%") | let oB = s:oB() | let max = len(oB) - 1
    let i = index(oB, b)
    if i - 1 < 0
      call xtabline#cmds#run('move_buffer', max)
    else
      call xtabline#cmds#run('move_buffer', i - 1)
    endif
  endfun
  nnoremap <C-M-F2> :<C-u>call Xtabline_move_buffer_prev()<CR>
  nnoremap <C-M-F3> :<C-u>call Xtabline_move_buffer_next()<CR>
endif

"-------------------------------
" open-browser
if s:plug.is_installed('open-browser.vim')
  command! OpenBrowserCurrent :execute 'OpenBrowser ' . expand('<cWORD>')
endif

"-------------------------------
" suda.vim
if s:plug.is_installed('suda.vim')
  let g:suda_smart_edit = 1
endif

"-------------------------------
" float-preview.nvim
if s:plug.is_installed('float-preview.nvim')
  let g:float_preview#docked = 0
endif

"-------------------------------
" coc.nvim
if s:plug.is_installed('coc.nvim')
  " Use tab for trigger completion with characters ahead and navigate.
  " Use command ':verbose imap <tab>' to make sure tab is not mapped by other plugin.
  inoremap <silent><expr> <TAB>
        \ pumvisible() ? "\<C-n>" :
        \ <SID>check_back_space() ? "\<TAB>" :
        \ coc#refresh()
  inoremap <expr><S-TAB> pumvisible() ? "\<C-p>" : "\<C-h>"

  function! s:check_back_space() abort
    let col = col('.') - 1
    return !col || getline('.')[col - 1]  =~# '\s'
  endfunction

  " Use <c-space> to trigger completion.
  inoremap <silent><expr> <c-space> coc#refresh()
  " Use <cr> to confirm completion, `<C-g>u` means break undo chain at current position.
  " Coc only does snippet and additional edit on confirm.
  inoremap <expr> <cr> pumvisible() ? "\<C-y>" : "\<C-g>u\<CR>"

  " Use `[c` and `]c` to navigate diagnostics
  nmap <silent> [c <Plug>(coc-diagnostic-prev)
  nmap <silent> ]c <Plug>(coc-diagnostic-next)
  " Remap keys for gotos
  nmap <silent> gd <Plug>(coc-definition)
  nmap <silent> gy <Plug>(coc-type-definition)
  nmap <silent> gi <Plug>(coc-implementation)
  nmap <silent> gr <Plug>(coc-references)

  " Use K to show documentation in preview window
  nnoremap <silent> K :call <SID>show_documentation()<CR>

  function! s:show_documentation()
    if (index(['vim','help'], &filetype) >= 0)
      execute 'h '.expand('<cword>')
    else
      call CocAction('doHover')
    endif
  endfunction

  " Highlight symbol under cursor on CursorHold
  autocmd CursorHold * silent call CocActionAsync('highlight')
  " Remap for rename current word
  nmap <Leader>lrn <Plug>(coc-rename)
  " Remap for format selected region
  xmap <Leader>lf  <Plug>(coc-format-selected)
  nmap <Leader>lf  <Plug>(coc-format-selected)

  augroup mygroup
    autocmd!
    " Setup formatexpr specified filetype(s).
    autocmd FileType typescript,json setl formatexpr=CocAction('formatSelected')
    " Update signature help on jump placeholder
    autocmd User CocJumpPlaceholder call CocActionAsync('showSignatureHelp')
  augroup end

  " Remap for do codeAction of selected region, ex: `<Leader>aap` for current paragraph
  xmap <Leader>la  <Plug>(coc-codeaction-selected)
  nmap <Leader>la  <Plug>(coc-codeaction-selected)
  " Remap for do codeAction of current line
  nmap <Leader>lac  <Plug>(coc-codeaction)
  " Fix autofix problem of current line
  nmap <Leader>lqf  <Plug>(coc-fix-current)
  " Use `:Format` to format current buffer
  command! -nargs=0 Format :call CocAction('format')
  " Use `:Fold` to fold current buffer
  command! -nargs=? Fold :call     CocAction('fold', <f-args>)

  " Using CocList
  nnoremap <silent> <Leader>lm  :<C-u>CocList<cr>
  " Show all diagnostics
  nnoremap <silent> <Leader>ld  :<C-u>CocList diagnostics<cr>
  " Manage extensions
  nnoremap <silent> <Leader>le  :<C-u>CocList extensions<cr>
  " Show commands
  nnoremap <silent> <Leader>lc  :<C-u>CocList commands<cr>
  " Find symbol of current document
  nnoremap <silent> <Leader>lo  :<C-u>CocList outline<cr>
  " Search workLeader symbols
  nnoremap <silent> <Leader>ls  :<C-u>CocList -I symbols<cr>
  " Do default action for next item.
  nnoremap <silent> <Leader>lj  :<C-u>CocNext<CR>
  " Do default action for previous item.
  nnoremap <silent> <Leader>lk  :<C-u>CocPrev<CR>
  " Resume latest coc list
  nnoremap <silent> <Leader>lp  :<C-u>CocListResume<CR>

  command! CocInstallAll :CocInstall
        \ coc-tag
        \ coc-dictionary
        \ coc-word
        \ coc-emoji
        \ coc-omni
        \ coc-syntax
        " \ coc-highlight " -> RRethy/vim-illuminate
        \ coc-emmet
        \ coc-lists
        \ coc-snippets
        \ coc-neosnippet
        " \ coc-git " -> gitgutter
        \ coc-yank
        \ coc-json
        \ coc-yaml
        \ coc-sh
        \ coc-python
        \ coc-rls
        \ coc-html
        \ coc-css
        \ coc-diagnostic

  " coc-snippets
  imap <C-l> <Plug>(coc-snippets-expand)
  vmap <C-j> <Plug>(coc-snippets-select)
  let g:coc_snippet_next = '<c-j>'
  let g:coc_snippet_prev = '<c-k>'
  imap <C-j> <Plug>(coc-snippets-expand-jump)
  inoremap <silent><expr> <cr> pumvisible() ? coc#_select_confirm() :
                                           \"\<C-g>u\<CR>\<c-r>=coc#on_enter()\<CR>"
  " inoremap <silent><expr> <TAB>
  "       \ pumvisible() ? coc#_select_confirm() :
  "       \ coc#expandableOrJumpable() ? "\<C-r>=coc#rpc#request('doKeymap', ['snippets-expand-jump',''])\<CR>" :
  "       \ <SID>check_back_space() ? "\<TAB>" :
  "       \ coc#refresh()
  " function! s:check_back_space() abort
  "   let col = col('.') - 1
  "   return !col || getline('.')[col - 1]  =~# '\s'
  " endfunction
  " let g:coc_snippet_next = '<tab>'

  " coc-yank
  highlight HighlightedyankRegion term=bold ctermbg=0 guibg=#13354A
  nnoremap <silent> <Leader>y  :<C-u>CocList -A --normal yank<cr>
endif

" }}}


"===============================================================
"          Disable Plugin Settings                           {{{
"===============================================================

" "-------------------------------
" " vim-marching
" if s:plug.is_installed('vim-marching')
  " " clang コマンドの設定
  " let g:marching_clang_command = 'clang'
  " " オプションを追加する
  " " filetype=cpp に対して設定する場合
  " let g:marching#clang_command#options = {
        " \   'c'   : '-stdlib=libstdc --pedantic-errors',
        " \   'cpp' : '-std=c++11 -stdlib=libstdc++ --pedantic-errors'
        " \}
  " " インクルードディレクトリのパスを設定
  " let g:marching_include_paths = filter(copy(split(&path, ',')), "v:val !~? '^$'")
  " " neocomplete.vim と併用して使用する場合
  " let g:marching_enable_neocomplete = 1
  " if !exists('g:neocomplete#force_omni_input_patterns')
    " let g:neocomplete#force_omni_input_patterns = {}
  " endif
  " let g:neocomplete#force_omni_input_patterns.cpp =
        " \ '[^.[:digit:] *\t]\%(\.\|->\)\w*\|\h\w*::\w*'
  " " 処理のタイミングを制御する
  " " 短いほうがより早く補完ウィンドウが表示される
  " " ただし、marching.vim 以外の処理にも影響するので注意する
  " set updatetime=100
  " " オムニ補完時に補完ワードを挿入したくない場合
  " imap <buffer> <C-x><C-o> <Plug>(marching_start_omni_complete)
  " " キャッシュを削除してからオムに補完を行う
  " imap <buffer> <C-x><C-x><C-o> <Plug>(marching_force_start_omni_complete)
  " " 非同期ではなくて、同期処理でコード補完を行う場合
  " " この設定の場合は vimproc.vim に依存しない
  " " let g:marching_backend = 'sync_clang_command'
" endif

"-------------------------------
"" vim-tags
"if s:plug.is_installed('vim-tags')
"let g:vim_tags_auto_generate = 1
"let g:vim_tags_use_vim_dispatch = 0
"endif

"-------------------------------
"" syntastic
"if s:plug.is_installed('syntastic')
"let g:syntastic_always_populate_loc_list = 1
"let g:syntastic_enable_signs = 1
"let g:syntastic_auto_loc_list = 0
"let g:syntastic_check_on_open = 0
"let g:syntastic_check_on_wq = 0
"let g:syntastic_check_on_save = 1
"endif

"-------------------------------
"" SrcExpl
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
"-------------------------------
"" Trinity
"nmap <F8>   :TrinityToggleAll<CR>
"nmap <F9>   :TrinityToggleSourceExplorer<CR>
"nmap <F10>  :TrinityToggleTagList<CR>
"nmap <F11>  :TrinityToggleNERDTree<CR>
"nmap <C-j> <C-]>

"-------------------------------
"" Taglist
"if s:plug.is_installed('Taglist')
"  echo "a"
"let Tlist_Show_One_File = 1                   " 現在表示中のファイルのみのタグしか表示しない
"let Tlist_Exit_OnlyWindow = 1                 " taglistのウインドウだけならVimを閉じる
"let Tlist_WinWidth = 50
"endif

"-------------------------------
"" im_control.vim
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

