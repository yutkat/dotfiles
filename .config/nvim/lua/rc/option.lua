vim.g.mapleader = " "
vim.g.maplocalleader = "\\"

vim.o.shada = "'50,<1000,s100,\"1000,!" -- YankRing用に!を追加
vim.o.shadafile = vim.fn.stdpath("data") .. "/shada/main.shada"
vim.fn.mkdir(vim.fn.fnamemodify(vim.fn.expand(vim.g.viminfofile), ":h"), "p")
vim.o.shellslash = true -- Windowsでディレクトリパスの区切り文字に / を使えるようにする
-- vim.o.lazyredraw   vim-anzuの検索結果が見えなくなることがあるためOFF
vim.o.complete = vim.o.complete .. ",k" -- 補完に辞書ファイル追加
vim.o.completeopt = "menuone,noselect,noinsert"
vim.o.history = 10000
vim.o.timeout = true
vim.o.timeoutlen = 500
vim.o.ttimeoutlen = 10
vim.o.updatetime = 2000

-- タブ周り
-- tabstopはTab文字を画面上で何文字分に展開するか
-- shiftwidthはcindentやautoindent時に挿入されるインデントの幅
-- softtabstopはTabキー押し下げ時の挿入される空白の量，0の場合はtabstopと同じ，BSにも影響する
vim.o.tabstop = 2
vim.o.shiftwidth = 2
vim.o.softtabstop = 0
vim.o.expandtab = true -- タブを空白文字に展開
-- vim.o.autoindent smartindent  -- 自動インデント，スマートインデント
vim.o.list = true
vim.o.listchars = "tab:»-"

-- 入力補助
vim.o.backspace = "indent,eol,start" -- バックスペースでなんでも消せるように
vim.o.formatoptions = vim.o.formatoptions .. "m" -- 整形オプション，マルチバイト系を追加
-- https://github.com/vim-jp/issues/issues/152 use nofixeol
-- vim.o.binary noeol=true
vim.o.fixendofline = false
-- vim.o.formatoptions=vim.o.formatoptions .. "j" -- Delete comment character when joining commented lines

-- 単語区切り設定 setting by vim-polyglot
-- vim.o.iskeyword="48-57,192-255"

-- コマンド補完
vim.o.wildmenu = true -- コマンド補完を強化
vim.o.wildmode = "longest,list,full" -- リスト表示，最長マッチ

-- 検索関連
vim.o.wrapscan = true -- 最後まで検索したら先頭へ戻る
-- vim.o.nowrapscan -- 最後まで検索しても先頭に戻らない
vim.o.ignorecase = true -- 大文字小文字無視
vim.o.smartcase = true -- 大文字ではじめたら大文字小文字無視しない
vim.o.incsearch = true -- インクリメンタルサーチ
vim.o.hlsearch = true -- 検索文字をハイライト

-- ウィンドウ関連
vim.o.splitbelow = true
vim.o.splitright = true

-- ファイル関連
-- vim.o.backup=false   -- バックアップ取らない
vim.o.autoread = true -- 他で書き換えられたら自動で読み直す
vim.o.swapfile = false -- スワップファイル作らない
vim.o.hidden = true -- 編集中でも他のファイルを開けるようにする
vim.o.backup = true
vim.o.backupdir = vim.fn.stdpath("data") .. "/backup/"
vim.fn.mkdir(vim.o.backupdir, "p")
-- vim.o.backupext = string.gsub(vim.o.backupext, "[vimbackup]", "")
vim.o.backupskip = ""
vim.o.directory = vim.fn.stdpath("data") .. "/swap/"
vim.fn.mkdir(vim.o.directory, "p")
vim.o.updatecount = 100
vim.o.undofile = true
vim.o.undodir = vim.fn.stdpath("data") .. "/undo/"
vim.fn.mkdir(vim.o.undodir, "p")
vim.o.modeline = false

-- OSのクリップボードを使う
-- +レジスタ：Ubuntuの[Ctrl-v]で貼り付けられるもの unnamedplus
-- *レジスタ：マウス中クリックで貼り付けられるもの unnamed
vim.o.clipboard = "unnamedplus,unnamed," .. vim.o.clipboard

-- ビープ音除去
vim.o.errorbells = false
vim.o.visualbell = false

-- ファイルのディレクトリに移動
-- vim.o.autochdir = true

-- tags
vim.opt.tags:remove({ "./tags" })
vim.opt.tags:remove({ "./tags;" })
vim.opt.tags = "./tags," .. vim.go.tags

-- session
vim.o.sessionoptions = "buffers,curdir,tabpages,winsize"

-- quickfix
vim.o.switchbuf = "useopen,uselast"

-- smart indent for long line
-- vim.o.breakindent=true

vim.o.pumblend = 0
vim.o.wildoptions = vim.o.wildoptions .. ",pum"
vim.o.spelllang = "en,cjk"
vim.o.inccommand = "split"
vim.g.vimsyn_embed = "l"

-- diff
vim.o.diffopt = vim.o.diffopt .. ",vertical,internal,algorithm:patience,iwhite,indent-heuristic"
