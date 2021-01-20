"===============================================================
"          Disable Plugin Settings                           {{{
"===============================================================

"==============================
" etc                       {{{
"==============================

"-------------------------------
" auto-pairs
if s:plug.is_installed('auto-pairs')
  let g:AutoPairsShortcutToggle = ''
  " let g:AutoPairsOnlyAtEOL = 1
  let g:AutoPairsOnlyBeforeClose = 1
  command! AutoPairsToggle call AutoPairsToggle()
endif

"-------------------------------
" accelerated-jk
if s:plug.is_installed('accelerated-jk')
  let g:accelerated_jk_acceleration_table = [30,60,80,85,90,95,100]
  nmap <expr> j v:count ? '<Plug>(accelerated_jk_j)' : '<Plug>(accelerated_jk_gj)'
  nmap <expr> k v:count ? '<Plug>(accelerated_jk_k)' : '<Plug>(accelerated_jk_gk)'
endif

"-------------------------------
" vim-buffergator
if s:plug.is_installed('vim-buffergator')
  let g:buffergator_viewport_split_policy = 'T'
  let g:buffergator_hsplit_size = 10
  let g:buffergator_suppress_keymaps = 1
  nmap <S-F12> <Cmd>BuffergatorToggle<CR>
  " nmap <S-F9> :<CR>
  " nmap <C-F9> :<CR>
  " nmap <C-S-F9> :<CR>
endif

"-------------------------------
" vim-session
if s:plug.is_installed('vim-session')
  function! s:session_config(dir) abort
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
  " let s:local_session_directory = xolox#misc#path#merge(getcwd(), '.vim/sessions')
  let s:global_session_directory = expand('~/.local/share/nvim/sessions')
  call mkdir(s:global_session_directory, 'p')

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
  " highlight link TagbarHighlight PmenuSel
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
" fzf-mru.vim
if s:plug.is_installed('fzf-mru.vim')
  let g:fzf_mru_relative = 0
  nnoremap <Leader>; <Cmd>FZFMru<CR>
endif

"-------------------------------
" fzf-filemru
if s:plug.is_installed('fzf-filemru')
  augroup vimrc_fzf_filemru
    autocmd!
    autocmd BufEnter * UpdateMru
  augroup END
  let g:fzf_filemru_git_ls = 1
  function! s:fzf_file_mru_without_find(args) abort
    let l:fzf_default_tmp = $FZF_DEFAULT_COMMAND
    let $FZF_DEFAULT_COMMAND = ':'
    execute a:args
    let $FZF_DEFAULT_COMMAND = l:fzf_default_tmp
  endfunction
  command! -nargs=* FZFFileMru FilesMru
  command! -nargs=* FZFProjectMru call s:fzf_file_mru_without_find('ProjectMru')
  command! -nargs=* -bang FZFUpdateMru call s:fzf_file_mru_without_find('UpdateMru')
  nnoremap <Leader>. <Cmd>FZFFileMru<CR>
  nnoremap <Leader>p <Cmd>FZFProjectMru<CR>
endif

