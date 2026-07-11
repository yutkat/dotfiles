local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
if not vim.uv.fs_stat(lazypath) then
	vim.system({
		"git",
		"clone",
		"--filter=blob:none",
		"--single-branch",
		"https://github.com/folke/lazy.nvim.git",
		lazypath,
	}, { text = true }):wait()
end
vim.opt.runtimepath:prepend(lazypath)

----------------------------------------------------------------
---- Load local plugins
local function load_local_plugins()
	if vim.uv.fs_stat(vim.fs.normalize("~/.nvim_pluginlist_local.lua")) then
		return dofile(vim.fs.normalize("~/.nvim_pluginlist_local.lua"))
	end
end
local local_plugins = load_local_plugins() or {}

local plugins = {
	-- ------------------------------------------------------------
	-- Installer
	{ "folke/lazy.nvim" },

	-- External package Installer
	{
		"mason-org/mason.nvim",
		event = { "VeryLazy" },
		build = ":MasonUpdate",
		config = function()
			require("rc/pluginconfig/mason")
		end,
	},

	-- ------------------------------------------------------------
	-- Library

	--------------------------------
	-- Lua Library
	{ "nvim-lua/plenary.nvim" },
	-- no consumers after neoclip / telescope-smart-history removal
	-- { "kkharji/sqlite.lua" },
	{ "MunifTanjim/nui.nvim" },

	--------------------------------
	-- UI Library
	{
		"folke/snacks.nvim",
		priority = 1000,
		lazy = false,
		config = function()
			require("rc/pluginconfig/snacks")
		end,
	},

	--------------------------------
	-- Notify
	-- "folke/snacks.nvim" notify

	--------------------------------
	-- ColorScheme
	{
		"EdenEast/nightfox.nvim",
		event = { "BufReadPre", "BufWinEnter", "BufEnter" },
		config = function()
			require("rc/pluginconfig/nightfox")
		end,
	},

	--------------------------------
	-- Font
	{
		"nvim-mini/mini.icons",
		version = "*",
		lazy = false, -- other plugins require it at startup
		enabled = function()
			return not os.getenv("DISABLE_DEVICONS") or os.getenv("DISABLE_DEVICONS") == "false"
		end,
		config = function()
			require("rc/pluginconfig/mini-icons")
		end,
	},
	{
		"delphinus/cellwidths.nvim",
		event = "VeryLazy",
		config = function()
			require("cellwidths").setup(
				---@diagnostic disable-next-line: missing-fields
				{ name = "cica" }
			)
		end,
	},

	--------------------------------------------------------------
	-- LSP & completion

	--------------------------------
	-- Auto Completion
	{
		"saghen/blink.cmp",
		version = "1.*",
		event = "VeryLazy",
		config = function()
			require("rc/pluginconfig/blink-cmp")
		end,
		dependencies = {
			"fang2hou/blink-copilot",
			"mikavilpas/blink-ripgrep.nvim",
		},
	},

	--------------------------------
	-- Language Server Protocol(LSP)
	{
		"neovim/nvim-lspconfig",
		event = "VimEnter",
		config = function()
			require("rc/pluginconfig/nvim-lspconfig")
		end,
	},
	{
		"mason-org/mason-lspconfig.nvim",
		event = "VimEnter",
		config = function()
			require("rc/pluginconfig/mason-lspconfig")
		end,
		dependencies = {
			{
				"folke/neoconf.nvim",
				config = function()
					require("rc/pluginconfig/neoconf")
				end,
			},
		},
	},

	--------------------------------
	-- LSP's UI
	{
		"folke/trouble.nvim",
		event = "VeryLazy",
		config = function()
			require("rc/pluginconfig/trouble")
		end,
	},

	--------------------------------
	-- AI completion
	{
		"zbirenbaum/copilot.lua",
		-- cmd = { "Copilot" },
		event = "InsertEnter",
		config = function()
			vim.defer_fn(function()
				require("rc/pluginconfig/copilot")
			end, 100)
		end,
	},
	{
		"folke/sidekick.nvim",
		event = "VeryLazy",
		config = function()
			require("rc/pluginconfig/sidekick")
		end,
	},

	--------------------------------------------------------------
	-- FuzzyFinders

	--------------------------------
	-- telescope.nvim -> folke/snacks.nvim picker (rc/pluginconfig/snacks-picker.lua)

	--------------------------------
	-- Treesitter
	{
		"romus204/tree-sitter-manager.nvim",
		cmd = { "TSManager", "TSUpgrade" },
		config = function()
			require("rc/pluginconfig/tree-sitter-manager")
		end,
	},

	--------------------------------
	-- Treesitter textobject & operator
	-- {
	-- 	"chrisgrieser/nvim-various-textobjs",
	-- 	event = "VeryLazy",
	-- 	config = function()
	-- 		require("rc/pluginconfig/nvim-various-textobjs")
	-- 	end,
	-- },
	-- incremental-selection
	-- { "RRethy/nvim-treesitter-textsubjects", after = { "nvim-treesitter" } },

	--------------------------------
	-- Treesitter UI customize
	{
		"m-demare/hlargs.nvim",
		event = "VeryLazy",
		config = function()
			require("rc/pluginconfig/hlargs")
		end,
	},

	--------------------------------------------------------------
	-- Appearance

	--------------------------------
	-- Statusline
	{
		"nvim-lualine/lualine.nvim",
		event = "VimEnter",
		config = function()
			require("rc/pluginconfig/lualine")
		end,
	},

	--------------------------------
	-- Bufferline
	{
		"akinsho/bufferline.nvim",
		event = "VimEnter",
		enabled = function()
			return not vim.g.vscode
		end,
		config = function()
			require("rc/pluginconfig/bufferline")
		end,
	},

	----------------------------------
	---- Syntax

	--------------------------------
	-- Highlight
	{
		"brenoprata10/nvim-highlight-colors",
		event = "VeryLazy",
		config = true,
	},
	-- -> nvim-mini/mini.hipatterns (interactive word marking wrapper)
	-- {
	-- 	"Mr-LLLLL/interestingwords.nvim",
	-- 	event = "VeryLazy",
	-- 	config = function()
	-- 		require("rc/pluginconfig/interestingwords")
	-- 	end,
	-- },
	{
		"nvim-mini/mini.hipatterns",
		version = "*",
		event = "VeryLazy",
		config = function()
			require("rc/pluginconfig/mini-hipatterns")
		end,
	},
	{
		"folke/todo-comments.nvim",
		event = "VeryLazy",
		config = function()
			require("rc/pluginconfig/todo-comments")
		end,
	},

	--------------------------------
	-- Filetype detection
	-- use do_filetype_lua
	-- use {'nathom/filetype.nvim', init = function() vim.g.did_load_filetypes = 1 end}

	--------------------------------
	-- Layout
	{
		"folke/edgy.nvim",
		event = "VeryLazy",
		config = function()
			require("rc/pluginconfig/edgy")
		end,
	},

	--------------------------------
	-- Sidebar

	--------------------------------
	-- Window Separators
	{
		"nvim-zh/colorful-winsep.nvim",
		event = "VeryLazy",
		config = function()
			require("rc/pluginconfig/colorful-winsep")
		end,
	},

	--------------------------------
	-- Menu

	--------------------------------
	-- Startup screen
	-- folke/snacks.nvim dashboard

	--------------------------------
	-- Scrollbar
	{
		"lewis6991/satellite.nvim",
		event = "VimEnter",
		config = function()
			require("rc/pluginconfig/satellite")
		end,
	},

	--------------------------------
	-- Cursor

	--------------------------------
	-- Sign
	-- buggy
	-- use {'dsummersl/nvim-sluice'}

	--------------------------------
	-- Minimap

	-- ------------------------------------------------------------
	-- Editing

	-- ------------------------------
	--  Key Bind (Map)

	--------------------------------
	-- Move
	{
		"folke/flash.nvim",
		event = "VeryLazy",
		config = function()
			require("rc/pluginconfig/flash")
		end,
	},

	----------------
	-- Horizontal Move
	{
		"jinh0/eyeliner.nvim",
		event = "VeryLazy",
		config = true,
	},
	{
		"chrisgrieser/nvim-spider",
		event = "VeryLazy",
		config = function()
			require("rc/pluginconfig/nvim-spider")
		end,
	},
	-- use {'gukz/ftFt.nvim', event = "VimEnter", config = function() require 'rc/pluginconfig/ftFt' end}
	-- still wasn't great.

	----------------
	-- Vertical Move
	-- Not moving as expected
	-- { "drybalka/tree-climber.nvim", event = "VimEnter" },

	----------------
	-- Word Move
	{
		"yutkat/wb-only-current-line.nvim",
		event = "VeryLazy",
	},

	--------------------------------
	-- Jump
	{
		"cbochs/portal.nvim",
		event = "VeryLazy",
		config = function()
			require("rc/pluginconfig/portal")
		end,
	},
	{
		"kwkarlwang/bufjump.nvim",
		event = "VeryLazy",
		config = function()
			require("rc/pluginconfig/bufjump")
		end,
	},

	--------------------------------
	-- Scroll

	--------------------------------
	-- Select

	--------------------------------
	-- Edit/Insert
	{
		"nvim-mini/mini.align",
		event = "VeryLazy",
		config = true,
	},
	{
		"yutkat/delete-word-to-chars.nvim",
		event = "VeryLazy",
		config = true,
	},

	--------------------------------
	-- Text Object
	{
		"nvim-mini/mini.ai",
		version = "*",
		event = "VeryLazy",
		config = function()
			require("rc/pluginconfig/mini-ai")
		end,
	},

	--------------------------------
	-- Operator
	{
		"nvim-mini/mini.operators",
		version = "*",
		event = "VeryLazy",
		config = function()
			require("rc/pluginconfig/mini-operators")
		end,
	},
	{
		"nvim-mini/mini.surround",
		version = "*",
		event = "VeryLazy",
		config = function()
			require("rc/pluginconfig/mini-surround")
		end,
	},

	-----------------
	-- Join
	{
		"nvim-mini/mini.splitjoin",
		version = "*",
		event = "VeryLazy",
		config = function()
			require("rc/pluginconfig/mini-splitjoin")
		end,
	},

	-----------------
	-- Adding and subtracting
	{
		"monaqa/dial.nvim",
		event = "VeryLazy",
		config = function()
			require("rc/pluginconfig/dial")
		end,
	},

	--------------------------------
	-- Yank
	{
		"hrsh7th/nvim-pasta",
		event = "VeryLazy",
		config = function()
			require("rc/pluginconfig/nvim-pasta")
		end,
	},
	-- {
	-- 	"AckslD/nvim-neoclip.lua",
	-- 	event = "VeryLazy",
	-- 	config = function()
	-- 		require("rc/pluginconfig/nvim-neoclip")
	-- 	end,
	-- },
	{
		"yutkat/save-clipboard-on-exit.nvim",
		event = "VeryLazy",
	},

	--------------------------------
	-- Paste

	--------------------------------------------------------------
	-- Search

	--------------------------------
	-- Find
	{
		"rapan931/lasterisk.nvim",
		event = "VeryLazy",
		config = function()
			require("rc/pluginconfig/lasterisk")
		end,
	},

	--------------------------------
	-- Replace

	--------------------------------
	-- Grep tool
	{
		"MagicDuck/grug-far.nvim",
		event = "VeryLazy",
		opts = true,
	},

	--------------------------------------------------------------
	-- File switcher

	--------------------------------
	-- Open
	{
		"hrsh7th/nvim-gtd",
		event = "VeryLazy",
		config = function()
			require("rc/pluginconfig/nvim-gtd")
		end,
	},

	--------------------------------
	-- Buffer
	-- folke/snacks.nvim bufdelete

	--------------------------------
	-- Buffer switcher
	{
		"yutkat/switch-buffer-improve.nvim",
		event = "VeryLazy",
		config = true,
	},
	{
		"stevearc/stickybuf.nvim",
		event = "VeryLazy",
		config = function()
			require("rc/pluginconfig/stickybuf")
		end,
	},

	--------------------------------
	-- Tab

	--------------------------------
	-- Filer
	-- folke/snacks.nvim explorer

	--------------------------------
	-- Window
	{
		"s1n7ax/nvim-window-picker",
		event = "VeryLazy",
		config = function()
			require("rc/pluginconfig/nvim-window-picker")
		end,
	},

	------------------------------------------------------------
	-- Standard Feature Enhancement

	--------------------------------
	-- Undo

	--------------------------------
	-- Diff

	--------------------------------
	-- Mark
	{
		"chentoast/marks.nvim",
		event = "VeryLazy",
		config = function()
			require("rc/pluginconfig/marks")
		end,
	},

	--------------------------------
	-- Fold

	--------------------------------
	-- Manual
	-- {
	-- 	"lalitmee/browse.nvim",
	-- 	event = "VeryLazy",
	-- 	config = function()
	-- 		require("rc/pluginconfig/browse")
	-- 	end,
	-- },
	{
		"folke/which-key.nvim",
		event = "VeryLazy",
		config = function()
			require("rc/pluginconfig/which-key")
		end,
	},

	--------------------------------
	-- Help

	--------------------------------
	-- Tag

	--------------------------------
	-- Quickfix
	{
		"kevinhwang91/nvim-bqf",
		event = "VeryLazy",
		config = function()
			require("rc/pluginconfig/nvim-bqf")
		end,
	},
	-- {
	-- 	"stevearc/quicker.nvim",
	-- 	event = "VeryLazy",
	-- 	config = function()
	-- 		require("rc/pluginconfig/quicker")
	-- 	end,
	-- },

	--------------------------------
	-- Session
	-- do not use the session per current directory
	{
		"jedrzejboczar/possession.nvim",
		-- lazy = false,
		event = "BufEnter",
		config = function()
			require("rc/pluginconfig/possession")
		end,
	},

	--------------------------------
	-- Macro
	-- {
	-- 	"tani/dmacro.nvim",
	-- 	event = "VeryLazy",
	-- 	config = function()
	-- 		require("rc/pluginconfig/dmacro")
	-- 	end,
	-- },

	--------------------------------
	-- SpellCheck
	-- -> null-ls(cspell)

	--------------------------------
	-- SpellCorrect (iabbr)

	--------------------------------
	-- Command
	-- {
	-- 	"sbulav/nredir.nvim",
	-- 	cmd = { "Nredir" },
	-- },
	-- {
	-- 	"sQVe/sort.nvim",
	-- 	cmd = { "Sort" },
	-- },
	{
		"yutkat/confirm-quit.nvim",
		event = "CmdlineEnter",
		config = function()
			require("confirm-quit").setup()
			vim.cmd("unabbreviate qa")
		end,
	},
	-- {
	-- 	"smjonas/live-command.nvim",
	-- 	event = "CmdlineEnter",
	-- 	config = function()
	-- 		require("rc/pluginconfig/live-command")
	-- 	end,
	-- },

	--------------------------------
	-- Commandline
	{
		"folke/noice.nvim",
		event = "VimEnter",
		config = function()
			require("rc/pluginconfig/noice")
		end,
	},

	--------------------------------
	-- History
	{
		"yutkat/history-ignore.nvim",
		event = "CmdlineEnter",
		config = true,
	},

	--------------------------------
	-- Terminal
	-- folke/snacks.nvim terminal
	{
		"yutkat/term-gf.nvim",
		event = "VeryLazy",
		config = true,
	},

	--------------------------------
	-- Backup/Swap

	--------------------------------------------------------------
	-- New features

	--------------------------------
	-- Translate
	{
		"uga-rosa/translate.nvim",
		event = "VeryLazy",
		config = function()
			require("rc/pluginconfig/translate")
		end,
	},

	--------------------------------
	-- Popup Info
	-- -> built-in vim.lsp.buf.hover() (only LSP provider was used; mapped to Q in mappings.lua)
	-- {
	-- 	"lewis6991/hover.nvim",
	-- 	event = "VeryLazy",
	-- 	config = function()
	-- 		require("rc/pluginconfig/hover")
	-- 	end,
	-- },

	--------------------------------
	-- Screenshot

	--------------------------------
	-- Command Palette

	--------------------------------
	-- Memo
	{
		"obsidian-nvim/obsidian.nvim",
		version = "*",
		ft = "markdown",
		cmd = { "Obsidian" },
		config = function()
			require("rc/pluginconfig/obsidian")
		end,
	},

	--------------------------------
	-- Scratch
	-- -> memo plugin

	--------------------------------
	-- Hex
	-- -> https://github.com/WerWolv/ImHex
	{
		"yutkat/hexedit.nvim",
		cmd = {
			"HexEditSplit16BytePerLine",
			"HexEditAdd0x",
			"HexEditAddCommaEachWord",
			"HexEditConvertHexForProg",
		},
		config = true,
	},
	-- { "Shougo/vinarise.vim", cmd = { "Vinarise" } },

	--------------------------------
	-- Browser integration
	-- -> lalitmee/browse.nvim

	--------------------------------
	-- Mode extension
	{
		"mawkler/modicator.nvim",
		event = "VeryLazy",
		config = function()
			require("rc/pluginconfig/modicator")
		end,
	},
	-- WARNING vim.validate is deprecated. Feature will be removed in Nvim 1.0
	-- {
	-- 	"nvimtools/hydra.nvim",
	-- 	event = "VimEnter",
	-- 	config = function()
	-- 		require("rc/pluginconfig/hydra")
	-- 	end,
	-- 	dependencies = {
	-- 		{ "lewis6991/gitsigns.nvim" },
	-- 	},
	-- },

	--------------------------------
	-- Template
	{
		"nvimdev/template.nvim",
		cmd = { "Template", "TemProject" },
		config = function()
			require("rc/pluginconfig/template")
		end,
	},

	--------------------------------
	-- Performance Improvement

	--------------------------------
	-- OpenAI

	--------------------------------
	-- Analytics
	-- @Vim script
	{
		"wakatime/vim-wakatime",
		event = "VeryLazy",
		enabled = function()
			return vim.env.DISABLE_WAKATIME ~= "true" and vim.uv.fs_stat(vim.fs.normalize("~/.wakatime.cfg")) ~= nil
		end,
		opts = { status_bar_enabled = false },
	},

	--------------------------------
	-- LiveShare
	-- {'jbyuki/instant.nvim'}

	--------------------------------
	-- Patch
	-- https://github.com/neovim/neovim/issues/12587
	-- Cursor position shifted when indentation is lost
	-- {'antoinemadec/FixCursorHold.nvim'}

	--------------------------------
	-- etc
	-- {'sunjon/extmark-toy.nvim'}

	--------------------------------------------------------------
	-- Coding

	--------------------------------
	-- Writing assistant
	{
		"NMAC427/guess-indent.nvim",
		-- event = { "BufReadPre", "BufWinEnter", "BufEnter", "VimEnter" },
		lazy = false,
		opts = { filetype_exclude = { "markdown" } },
	},

	--------------------------------
	-- Reading assistant
	-- folke/snacks.nvim indent

	--------------------------------
	-- Comment out
	-- -> built-in gc/gcc/gb/gbc (0.10+); <C-_>/<C-/> mapped in mappings.lua
	-- {
	-- 	"numToStr/Comment.nvim",
	-- 	event = "VeryLazy",
	-- 	config = function()
	-- 		require("rc/pluginconfig/Comment")
	-- 	end,
	-- },

	--------------------------------
	-- Annotation
	{
		"danymat/neogen",
		event = "VeryLazy",
		config = function()
			require("rc/pluginconfig/neogen")
		end,
	},

	--------------------------------
	-- Brackets
	{
		"monkoose/matchparen.nvim",
		event = "VimEnter",
		config = function()
			require("rc/pluginconfig/matchparen")
		end,
	},
	{
		"saghen/blink.pairs",
		version = "*",
		dependencies = "saghen/blink.lib",
		build = function()
			local blink_pairs = require("blink.pairs")
			blink_pairs.download()
			if not vim.wait(60000, blink_pairs.library_available, 100) then
				error("Timed out downloading the blink.pairs native library")
			end
		end,
		event = "VimEnter",
		config = function()
			require("rc/pluginconfig/blink-pairs")
		end,
	},

	--------------------------------
	-- Endwise

	--------------------------------
	-- Code jump
	{
		"rgroli/other.nvim",
		event = "VeryLazy",
		config = function()
			require("rc/pluginconfig/other")
		end,
	},

	--------------------------------
	-- Test
	{
		"nvim-neotest/neotest",
		event = "VeryLazy",
		opt = true,
	},

	--------------------------------
	-- Task runner
	{
		"stevearc/overseer.nvim",
		event = "VeryLazy",
		config = function()
			require("rc/pluginconfig/overseer")
		end,
	},

	--------------------------------
	-- Lint
	{
		"mfussenegger/nvim-lint",
		event = "VeryLazy",
		config = function()
			require("rc/pluginconfig/nvim-lint")
		end,
	},

	--------------------------------
	-- Format
	{
		"stevearc/conform.nvim",
		event = "VeryLazy",
		config = function()
			require("rc/pluginconfig/conform")
		end,
	},

	--------------------------------
	-- Code outline
	-- -> lspsaga

	--------------------------------
	-- Call Hierarchy

	----------------------------------
	---- Snippet
	{
		"L3MON4D3/LuaSnip",
		event = "VimEnter",
		build = "make install_jsregexp",
		config = function()
			require("rc/pluginconfig/LuaSnip")
		end,
	},

	--------------------------------
	-- Snippet Pack
	{ "rafamadriz/friendly-snippets" },

	--------------------------------
	-- Project
	{
		"notjedi/nvim-rooter.lua",
		event = "BufAdd",
		opts = true,
	},
	-- :trust
	-- {
	-- 	"klen/nvim-config-local",
	-- 	-- lazy = false,
	-- 	event = "BufEnter",
	-- 	config = function()
	-- 		require("rc/pluginconfig/nvim-config-local")
	-- 	end,
	-- },

	--------------------------------
	-- Git
	{
		"NeogitOrg/neogit",
		event = "VeryLazy",
		config = function()
			require("rc/pluginconfig/neogit")
		end,
	},
	-- WARNING vim.highlight is deprecated. Feature will be removed in Nvim 2.0.0
	-- {
	-- 	"akinsho/git-conflict.nvim",
	-- 	event = "VeryLazy",
	-- 	config = true,
	-- },
	{ "yutkat/convert-git-url.nvim", cmd = { "ConvertGitUrl" } },
	{
		"lewis6991/gitsigns.nvim",
		event = "VimEnter",
		config = function()
			require("rc/pluginconfig/gitsigns")
		end,
	},
	{
		"sindrets/diffview.nvim",
		event = "VeryLazy",
		config = function()
			require("rc/pluginconfig/diffview")
		end,
	},

	--------------------------------
	-- Git command assistant
	-- { "hotwatermorning/auto-git-diff", ft = { "gitrebase" } },
	{
		"yutkat/git-rebase-auto-diff.nvim",
		ft = { "gitrebase" },
		opts = {
			size = vim.fn.float2nr(vim.o.lines * 0.5),
			run_show = true,
		},
	},

	--------------------------------
	-- GitHub
	{
		"pwntester/octo.nvim",
		cmd = { "Octo" },
		config = function()
			require("rc/pluginconfig/octo")
		end,
	},

	--------------------------------
	-- Debugger
	{
		"mfussenegger/nvim-dap",
		keys = { { "s", desc = "Debugger prefix" } }, -- lazy-load on the [_Debugger] prefix
		config = function()
			require("rc/pluginconfig/nvim-dap")
		end,
		dependencies = {
			{
				"rcarriga/nvim-dap-ui",
				config = function()
					require("rc/pluginconfig/nvim-dap-ui")
				end,
			},
			{ "nvim-neotest/nvim-nio" },
			{ "theHamsta/nvim-dap-virtual-text" },
			{ "jbyuki/one-small-step-for-vimkind" },
		},
	},
	{
		"Goose97/timber.nvim",
		event = "VeryLazy",
		config = function()
			require("rc/pluginconfig/timber")
		end,
	},

	--------------------------------
	-- REPL
	{
		"Vigemus/iron.nvim",
		event = "VeryLazy",
		config = function()
			require("rc/pluginconfig/iron")
		end,
	},
	-- {
	-- 	"michaelb/sniprun",
	-- 	enabled = function()
	-- 		return vim.fn.executable("cargo")
	-- 	end,
	-- 	build = "bash install.sh",
	-- 	cmd = { "SnipRun" },
	-- },
	-- {
	-- 	"rafcamlet/nvim-luapad",
	-- 	cmd = { "Luapad" },
	-- 	config = true,
	-- },

	--------------------------------------------------------------
	-- Programming Languages

	--------------------------------
	-- JavaScript
	{
		"vuki656/package-info.nvim",
		event = "BufRead",
		config = function()
			require("rc/pluginconfig/package-info")
		end,
	},

	--------------------------------
	-- Python

	--------------------------------
	-- Rust
	{
		"mrcjkb/rustaceanvim",
		-- after = { "nvim-lspconfig" },
		-- ft = { "rust" },
		-- config = function()
		-- 	require("rc/pluginconfig/rust-tools")
		-- end,
	},

	--------------------------------
	-- Markdown
	-- {
	-- 	"toppair/peek.nvim",
	-- 	build = "deno task --quiet build:fast",
	-- 	ft = { "markdown" },
	-- 	enabled = function()
	-- 		return vim.fn.executable("deno")
	-- 	end,
	-- 	config = function()
	-- 		require("rc/pluginconfig/peek")
	-- 	end,
	-- },

	--------------------------------
	-- SQL

	--------------------------------
	-- CSV
	-- {
	-- 	"Decodetalkers/csv-tools.lua",
	-- 	ft = { "csv" },
	-- 	config = function()
	-- 		require("rc/pluginconfig/csv-tools")
	-- 	end,
	-- },

	--------------------------------
	-- Log
	-- -> treesitter

	--------------------------------
	-- Json

	--------------------------------
	-- Neovim Lua development
	{
		"folke/lazydev.nvim",
		ft = "lua", -- only load on lua files
		opts = {
			library = {
				-- See the configuration section for more details
				-- Load luvit types when the `vim.uv` word is found
				{ path = "luvit-meta/library", words = { "vim%.uv" } },
			},
		},
	},
	{
		"Bilal2453/luvit-meta",
	}, -- optional `vim.uv` typings
	-- folke/neodev.nvim
	-- { "wadackel/nvim-syntax-info", cmd = { "SyntaxInfo" } },
}

local function merge_lists(t1, t2)
	local result = {}
	for _, v in pairs(t1) do
		table.insert(result, v)
	end
	for _, v in pairs(t2) do
		table.insert(result, v)
	end
	return result
end

require("lazy").setup(merge_lists(plugins, local_plugins), {
	defaults = {
		lazy = true, -- should plugins be lazy-loaded?
	},
	dev = {
		path = vim.fn.stdpath("data") .. "/dev",
	},
})
