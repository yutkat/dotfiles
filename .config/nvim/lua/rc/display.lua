-- nvim color
vim.env.NVIM_TUI_ENABLE_TRUE_COLOR = 1

vim.o.synmaxcol = 200
-- ColorScheme
vim.cmd([[ syntax enable ]]) -- シンタックスカラーリングオン
vim.o.t_Co = 256
vim.o.background = "dark"

-- true color support
vim.g.colorterm = os.getenv("COLORTERM")
if vim.fn.exists("+termguicolors") then
	-- vim.o.t_8f = "<Esc>[38;2;%lu;%lu;%lum"
	-- vim.o.t_8b = "<Esc>[48;2;%lu;%lu;%lum"
	vim.o.termguicolors = true
end

-- colorscheme pluginconfig -> colorscheme
vim.o.cursorline = false

vim.o.display = "lastline" -- 長い行も一行で収まるように
vim.o.showmode = false
vim.o.showmatch = true -- 括弧の対応をハイライト
vim.o.matchtime = 1 -- 括弧の対を見つけるミリ秒数
vim.o.showcmd = true -- 入力中のコマンドを表示
vim.o.number = true -- 行番号表示
vim.o.relativenumber = true
vim.o.wrap = true -- 画面幅で折り返す
vim.o.title = false -- タイトル書き換えない
vim.o.scrolloff = 5
vim.o.sidescrolloff = 5
vim.o.pumheight = 10 -- 補完候補の表示数

-- 折りたたみ設定
-- vim.o.foldmethod="marker"
vim.o.foldmethod = "manual"
vim.o.foldlevel = 1
vim.o.foldlevelstart = 99
vim.w.foldcolumn = "0:"

-- Cursor style
vim.o.guicursor = "n-v-c-sm:block-Cursor/lCursor-blinkon0,i-ci-ve:ver25-Cursor/lCursor,r-cr-o:hor20-Cursor/lCursor"

vim.o.cursorlineopt = "number"

-- ステータスライン関連
-- vim.o.laststatus = 2
vim.o.laststatus = 3
vim.o.shortmess = "aItToOF"
vim.opt.fillchars = {
	horiz = "━",
	horizup = "┻",
	horizdown = "┳",
	vert = "┃",
	vertleft = "┫",
	vertright = "┣",
	verthoriz = "╋",
}
-- vim.o.cmdheight=2

-- use plugin

-- "vim.o.statusline=%t\ %m%r%h%w[%Y][%{&fenc}][%{&ff}]<%F>%=%c,%l%11p%%
-- "vim.o.statusline=%<[%n]%m%r%h%w%{'['.(&fenc!=''?&fenc:&enc).':'.&ff.']'}%y\ %F%=%l,%c%V%8P
-- " ステータスラインの表示
--  vim.o.statusline=%<     " 行が長すぎるときに切り詰める位置
--  vim.o.statusline+=[%n]  " バッファ番号
--  vim.o.statusline+=%m    " %m 修正フラグ
--  vim.o.statusline+=%r    " %r 読み込み専用フラグ
--
--  vim.o.statusline+=%h    " %h ヘルプバッファフラグ
--  vim.o.statusline+=%w    " %w プレビューウィンドウフラグ
--  vim.o.statusline+=%{'['.(&fenc!=''?&fenc:&enc).':'.&ff.']'}  " fencとffを表示
--  vim.o.statusline+=%y    " バッファ内のファイルのタイプ
--  vim.o.statusline+=\     " 空白スペース
-- if winwidth(0) >= 130
--  vim.o.statusline+=%F    " バッファ内のファイルのフルパス
-- else
--  vim.o.statusline+=%t    " ファイル名のみ
-- endif
--  vim.o.statusline+=%=    " 左寄せ項目と右寄せ項目の区切り
--  vim.o.statusline+=%{exists('g:loaded_fugitive')?fugitive#statusline():''} " Gitブランチ名を表示
--  vim.o.statusline+=\ \   " 空白スペース2個
--  vim.o.statusline+=%1l   " 何行目にカーソルがあるか
--  vim.o.statusline+=/
--  vim.o.statusline+=%L    " バッファ内の総行数
--  vim.o.statusline+=,
--  vim.o.statusline+=%c    " 何列目にカーソルがあるか
--  vim.o.statusline+=%V    " 画面上の何列目にカーソルがあるか
--  vim.o.statusline+=\ \   " 空白スペース2個
--  vim.o.statusline+=%P    " ファイル内の何％の位置にあるか
--
-- jamessan's
-- vim.o.statusline=   " clear the statusline for when vimrc is reloaded
-- vim.o.statusline+=%-3.3n\                      " buffer number
-- vim.o.statusline+=%f\                          " file name
-- vim.o.statusline+=%h%m%r%w                     " flags
-- vim.o.statusline+=[%{strlen(&ft)?&ft:'none'},  " filetype
-- vim.o.statusline+=%{strlen(&fenc)?&fenc:&enc}, " encoding
-- vim.o.statusline+=%{&fileformat}]              " file format
-- vim.o.statusline+=%=                           " right align
-- vim.o.statusline+=%{synIDattr(synID(line('.'),col('.'),1),'name')}\  " highlight
-- vim.o.statusline+=%b,0x%-8B\                   " current char
-- vim.o.statusline+=%-14.(%l,%c%V%)\ %<%P        " offset