"-------------------------------
" defx.nvim
if s:plug.is_installed('defx.nvim')
  function! s:defx_my_settings() abort
    " Define mappings
    nnoremap <silent><buffer><expr> <CR>
          \ defx#do_action('drop')
    nnoremap <silent><buffer><expr> c
          \ defx#do_action('copy')
    nnoremap <silent><buffer><expr> m
          \ defx#do_action('move')
    nnoremap <silent><buffer><expr> p
          \ defx#do_action('paste')
    nnoremap <silent><buffer><expr> l
          \ defx#do_action('open_directory')
    nnoremap <silent><buffer><expr> E
          \ defx#do_action('open', 'vsplit')
    nnoremap <silent><buffer><expr> P
          \ defx#do_action('open', 'pedit')
    nnoremap <silent><buffer><expr> o
          \ defx#do_action('open_or_close_tree')
    nnoremap <silent><buffer><expr> K
          \ defx#do_action('new_directory')
    nnoremap <silent><buffer><expr> N
          \ defx#do_action('new_file')
    nnoremap <silent><buffer><expr> M
          \ defx#do_action('new_multiple_files')
    nnoremap <silent><buffer><expr> C
          \ defx#do_action('toggle_columns',
          \                'mark:indent:icon:filename:type:size:time')
    nnoremap <silent><buffer><expr> S
          \ defx#do_action('toggle_sort', 'time')
    nnoremap <silent><buffer><expr> d
          \ defx#do_action('remove')
    nnoremap <silent><buffer><expr> r
          \ defx#do_action('rename')
    nnoremap <silent><buffer><expr> !
          \ defx#do_action('execute_command')
    nnoremap <silent><buffer><expr> x
          \ defx#do_action('execute_system')
    nnoremap <silent><buffer><expr> yy
          \ defx#do_action('yank_path')
    nnoremap <silent><buffer><expr> .
          \ defx#do_action('toggle_ignored_files')
    nnoremap <silent><buffer><expr> ;
          \ defx#do_action('repeat')
    nnoremap <silent><buffer><expr> h
          \ defx#do_action('cd', ['..'])
    nnoremap <silent><buffer><expr> ~
          \ defx#do_action('cd')
    nnoremap <silent><buffer><expr> q
          \ defx#do_action('quit')
    nnoremap <silent><buffer><expr> <Esc>
          \ defx#do_action('quit')
    nnoremap <silent><buffer><expr> <Space>
          \ defx#do_action('toggle_select') . 'j'
    nnoremap <silent><buffer><expr> *
          \ defx#do_action('toggle_select_all')
    nnoremap <silent><buffer><expr> j
          \ line('.') == line('$') ? 'gg' : 'j'
    nnoremap <silent><buffer><expr> k
          \ line('.') == 1 ? 'G' : 'k'
    nnoremap <silent><buffer><expr> <C-l>
          \ defx#do_action('redraw')
    nnoremap <silent><buffer><expr> <C-g>
          \ defx#do_action('print')
    nnoremap <silent><buffer><expr> cd
          \ defx#do_action('change_vim_cwd')
  endfunction
  command! DefxProject Defx -split=vertical -winwidth=30 -direction=topleft -toggle -resume
  nnoremap <F12> <Cmd>Vista!!<CR>:DefxProject<CR>

  augroup vimrc_defx
    autocmd!
    autocmd FileType defx call s:defx_my_settings()
    autocmd VimEnter * sil! au! FileExplorer *
    autocmd BufEnter * if vimrc#is_dir(expand('%')) | bd | exe 'Defx' | endif
  augroup END
endif

"-------------------------------
" fila.vim
if s:plug.is_installed('fila.vim')
  nnoremap <F12> <Cmd>Vista!!<CR>:Fila -drawer<CR>
endif
"-------------------------------
" vim-dispatch
if s:plug.is_installed('vim-dispatch')
  nnoremap <Leader>R <Cmd>Copen<Bar>Dispatch<CR>
  " nnoremap <SubLeader>q   <Cmd>Copen<CR>
  nnoremap <make><CR> <Cmd>Make
endif
"-------------------------------
" vim-dirvish
if s:plug.is_installed('vim-dirvish')
  let g:dirvish_mode = ':sort r /[^\/]$/'
endif
"-------------------------------
" vim-buftabline
if s:plug.is_installed('vim-buftabline')
  let g:buftabline_show = 1
  let g:buftabline_numbers = 2
  let g:buftabline_indicators = 1
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
" vim-anzu
if s:plug.is_installed('vim-anzu')
  " mapping
  nmap n <Plug>(anzu-n-with-echo)
  nmap N <Plug>(anzu-N-with-echo)
  nmap g* <Plug>(anzu-star-with-echo)n
  nmap g# <Plug>(anzu-sharp-with-echo)N
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
" hybrid
if s:plug.is_installed('vim-hybrid')
  let s:lightline_colorscheme = 'wombat'
  set background=dark
  colorscheme hybrid
