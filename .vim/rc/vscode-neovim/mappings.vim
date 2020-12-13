" https://github.com/asvetliakov/vscode-neovim#normal-mode-control-keys
" available by default
" CTRL-a
" CTRL-b
" CTRL-c
" CTRL-d
" CTRL-e
" CTRL-f
" CTRL-i
" CTRL-o
" CTRL-r
" CTRL-u
" CTRL-v
" CTRL-w
" CTRL-x
" CTRL-y
" CTRL-]
" CTRL-j
" CTRL-k
" CTRL-l
" CTRL-h
" CTRL-/

nnoremap <silent> H <Cmd>Tabprevious<CR>
nnoremap <silent> L <Cmd>Tabnext<CR>
nnoremap <silent> <Leader>p <Cmd>call VSCodeNotify('workbench.action.quickOpen')<CR>