endif
 fzf.vim
 else

   function! FzfOmniFiles()
     let is_git = system('git status')
     if v:shell_error
       :FZFFiles
     else
       :FZFGFiles
     endif
   endfunction
   nnoremap <Leader>p <Cmd>call FzfOmniFiles()<CR>
   nnoremap <Leader>f; <Cmd>FZF<CR>
   nnoremap <Leader>. <Cmd>FZF<CR>
   nnoremap <Leader>ag <Cmd>FZFAg <C-R>=expand("<cword>")<CR><CR>
   nnoremap <Leader>rg <Cmd>FZFRg <C-R>=expand("<cword>")<CR><CR>
   nnoremap <Leader>fb <Cmd>FZFBuffers<CR>
   nnoremap <Leader>fc <Cmd>FZFCommands<CR>

   command! FZFOmniFiles call FzfOmniFiles()
   command! FZFMruSimple call fzf#run({
         \ 'source':  reverse(s:all_files()),
         \ 'sink':    'edit',
         \ 'options': '-m -x +s',
         \ 'down':    '40%' })

   function! s:all_files() abort
     return extend(
           \ filter(copy(v:oldfiles),
           \        "v:val !~ 'fugitive:\\|NERD_tree\\|^/tmp/\\|.git/'"),
           \ map(filter(range(1, bufnr('$')), 'buflisted(v:val)'), 'bufname(v:val)'))
   endfunction
   nnoremap <Leader>; <Cmd>FZFMruSimple<CR>
   command! -bang -nargs=* GGrep
         \ call fzf#vim#grep(
         \   'git grep --line-number '.shellescape(<q-args>), 0,
         \   fzf#vim#with_preview({ 'dir': systemlist('git rev-parse --show-toplevel')[0]  }), <bang>0 )

   command! -bang -nargs=* FZFGrep
         \  call fzf#vim#grep('grep --line-number --ignore-case --recursive --exclude=".git/*" --color="always" '.shellescape(<q-args>), 0, <bang>0)
   function! s:fzf_unite_grep(args) abort
     if executable('rg')
       execute 'FZFRg ' . a:args
     elseif executable('ag')
       execute 'FZFAg ' . a:args
     else
       execute 'FZFGrep ' . a:args
     endif
   endfunction
   nmap <Leader>, <Cmd>FZFSearch<Space>
   command! -bang -nargs=* FZFSearch call s:fzf_unite_grep(<q-args>)
   command! -bang FZFTodo FZFSearch FIXME|TODO<CR>

   let $FZF_DEFAULT_OPTS = '--bind ctrl-a:select-all --preview
         \ "
         \ if [[ $(file --mime {}) =~ /directory ]]; then
         \   echo {} is a directory;
         \ elif [[ $(file --mime {}) =~ binary ]]; then
         \   echo {} is a binary file;
         \ elif [[ {} == *:* ]]; then
         \   f=$(echo {} | cut -d : -f 1); n=$(echo {} | cut -d : -f 2) &&
         \    ((bat --color=always --style=grid $f ||
         \      highlight -O ansi -l $f ||
         \      coderay $f ||
         \      rougify $f ||
         \     tail +$n $f) 2> /dev/null | tail +$n | head -500);
         \ elif [[ -e $(echo {} | cut -d \" \" -f 2 2> /dev/null) ]]; then
         \   f=$(echo {} | cut -d \" \" -f 2);
         \    ((bat --color=always --style=grid $f ||
         \      highlight -O ansi -l $f ||
         \      coderay $f ||
         \      rougify $f) 2> /dev/null | head -500);
         \ elif [[ ! -e {} ]]; then
         \   :
         \ else
         \   (bat --color=always {} ||
         \    highlight -O ansi -l {} ||
         \    coderay {} ||
         \    rougify {} ||
         \    cat {} | head -500) 2> /dev/null;
         \ fi
         \ "
         \ --bind "?:toggle-preview"
         \ --preview-window hidden:wrap
         \ '

   " floating fzf
   if has('nvim')
     let $FZF_DEFAULT_OPTS .= '--border --margin=0,2 --layout=reverse'
     function! FloatingFZF()
       let width = float2nr(&columns * 0.9)
       let height = float2nr(&lines * 0.6)
       let opts = {
             \ 'relative': 'editor',
             \ 'row': (&lines - height) / 2,
             \ 'col': (&columns - width) / 2,
             \ 'width': width,
             \ 'height': height,
             \ 'style': 'minimal'
             \ }

       let win = nvim_open_win(nvim_create_buf(v:false, v:true), v:true, opts)
       call setwinvar(win, '&winhighlight', 'NormalFloat:Normal')
     endfunction

     let g:fzf_layout = { 'window': 'call FloatingFZF()' }
   endif
"-------------------------------
" vim-hybrid
if s:plug.is_installed('vim-hybrid')
  let g:hybrid_custom_term_colors = 1
  let g:hybrid_reduced_contrast = 1
  set background=dark
  colorscheme hybrid
  highlight! VertSplit ctermfg=236 ctermbg=236 guibg=#2c2c2c guifg=#2c2c2c
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
  highlight! clear CursorLineNr
  highlight CursorLineNr ctermfg=8 cterm=bold guifg=#8F8F8F
  highlight GitGutterAdd      ctermfg=65 ctermbg=NONE guifg=#5F875F guibg=NONE
  highlight GitGutterChange   ctermfg=60 ctermbg=NONE guifg=#5F5F87 guibg=NONE
  highlight GitGutterDelete   ctermfg=9  ctermbg=NONE guifg=#cc6666 guibg=NONE
  highlight TabLineSel ctermbg=252 ctermfg=235 guibg=#d0d0d0 guifg=#242424
  highlight PmenuSel ctermbg=236 ctermfg=244 guibg=#353535 guibg=#808080
  highlight Tabline ctermbg=248 ctermfg=238 guibg=#a8a8a8 guifg=#444444
  highlight TabLineFill ctermbg=248 ctermfg=238 guibg=#a8a8a8 guifg=#444444
  highlight clear SpellBad
  highlight SpellBad cterm=underline gui=undercurl ctermbg=NONE
        \ ctermfg=NONE guibg=NONE guifg=NONE guisp=NONE
  highlight QuickScopePrimary guifg=#afff5f gui=underline ctermfg=155 cterm=underline
  highlight QuickScopeSecondary guifg=#5fffff gui=underline ctermfg=81 cterm=underline
  highlight! default link CocErrorHighlight WarningMsg
  highlight! default link CocErrorSign CocErrorHighlight
  highlight! CocWarningSign  ctermfg=Brown guifg=#ff922b
  highlight! default link CocInfoSign Title
  highlight! default link CocHintSign Question
  highlight clear SignColumn
  highlight DiffAdd      ctermfg=65 ctermbg=NONE guifg=#5F875F guibg=NONE
  highlight DiffChange   ctermfg=60 ctermbg=NONE guifg=#5F5F87 guibg=NONE
  highlight DiffDelete   ctermfg=9  ctermbg=NONE guifg=#cc6666 guibg=NONE
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
" deoplete-rust
if s:plug.is_installed('deoplete-rust')
  let g:deoplete#sources#rust#racer_binary=$HOME . '/.cargo/bin/racer'
  let g:deoplete#sources#rust#rust_source_path= substitute(system("rustup which rustc | xargs dirname"), '\n\+$', '', '')
        \ . '/../lib/rustlib/src/rust/src'
  let g:deoplete#sources#rust#show_duplicates=1
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
    function! SetLSPShortcuts() abort
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

    augroup vimrc_lsp
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
  nnoremap [denite]f <Cmd>Denite file_rec<CR>
  nnoremap [denite]g <Cmd>Denite grep<CR>
  nnoremap [denite]l <Cmd>Denite line<CR>
  nnoremap [denite]u <Cmd>Denite file_mru<CR>
  nnoremap [denite]y <Cmd>Denite neoyank<CR>
  nmap <F8> <Cmd>DeniteCursorWord<Space>grep<CR>
  nmap <S-F8> <Cmd>DeniteProjectDir<Space>grep<CR>
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
  command! DeopleteDisable call deoplete#disable()
  command! DeopleteEnable call deoplete#enable()
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
" vim-racer
if s:plug.is_installed('vim-racer')
  set hidden
  let g:racer_cmd = $HOME . '/.cargo/bin/racer'
  let g:racer_experimental_completer = 1
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
  augroup vimrc_neomake
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
" ctrlp.vim
if s:plug.is_installed('ctrlp.vim')
  nnoremap [ctrlp] <Nop>
  nmap <SubLeader>p [ctrlp]
  nnoremap [ctrlp]a <Cmd>CtrlP<Space>
  nnoremap [ctrlp]c <Cmd>CtrlPCurWD<CR>
  nnoremap [ctrlp]b <Cmd>CtrlPBuffer<CR>
  nnoremap [ctrlp]d <Cmd>CtrlPDir<CR>
  nnoremap [ctrlp]f <Cmd>CtrlP<CR>
  nnoremap [ctrlp]l <Cmd>CtrlPLine<CR>
  nnoremap [ctrlp]m <Cmd>CtrlPMRUFiles<CR>
  nnoremap [ctrlp]q <Cmd>CtrlPQuickfix<CR>
  nnoremap [ctrlp]s <Cmd>CtrlPMixed<CR>
  nnoremap [ctrlp]t <Cmd>CtrlPTag<CR>
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

  augroup vimrc_jedi
    autocmd!
    autocmd FileType python setlocal completeopt-=preview
    if (v:version == 704 && has('patch775')) || v:version >= 705
      autocmd FileType python setlocal completeopt+=noselect
    endif
  augroup END

  " for w/ neocomplete
  if s:plug.is_installed('neocomplete.vim')
    augroup vimrc_jedi2
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
  let g:neosnippet#snippets_directory=[
        \ '~/.vim/snippets',
        \ g:plug_home . '/neosnippet-snippets/neosnippets',
        \ g:plug_home . '/vim-snippets/snippets'
        \ ]
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
  function! s:my_cr_function() abort
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
  augroup vimrc_neocomplete
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
  function! s:my_cr_function() abort
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
  augroup vimrc_neocomplcache
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
  nnoremap [unite]u <Cmd>Unite<Space>file<CR>
  nnoremap [unite]g <Cmd>Unite<Space>grep<CR>
  nnoremap [unite]f <Cmd>Unite<Space>buffer<CR>
  nnoremap [unite]b <Cmd>Unite<Space>bookmark<CR>
  nnoremap [unite]a <Cmd>UniteBookmarkAdd<CR>
  nnoremap [unite]m <Cmd>Unite<Space>file_mru<CR>
  nnoremap [unite]h <Cmd>Unite<Space>history/yank<CR>
  nnoremap [unite]r <Cmd>Unite -buffer-name=register register<CR>
  nnoremap [unite]c <Cmd>UniteWithBufferDir -buffer-name=files file<CR>
  nnoremap <SubLeader>vr <Cmd>UniteResume<CR>
  " unite-build map
  nnoremap <SubLeader>vb <Cmd>Unite build<CR>
  nnoremap <SubLeader>vcb <Cmd>Unite build:!<CR>
  nnoremap <SubLeader>vch <Cmd>UniteBuildClearHighlight<CR>
  "let g:unite_source_grep_command = 'ag'
  "let g:unite_source_grep_default_opts = '--nocolor --nogroup'
  "let g:unite_source_grep_max_candidates = 200
  let g:unite_source_grep_recursive_opt = '-rI'
  " unite-grepの便利キーマップ
  vnoremap /g y:Unite grep::-iHRn:<C-R>=escape(@", '\\.*$^[]')<CR><CR>
  nmap <F8> <Cmd>UniteWithCursorWord<Space>grep:%<CR>
  nmap <S-F8> <Cmd>UniteWithCurrentDir<Space>grep<CR>
  nmap <C-F8> <Cmd>UniteWithBufferDir<Space>grep<CR>
  nmap <C-S-F8> <Cmd>UniteWithProjectDir<Space>grep<CR>
  " ファイルを開く時、ウィンドウを分割して開く
  augroup vimrc_unite
    autocmd!
    autocmd FileType unite nnoremap <silent> <buffer> <expr> <C-s> unite#do_action('split')
    autocmd FileType unite inoremap <silent> <buffer> <expr> <C-s> unite#do_action('split')
    " ファイルを開く時、ウィンドウを縦に分割して開く
    autocmd FileType unite nnoremap <silent> <buffer> <expr> <C-v> unite#do_action('vsplit')
    autocmd FileType unite inoremap <silent> <buffer> <expr> <C-v> unite#do_action('vsplit')
    " ESCキーを2回押すと終了する
    autocmd FileType unite nnoremap <buffer> <ESC><ESC> <Cmd>q<CR>
    autocmd FileType unite inoremap <buffer> <ESC><ESC> <Cmd>q<CR>
  augroup END
endif

"-------------------------------
" vim-marching
if s:plug.is_installed('vim-marching')
" clang コマンドの設定
let g:marching_clang_command = 'clang'
" オプションを追加する
" filetype=cpp に対して設定する場合
let g:marching#clang_command#options = {
\   'c'   : '-stdlib=libstdc --pedantic-errors',
\   'cpp' : '-std=c++11 -stdlib=libstdc++ --pedantic-errors'
\}
" インクルードディレクトリのパスを設定
let g:marching_include_paths = filter(copy(split(&path, ',')), "v:val !~? '^$'")
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
" let g:marching_backend = 'sync_clang_command'
endif

"-------------------------------
" vim-tags
if s:plug.is_installed('vim-tags')
let g:vim_tags_auto_generate = 1
let g:vim_tags_use_vim_dispatch = 0
endif

"-------------------------------
" syntastic
if s:plug.is_installed('syntastic')
let g:syntastic_always_populate_loc_list = 1
let g:syntastic_enable_signs = 1
let g:syntastic_auto_loc_list = 0
let g:syntastic_check_on_open = 0
let g:syntastic_check_on_wq = 0
let g:syntastic_check_on_save = 1
endif

"-------------------------------
" SrcExpl
nmap <F8> <Cmd>SrcExplToggle<CR>
let g:SrcExpl_winHeight = 8
let g:SrcExpl_refreshTime = 100
let g:SrcExpl_gobackKey = "<SPACE>"
let g:SrcExpl_pluginList = [
        \ "__Tag_List__",
        \ "NERD_tree_1",
        \ "[quickrun output]",
        \ "[unite] - default",
        \ "vimfiler:default",
        \ "ControlP",
        \ "Source_Explorer"
        \ ]
let g:SrcExpl_searchLocalDef = 0
let g:SrcExpl_isUpdateTags = 0
let g:SrcExpl_updateTagsKey = "<F12>"
let g:SrcExpl_updateTagsCmd = "ctags --sort=foldcase -R ."

"-------------------------------
" Trinity
nmap <F8>   <Cmd>TrinityToggleAll<CR>
nmap <F9>   <Cmd>TrinityToggleSourceExplorer<CR>
nmap <F10>  <Cmd>TrinityToggleTagList<CR>
nmap <F11>  <Cmd>TrinityToggleNERDTree<CR>
nmap <C-j> <C-]>

"-------------------------------
" Taglist
if s:plug.is_installed('Taglist')
  echo "a"
let Tlist_Show_One_File = 1                   " 現在表示中のファイルのみのタグしか表示しない
let Tlist_Exit_OnlyWindow = 1                 " taglistのウインドウだけならVimを閉じる
let Tlist_WinWidth = 50
endif

"-------------------------------
" im_control.vim
if s:plug.is_installed('im_control.vim')
" 「日本語入力固定モード」切替キー
inoremap <silent> <C-j> <C-r>=IMState('FixMode')<CR>
" PythonによるIBus制御指定
let IM_CtrlIBusPython = 1

" <ESC>押下後のIM切替開始までの反応が遅い場合はttimeoutlenを短く設定してみてください。
set timeout timeoutlen=3000 ttimeoutlen=10
endif


"===============================
" lightline                  {{{
"===============================
  "-------------------------------
  " Disable configs
  " syntastic
  "      \ 'component_expand': {
  "      \   'syntastic': 'SyntasticStatuslineFlag',
  "      \ },
  "      \ 'component_type': {
  "      \   'syntastic': 'error',
  "      \ },

  " augroup vimrc_syntastic
  " autocmd!
  " autocmd BufWritePost *.c,*.cpp,*.cc call s:syntastic()
  " augroup END
  " function! s:syntastic() abort
  " SyntasticCheck
  " call lightline#update()
  " endfunction

  " function! LightLineGitGutter() abort
  "   if ! exists('*GitGutterGetHunkSummary')
  "         \ || ! get(g:, 'gitgutter_enabled', 0)
  "         \ || winwidth('.') <= 90
  "     return ''
  "   endif
  "   let symbols = [
  "         \ g:gitgutter_sign_added . ' ',
  "         \ g:gitgutter_sign_modified . ' ',
  "         \ g:gitgutter_sign_removed . ' '
  "         \ ]
  "   let hunks = GitGutterGetHunkSummary()
  "   let ret = []
  "   for i in [0, 1, 2]
  "     if hunks[i] > 0
  "       call add(ret, symbols[i] . hunks[i])
  "     endif
  "   endfor
  "   return join(ret, ' ')
  " endfunction

  " let g:tagbar_status_func = 'TagbarStatusFunc'
  "
  " function! TagbarStatusFunc(current, sort, fname, ...) abort
  "   let g:lightline.fname = a:fname
  "   return lightline#statusline(0)
  " endfunction

  " function! LightLineFugitive() abort
  "   try
  "     if s:is_ignore_status()
  "       let mark = ''  " edit here for cool mark
  "       let branch = fugitive#head()
  "       return branch !=# '' ? mark.branch : ''
  "     endif
  "   catch
  "   endtry
  "   return ''
  " endfunction

  " function! CtrlPMark() abort
  "   if expand('%:t') =~? 'ControlP' && has_key(g:lightline, 'ctrlp_item')
  "     call lightline#link('iR'[g:lightline.ctrlp_regex])
  "     return lightline#concatenate([g:lightline.ctrlp_prev, g:lightline.ctrlp_item
  "           \ , g:lightline.ctrlp_next], 0)
  "   else
  "     return ''
  "   endif
  " endfunction

  " let g:ctrlp_status_func = {
  "       \ 'main': 'CtrlPStatusFunc_1',
  "       \ 'prog': 'CtrlPStatusFunc_2',
  "       \ }
  "
  " function! CtrlPStatusFunc_1(focus, byfname, regex, prev, item, next, marked) abort
  "   let g:lightline.ctrlp_regex = a:regex
  "   let g:lightline.ctrlp_prev = a:prev
  "   let g:lightline.ctrlp_item = a:item
  "   let g:lightline.ctrlp_next = a:next
  "   return lightline#statusline(0)
  " endfunction
  "
  " function! CtrlPStatusFunc_2(str) abort
  "   return lightline#statusline(0)
  " endfunction

  " function! AleError() abort
  "   return s:ale_string(0)
  " endfunction
  "
  " function! AleWarning() abort
  "   return s:ale_string(1)
  " endfunction
  "
  " function! AleOk() abort
  "   return s:ale_string(2)
  " endfunction
  "
  " function! s:ale_string(mode) abort
  "   if !exists('g:ale_buffer_info')
  "     return ''
  "   endif
  "
  "   let g:ale_statusline_format = ['Err' .' %d', 'Warn' . ' %d', 'OK' . '  ']
  "
  "   let l:buffer = bufnr('%')
  "   let [l:error_count, l:warning_count] = ale#statusline#Count(l:buffer)
  "   let [l:error_format, l:warning_format, l:no_errors] = g:ale_statusline_format
  "
  "   if a:mode == 0 " Error
  "     return l:error_count ? printf(l:error_format, l:error_count) : ''
  "   elseif a:mode == 1 " Warning
  "     return l:warning_count ? printf(l:warning_format, l:warning_count) : ''
  "   endif
  "
  "   return l:error_count == 0 && l:warning_count == 0 ? l:no_errors : ''
  " endfunction
  "
  " augroup vimrc_lightline_on_ale
  "   autocmd!
  "   autocmd User ALELint call lightline#update()
  " augroup END

" }}}

