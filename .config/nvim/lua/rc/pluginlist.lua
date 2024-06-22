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
		"williamboman/mason.nvim",
		event = { "VeryLazy" },
		build = ":MasonUpdate",
		config = function()
			require("rc/pluginconfig/mason")
		end,
	},

	-- ------------------------------------------------------------
	-- Library

	--------------------------------
	-- Vim script Library
	-- @Vim script
	-- {
	-- 	"tpope/vim-repeat",
	-- 	event = "VimEnter"
	-- },

	--------------------------------
	-- Lua Library
	{ "nvim-lua/popup.nvim" },
	{ "nvim-lua/plenary.nvim" },
	{ "kkharji/sqlite.lua" },
	{ "MunifTanjim/nui.nvim" },

	--------------------------------
	-- UI Library
	{
		"stevearc/dressing.nvim",
		event = "VeryLazy",
		config = function()
			require("rc/pluginconfig/dressing")
		end,
	},

	--------------------------------
	-- Notify
	{
		"rcarriga/nvim-notify",
		event = "VeryLazy",
		config = function()
			require("rc/pluginconfig/nvim-notify")
		end,
	},

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
		"kyazdani42/nvim-web-devicons",
		enabled = function()
			return not os.getenv("DISABLE_DEVICONS") or os.getenv("DISABLE_DEVICONS") == "false"
		end,
	},
	{
		"delphinus/cellwidths.nvim",
		event = "VeryLazy",
		config = function()
			require("cellwidths").setup({
				name = "cica",
			})
		end,
	},

	--------------------------------------------------------------
	-- LSP & completion

	--------------------------------
	-- Auto Completion
	{
		"hrsh7th/nvim-cmp",
		event = "VimEnter",
		config = function()
			require("rc/pluginconfig/nvim-cmp")
		end,
		dependencies = {
			{ "hrsh7th/cmp-nvim-lsp" },
			-- Duplicate popups. noice.nvim signature
			-- { "hrsh7th/cmp-nvim-lsp-signature-help" },
			{ "hrsh7th/cmp-nvim-lsp-document-symbol" },
			{ "hrsh7th/cmp-buffer" },
			{ "hrsh7th/cmp-path" },
			-- { "hrsh7th/cmp-omni" },
			{ "hrsh7th/cmp-nvim-lua" },
			-- { "hrsh7th/cmp-copilot" },
			{ "hrsh7th/cmp-emoji" },
			{ "hrsh7th/cmp-calc" },
			{ "f3fora/cmp-spell" },
			{ "yutkat/cmp-mocword" },
			{ "saadparwaiz1/cmp_luasnip" },
			{
				"tzachar/cmp-tabnine",
				build = "./install.sh",
			},
			{ "ray-x/cmp-treesitter" },
			{ "lukas-reineke/cmp-rg" },
			{ "lukas-reineke/cmp-under-comparator" },
			{
				"onsails/lspkind-nvim",
				config = function()
					require("rc/pluginconfig/lspkind-nvim")
				end,
			},
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
		"williamboman/mason-lspconfig.nvim",
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
			{ "weilbith/nvim-lsp-smag", after = "nvim-lspconfig" },
		},
	},

	--------------------------------
	-- LSP's UI
	{
		"nvimdev/lspsaga.nvim",
		event = "VeryLazy",
		config = function()
			require("rc/pluginconfig/lspsaga")
		end,
	},
	{
		"folke/trouble.nvim",
		event = "VeryLazy",
		config = function()
			require("rc/pluginconfig/trouble")
		end,
	},
	-- {
	-- 	"EthanJWright/toolwindow.nvim",
	-- 	dependencies = { { "akinsho/toggleterm.nvim", opt = true, event = "VimEnter" } },
	-- 	after = { "trouble.nvim", "toggleterm.nvim" },
	-- 	config = function()
	-- 		require("rc/pluginconfig/toolwindow")
	-- 	end,
	-- },
	{
		"j-hui/fidget.nvim",
		tag = "legacy",
		event = "BufEnter",
		config = function()
			require("rc/pluginconfig/fidget")
		end,
	},
	-- weilbith/nvim-code-action-menu
	-- RishabhRD/nvim-lsputils
	-- aspeddro/lsp_menu.nvim

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
		"CopilotC-Nvim/CopilotChat.nvim",
		branch = "canary",
		event = { "CmdlineEnter" },
		opts = {
			debug = false,
		},
	},
	-- {
	-- 	"jcdickinson/codeium.nvim",
	-- 	cmd = { "Codeium" },
	-- 	config = true,
	-- },

	--------------------------------------------------------------
	-- FuzzyFinders

	--------------------------------
	-- telescope.nvim
	{
		"nvim-telescope/telescope.nvim",
		event = { "VimEnter" },
		config = function()
			require("rc/pluginconfig/telescope")
		end,
		dependencies = {
			-- I don't know how to use it.
			-- {
			-- 	"prochri/telescope-all-recent.nvim",
			-- 	config = true,
			-- },
			{
				"nvim-telescope/telescope-github.nvim",
				config = function()
					require("telescope").load_extension("gh")
				end,
			},
			{
				"nvim-telescope/telescope-ui-select.nvim",
				config = function()
					require("telescope").load_extension("ui-select")
				end,
			},
			{
				"LinArcX/telescope-changes.nvim",
				config = function()
					require("telescope").load_extension("changes")
				end,
			},
			{
				"nvim-telescope/telescope-live-grep-args.nvim",
				config = function()
					require("telescope").load_extension("live_grep_args")
				end,
			},
			{
				"nvim-telescope/telescope-smart-history.nvim",
				config = function()
					require("telescope").load_extension("smart_history")
				end,
				build = function()
					os.execute("mkdir -p " .. vim.fn.stdpath("state") .. "databases/")
				end,
			},
			{ "nvim-telescope/telescope-symbols.nvim" },
			{
				"debugloop/telescope-undo.nvim",
				config = function()
					require("telescope").load_extension("undo")
				end,
			},
		},
	},
	{
		"nvim-telescope/telescope-frecency.nvim",
		event = "VeryLazy",
		config = function()
			require("telescope").load_extension("frecency")
		end,
	},
	-- not used
	-- {
	-- 	"nvim-telescope/telescope-media-files.nvim",
	-- 	event = "VeryLazy",
	-- 	enabled = function()
	-- 		return vim.fn.executable("ueberzug")
	-- 	end,
	-- 	config = function()
	-- 		require("telescope").load_extension("media_files")
	-- 	end,
	-- },
	{
		"crispgm/telescope-heading.nvim",
		event = "VeryLazy",
		config = function()
			require("telescope").load_extension("heading")
		end,
	},
	-- {
	-- 	"nvim-telescope/telescope-fzf-writer.nvim",
	-- 	after = { "telescope.nvim" },
	-- 	config = function()
	-- 		require("telescope").load_extension("fzf_writer")
	-- 	end,
	-- },
	-- I don't want to set items myself
	-- use { "LinArcX/telescope-command-palette.nvim", 	after = { "telescope.nvim" } }
	-- -> filer
	-- {
	-- 	"nvim-telescope/telescope-file-browser.nvim",
	-- 	after = { "telescope.nvim" },
	-- 	config = function()
	-- 		require("telescope").load_extension("file_browser")
	-- 	end,
	-- },
	-- use {"sunjon/telescope-arecibo.nvim",
	--   after = {'telescope.nvim'},
	--   rocks = {"openssl", "lua-http-parser"},
	--   config = function() require('telescope').load_extension('arecibo') end
	-- }
	-- {
	-- 	"LinArcX/telescope-command-palette.nvim",
	-- 	after = { "telescope.nvim" },
	-- 	config = function()
	-- 		require("telescope").load_extension("command_palette")
	-- 	end,
	-- },

	--------------------------------
	-- Treesitter
	{
		"nvim-treesitter/nvim-treesitter",
		event = { "VeryLazy" },
		build = ":TSUpdateSync",
		config = function()
			require("rc/pluginconfig/nvim-treesitter")
		end,
		dependencies = {
			{ "JoosepAlviste/nvim-ts-context-commentstring" },
			{ "nvim-treesitter/nvim-treesitter-refactor" },
			{ "nvim-treesitter/nvim-tree-docs" },
			{ "yioneko/nvim-yati" },
		},
	},

	--------------------------------
	-- Treesitter textobject & operator
	{ "nvim-treesitter/nvim-treesitter-textobjects", event = "VeryLazy" },
	{
		"chrisgrieser/nvim-various-textobjs",
		event = "VeryLazy",
		config = function()
			require("rc/pluginconfig/nvim-various-textobjs")
		end,
	},
	-- incremental-selection
	-- { "RRethy/nvim-treesitter-textsubjects", after = { "nvim-treesitter" } },
	{
		"mizlan/iswap.nvim",
		event = "VeryLazy",
		config = function()
			require("rc/pluginconfig/iswap")
		end,
	},
	{
		"mfussenegger/nvim-treehopper",
		event = "VeryLazy",
		config = function()
			require("rc/pluginconfig/nvim-treehopper")
		end,
	},
	{
		"David-Kunz/treesitter-unit",
		event = "VeryLazy",
		config = function()
			require("rc/pluginconfig/treesitter-unit")
		end,
	},

	--------------------------------
	-- Treesitter UI customize
	{
		"HiPhish/rainbow-delimiters.nvim",
		event = "VeryLazy",
		config = function()
			-- patch https://github.com/nvim-treesitter/nvim-treesitter/issues/1124
			if vim.fn.expand('%:p') ~= "" then
				vim.cmd.edit({ bang = true })
			end
		end,
	},
	{
		"haringsrob/nvim_context_vt",
		event = "VeryLazy",
		config = function()
			require("rc/pluginconfig/nvim_context_vt")
		end,
	},
	{
		"m-demare/hlargs.nvim",
		event = "VeryLazy",
		config = function()
			require("rc/pluginconfig/hlargs")
		end,
	},
	{
		"romgrk/nvim-treesitter-context",
		cmd = { "TSContextEnable" },
		config = true,
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
		"xiyaowong/nvim-cursorword",
		event = "VeryLazy",
		config = function()
			require("rc/pluginconfig/nvim-cursorword")
		end,
	},
	-- {
	-- 	"RRethy/vim-illuminate",
	-- 	event = "VimEnter",
	-- 	config = function()
	-- 		require("rc/pluginconfig/vim-illuminate")
	-- 	end,
	-- },
	{
		"brenoprata10/nvim-highlight-colors",
		event = "VeryLazy",
		config = true,
	},
	-- {
	-- 	"m00qek/baleia.nvim",
	-- 	event = "VimEnter",
	-- 	config = function()
	-- 		require("rc/pluginconfig/baleia")
	-- 	end,
	-- },
	{
		"Mr-LLLLL/interestingwords.nvim",
		event = "VeryLazy",
		config = function()
			require("rc/pluginconfig/interestingwords")
		end,
	},
	-- {
	-- 	"Pocco81/HighStr.nvim",
	-- 	event = "VimEnter",
	-- 	config = function()
	-- 		require("rc/pluginconfig/HighStr")
	-- 	end,
	-- },
	-- {
	-- 	"Djancyp/better-comments.nvim",
	-- 	event = "VimEnter",
	-- 	config = function()
	-- 		require("rc/pluginconfig/better-comments")
	-- 	end,
	-- },
	{
		"folke/todo-comments.nvim",
		event = "VeryLazy",
		config = function()
			require("rc/pluginconfig/todo-comments")
		end,
	},
	{
		"melkster/modicator.nvim",
		event = "VeryLazy",
		config = function()
			require("rc/pluginconfig/modicator")
		end,
	},
	-- {
	-- 	"mvllow/modes.nvim",
	-- 	after = { colorscheme },
	-- 	config = function()
	-- 		require("rc/pluginconfig/modes")
	-- 	end,
	-- },

	--------------------------------
	-- Filetype detection
	-- use do_filetype_lua
	-- use {'nathom/filetype.nvim', init = function() vim.g.did_load_filetypes = 1 end}

	--------------------------------
	-- Layout
	-- original autocmd
	-- {
	-- 	"myusuf3/numbers.vim",
	-- 	cmd = { "NumbersToggle", "NumbersOnOff" },
	-- 	config = function()
	-- 		vim.cmd("source ~/.config/nvim/rc/pluginconfig/numbers.vim")
	-- 	end,
	-- },

	--------------------------------
	-- Sidebar
	{
		"GustavoKatel/sidebar.nvim",
		cmd = { "SidebarNvimToggle" },
		config = function()
			require("rc/pluginconfig/sidebar")
		end,
	},

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
	-- use {'kizza/actionmenu.nvim', event = "VimEnter"}
	-- {
	-- 	"sunjon/stylish.nvim",
	-- 	event = "VimEnter",
	-- 	config = function()
	-- 		require("rc/pluginconfig/stylish")
	-- 	end,
	-- },

	--------------------------------
	-- Startup screen
	{
		"goolord/alpha-nvim",
		event = "BufEnter",
		config = function()
			require("rc/pluginconfig/alpha-nvim")
		end,
	},
	-- startup-nvim/startup.nvim

	--------------------------------
	-- Scrollbar
	{
		"petertriho/nvim-scrollbar",
		event = "VimEnter",
		config = function()
			require("rc/pluginconfig/nvim-scrollbar")
		end,
		dependencies = { { "kevinhwang91/nvim-hlslens" } },
	},

	--------------------------------
	-- Cursor
	-- conflict with flash
	-- {
	-- 	"edluffy/specs.nvim",
	-- 	cmd = { "SpecsEnable" },
	-- 	config = function()
	-- 		require("rc/pluginconfig/specs")
	-- 	end,
	-- },

	--------------------------------
	-- Sign
	-- buggy
	-- use {'dsummersl/nvim-sluice'}

	--------------------------------
	-- Minimap
	-- if vim.fn.executable('cargo') == 1 then
	--   use {'wfxr/minimap.vim',
	--     -- event = "VimEnter",
	--     cmd = {'Minimap'},
	--     build = 'cargo install --locked code-minimap'
	--   }
	-- end
	-- archived
	-- { "rinx/nvim-minimap", cmd = { "MinimapOpen" } },

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
	{
		"ziontee113/syntax-tree-surfer",
		event = "VeryLazy",
		config = function()
			require("rc/pluginconfig/syntax-tree-surfer")
		end,
	},
	-- Not moving as expected
	-- { "drybalka/tree-climber.nvim", event = "VimEnter" },

	----------------
	-- Word Move
	{
		"yutkat/wb-only-current-line.nvim",
		event = "VeryLazy"
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
	-- {
	-- 	"wilfreddenton/history.nvim",
	-- 	event = "VimEnter",
	-- 	config = function()
	-- 		require("rc/pluginconfig/history")
	-- 	end,
	-- },
	-- not useful but cool
	-- use {'nacro90/numb.nvim',
	--  config = function() require'rc/pluginconfig/numb' end
	-- }

	--------------------------------
	-- Scroll
	-- I realized I don't like smart scrolling.
	-- {
	-- 	"declancm/cinnamon.nvim",
	-- 	event = "CursorMoved",
	-- 	config = function()
	-- 		require("rc/pluginconfig/cinnamon")
	-- 	end,
	-- },

	--------------------------------
	-- Select
	-- -> treesitter incremental selection
	-- {
	-- 	"ziontee113/syntax-tree-surfer",
	-- 	after = "nvim-treesitter",
	-- 	config = function()
	-- 		require("rc/pluginconfig/syntax-tree-surfer")
	-- 	end,
	-- },

	--------------------------------
	-- Edit/Insert
	{
		"RRethy/nvim-align",
		cmd = { "Align" },
	},
	{
		"yutkat/delete-word-to-chars.nvim",
		event = "VeryLazy",
		config = true,
	},

	--------------------------------
	-- Text Object
	{
		"XXiaoA/ns-textobject.nvim",
		event = "VeryLazy",
		config = function()
			require("rc/pluginconfig/ns-textobject")
		end,
	},

	--------------------------------
	-- Operator
	{
		"gbprod/substitute.nvim",
		event = "VeryLazy",
		config = function()
			require("rc/pluginconfig/substitute")
		end,
	},
	{
		"kylechui/nvim-surround",
		event = "VeryLazy",
		config = function()
			require("rc/pluginconfig/nvim-surround")
		end,
	},

	-----------------
	-- Join
	-- {
	-- 	"AckslD/nvim-trevJ.lua",
	-- 	event = "VimEnter",
	-- 	config = function()
	-- 		require("rc/pluginconfig/nvim-trevJ")
	-- 	end,
	-- },
	{
		"Wansmer/treesj",
		event = "VeryLazy",
		config = function()
			require("rc/pluginconfig/treesj")
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
	{
		"AckslD/nvim-neoclip.lua",
		event = "VeryLazy",
		config = function()
			require("rc/pluginconfig/nvim-neoclip")
		end,
	},
	-- https://github.com/neovim/neovim/pull/25872/
	-- {
	-- 	"yutkat/osc52.nvim",
	-- 	event = "VeryLazy"
	-- },
	-- include yoink g:yoinkSyncSystemClipboardOnFocus
	{
		"yutkat/save-clipboard-on-exit.nvim",
		event = "VeryLazy"
	},

	--------------------------------
	-- Paste
	{
		"tversteeg/registers.nvim",
		event = "VeryLazy",
		enable = function()
			return vim.fn.has("clipboard") == 1
		end,
		config = function()
			require("rc/pluginconfig/registers")
		end,
	},
	{
		"AckslD/nvim-anywise-reg.lua",
		event = "VeryLazy",
		config = function()
			require("rc/pluginconfig/nvim-anywise-reg")
		end,
	},

	--------------------------------------------------------------
	-- Search

	--------------------------------
	-- Find
	-- {
	-- 	"kevinhwang91/nvim-hlslens",
	-- 	event = "VeryLazy",
	-- 	config = function()
	-- 		require("rc/pluginconfig/nvim-hlslens")
	-- 	end,
	-- },
	{
		"rapan931/lasterisk.nvim",
		event = "VeryLazy",
		config = function()
			require("rc/pluginconfig/lasterisk")
		end,
	},
	-- -> nvim-hlslens
	-- {
	-- 	"rapan931/utahraptor.nvim",
	-- 	event = "VimEnter",
	-- 	config = function()
	-- 		require("rc/pluginconfig/utahraptor")
	-- 	end,
	-- },

	--------------------------------
	-- Replace

	--------------------------------
	-- Grep tool
	{
		"windwp/nvim-spectre",
		event = "VeryLazy",
		config = function()
			require("rc/pluginconfig/nvim-spectre")
		end,
	},

	--------------------------------------------------------------
	-- File switcher

	--------------------------------
	-- Open
	-- @Vim script
	-- { "wsdjeg/vim-fetch", event = "VimEnter" },
	{
		"hrsh7th/nvim-gtd",
		event = "VeryLazy",
		config = function()
			require("rc/pluginconfig/nvim-gtd")
		end,
	},

	--------------------------------
	-- Buffer
	{
		"famiu/bufdelete.nvim",
		event = "VeryLazy",
		config = function()
			require("rc/pluginconfig/bufdelete")
		end,
	},

	--------------------------------
	-- Buffer switcher
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
	{
		"nvim-neo-tree/neo-tree.nvim",
		event = "VimEnter",
		branch = "main",
		config = function()
			require("rc/pluginconfig/neo-tree")
		end,
	},

	--------------------------------
	-- Window
	{
		"s1n7ax/nvim-window-picker",
		event = "VeryLazy",
		config = function()
			require("rc/pluginconfig/nvim-window-picker")
		end,
	},
	{
		"kwkarlwang/bufresize.nvim",
		event = "WinNew",
		config = function()
			require("rc/pluginconfig/bufresize")
		end,
	},

	------------------------------------------------------------
	-- Standard Feature Enhancement

	--------------------------------
	-- Undo

	--------------------------------
	-- Diff
	{
		"antosha417/nvim-compare-with-clipboard",
		event = "VeryLazy",
		config = function()
			require("rc/pluginconfig/nvim-compare-with-clipboard")
		end,
	},

	--------------------------------
	-- Mark
	{
		"chentoast/marks.nvim",
		event = "VeryLazy",
		config = function()
			require("rc/pluginconfig/marks")
		end,
	},
	-- can't jump to the file number
	-- {
	--   'ThePrimeagen/harpoon',
	--   event = "VimEnter",
	--   config = function() require 'rc/pluginconfig/harpoon' end
	-- }
	-- {
	--   'brandoncc/telescope-harpoon.nvim',
	--   event = "VimEnter",
	--   config = function() require('telescope').load_extension('harpoon') end
	-- }

	--------------------------------
	-- Fold
	-- unused
	-- {
	-- 	"anuvyklack/pretty-fold.nvim",
	-- 	dependencies = 'anuvyklack/nvim-keymap-amend',
	-- 	event = "VimEnter",
	-- 	config = function()
	-- 		require("pretty-fold").setup()
	-- 		require("pretty-fold.preview").setup()
	-- 	end,
	-- },

	--------------------------------
	-- Manual
	{
		"lalitmee/browse.nvim",
		event = "VeryLazy",
		config = function()
			require("rc/pluginconfig/browse")
		end,
	},
	{
		"folke/which-key.nvim",
		event = "VeryLazy",
		config = function()
			require("rc/pluginconfig/which-key")
		end,
	},
	-- {
	-- 	"sudormrfbin/cheatsheet.nvim",
	-- 	dependencies = { { "nvim-telescope/telescope.nvim", opt = true } },
	-- 	after = { "telescope.nvim" },
	-- },

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
	{
		"gabrielpoca/replacer.nvim",
		event = "VeryLazy",
		config = function()
			require("rc/pluginconfig/replacer")
		end,
	},
	{
		"stevearc/qf_helper.nvim",
		event = "VeryLazy",
		config = function()
			require("rc/pluginconfig/qf_helper")
		end,
	},

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
	{
		"ecthelionvi/NeoComposer.nvim",
		config = true,
	},
	{
		"tani/dmacro.nvim",
		event = "VeryLazy",
		config = function()
			require("rc/pluginconfig/dmacro")
		end,
	},

	--------------------------------
	-- SpellCheck
	-- -> null-ls(cspell)

	--------------------------------
	-- SpellCorrect (iabbr)
	{
		"Mateiadrielrafael/scrap.nvim",
		event = "VeryLazy",
		config = function()
			require("rc/pluginconfig/scrap")
		end,
	},

	--------------------------------
	-- Command
	{
		"sbulav/nredir.nvim",
		cmd = { "Nredir" },
	},
	{
		"jghauser/mkdir.nvim",
		event = "VeryLazy",
		config = function()
			require("mkdir")
		end,
	},
	{
		"sQVe/sort.nvim",
		cmd = { "Sort" }
	},
	{
		"yutkat/confirm-quit.nvim",
		event = "CmdlineEnter",
		config = function()
			require("confirm-quit").setup()
			vim.cmd("unabbreviate qa")
		end,
	},
	{
		"smjonas/live-command.nvim",
		event = "CmdlineEnter",
		config = function()
			require("rc/pluginconfig/live-command")
		end,
	},

	--------------------------------
	-- Commandline
	{
		"folke/noice.nvim",
		event = "VimEnter",
		config = function()
			require("rc/pluginconfig/noice")
		end,
	},
	{
		"hrsh7th/cmp-cmdline",
		event = "VimEnter"
	},
	{
		"dmitmel/cmp-cmdline-history",
		event = "VimEnter"
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
	{
		"akinsho/toggleterm.nvim",
		event = "VimEnter",
		config = function()
			require("rc/pluginconfig/toggleterm")
		end,
	},
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
	{
		"lewis6991/hover.nvim",
		event = "VeryLazy",
		config = function()
			require("rc/pluginconfig/hover")
		end,
	},

	--------------------------------
	-- Screenshot

	--------------------------------
	-- Command Palette

	--------------------------------
	-- Memo
	{
		"renerocksai/telekasten.nvim",
		event = "VimEnter",
		config = function()
			require("rc/pluginconfig/telekasten")
		end,
		dependencies = { "renerocksai/calendar-vim" },
	},

	--------------------------------
	-- Scratch
	-- -> memo plugin

	--------------------------------
	-- Hex
	-- -> https://github.com/WerWolv/ImHex
	-- { "Shougo/vinarise.vim", cmd = { "Vinarise" } },

	--------------------------------
	-- Browser integration
	-- -> lalitmee/browse.nvim

	--------------------------------
	-- Mode extension
	{
		"nvimtools/hydra.nvim",
		event = "VimEnter",
		config = function()
			require("rc/pluginconfig/hydra")
		end,
		dependencies = {
			{ "lewis6991/gitsigns.nvim" },
		},
	},

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
	{
		"jackMort/ChatGPT.nvim",
		cmd = { "ChatGPT", "ChatGPTActAs" },
		config = true,
	},

	--------------------------------
	-- Analytics
	-- @Vim script
	{
		"wakatime/vim-wakatime",
		event = "VeryLazy",
		enabled = function()
			return vim.env.DISABLE_WAKATIME ~= "true" and vim.uv.fs_stat(vim.fs.normalize("~/.wakatime.cfg")) ~= nil
		end,
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
		opts = true
	},
	-- { "zsugabubus/crazy8.nvim", event = { "BufNewFile", "BufReadPost" } },
	-- NMAC427/guess-indent.nvim
	{
		"rareitems/put_at_end.nvim",
		event = { "VeryLazy" },
		config = function()
			require("rc/pluginconfig/put_at_end")
		end,
	},
	-- use ime
	-- {
	-- 	"protex/better-digraphs.nvim",
	-- 	event = "InsertEnter",
	-- 	config = function()
	-- 		require("rc/pluginconfig/better-digraphs")
	-- 	end,
	-- },

	--------------------------------
	-- Reading assistant
	{
		"lukas-reineke/indent-blankline.nvim",
		event = "VimEnter",
		config = function()
			require("rc/pluginconfig/indent-blankline")
		end,
	},
	{
		"kristijanhusak/line-notes.nvim",
		event = "VeryLazy",
		config = function()
			require("rc/pluginconfig/line-notes")
		end,
	},

	--------------------------------
	-- Comment out
	{
		"numToStr/Comment.nvim",
		event = "VeryLazy",
		config = function()
			require("rc/pluginconfig/Comment")
		end,
	},
	{
		"s1n7ax/nvim-comment-frame",
		event = "VeryLazy",
		config = function()
			require("rc/pluginconfig/nvim-comment-frame")
		end,
		dependencies = { { "nvim-treesitter/nvim-treesitter" } },
	},
	{
		"LudoPinelli/comment-box.nvim",
		event = "VeryLazy",
		config = function()
			require("rc/pluginconfig/comment-box")
		end,
	},

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
	-- https://github.com/theHamsta/nvim-treesitter-pairs/pull/8
	-- { "theHamsta/nvim-treesitter-pairs", event = "VimEnter" },
	-- do not work correnctly
	{
		"monkoose/matchparen.nvim",
		event = "VimEnter",
		config = function()
			require("rc/pluginconfig/matchparen")
		end,
	},
	{
		"hrsh7th/nvim-insx",
		event = "VimEnter",
		config = function()
			require("rc/pluginconfig/nvim-insx")
		end,
	},

	--------------------------------
	-- Endwise
	-- -> nvim-insx
	-- {
	-- 	"RRethy/nvim-treesitter-endwise",
	-- 	event = "VimEnter",
	-- 	dependencies = { { "nvim-treesitter/nvim-treesitter" } },
	-- },

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
		"klen/nvim-test",
		event = "VeryLazy",
		config = function()
			require("rc/pluginconfig/nvim-test")
		end,
	},
	{
		"michaelb/sniprun",
		enabled = function()
			return vim.fn.executable("cargo")
		end,
		build = "bash install.sh",
		cmd = { "SnipRun" },
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
	-- https://github.com/jose-elias-alvarez/null-ls.nvim/issues/1621
	-- {
	-- 	"jose-elias-alvarez/null-ls.nvim",
	-- 	event = "VimEnter",
	-- 	config = function()
	-- 		require("rc/pluginconfig/null-ls")
	-- 	end,
	-- },
	{
		"mfussenegger/nvim-lint",
		event = "VeryLazy",
		config = function()
			require("rc/pluginconfig/nvim-lint")
		end,
	},
	-- {
	-- 	"nvimdev/guard.nvim",
	-- 	event = "VimEnter",
	-- 	config = function()
	-- 		require("rc/pluginconfig/guard")
	-- 	end,
	-- },

	--------------------------------
	-- Format
	-- {
	-- 	"mhartington/formatter.nvim",
	-- 	event = "VimEnter",
	-- 	config = function()
	-- 		require("rc/pluginconfig/formatter")
	-- 	end,
	-- },
	-- {
	-- 	"elentok/format-on-save.nvim",
	-- 	event = "VimEnter",
	-- 	config = function()
	-- 		require("rc/pluginconfig/format-on-save")
	-- 	end,
	-- },
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
	{
		"benfowler/telescope-luasnip.nvim",
		event = "VimEnter",
		config = function()
			require("telescope").load_extension("luasnip")
		end,
	},

	--------------------------------
	-- Snippet Pack
	-- { "molleweide/LuaSnip-snippets.nvim", event = "VimEnter" },
	{ "rafamadriz/friendly-snippets" },

	--------------------------------
	-- Project
	-- {'ygm2/rooter.nvim', event = "VimEnter"}
	{
		"notjedi/nvim-rooter.lua",
		event = "BufEnter",
		opts = true
	},
	{
		"klen/nvim-config-local",
		-- lazy = false,
		event = "BufEnter",
		config = function()
			require("rc/pluginconfig/nvim-config-local")
		end,
	},

	--------------------------------
	-- Git
	{
		"NeogitOrg/neogit",
		event = "VeryLazy",
		config = function()
			require("rc/pluginconfig/neogit")
		end,
	},
	{
		"akinsho/git-conflict.nvim",
		event = "VeryLazy",
		config = true,
	},
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
		config = true,
	},

	--------------------------------
	-- GitHub
	{
		"pwntester/octo.nvim",
		cmd = { "Octo" }
	},

	--------------------------------
	-- Debugger
	{
		"mfussenegger/nvim-dap",
		event = "VeryLazy",
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
			{
				"nvim-telescope/telescope-dap.nvim",
			},
			{ "jbyuki/one-small-step-for-vimkind" },
		},
	},
	{
		"andrewferrier/debugprint.nvim",
		event = "VeryLazy",
		config = function()
			require("rc/pluginconfig/debugprint")
		end,
	},

	--------------------------------
	-- REPL
	{
		"hkupty/iron.nvim",
		event = "VeryLazy",
		config = function()
			require("rc/pluginconfig/iron")
		end,
	},
	{
		"rafcamlet/nvim-luapad",
		cmd = { "Luapad" },
		config = true,
	},
	-- I don't know how to use it
	-- {
	-- 	"Olical/conjure",
	-- 	init = function()
	-- 		vim.g["conjure#extract#tree_sitter#enabled"] = true
	-- 	end,
	-- 	cmd = { "ConjureConnect" },
	-- },

	--------------------------------------------------------------
	-- Programming Languages

	--------------------------------
	-- JavaScript
	{
		"vuki656/package-info.nvim",
		event = "VeryLazy",
		config = function()
			require("rc/pluginconfig/package-info")
		end,
	},
	{
		"bennypowers/nvim-regexplainer",
		config = function()
			require("rc/pluginconfig/nvim-regexplainer")
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
	{
		"toppair/peek.nvim",
		build = "deno task --quiet build:fast",
		ft = { "markdown" },
		enabled = function()
			return vim.fn.executable("deno")
		end,
		config = function()
			require("rc/pluginconfig/peek")
		end,
	},
	-- {
	-- 	"cnshsliu/smp.nvim",
	-- 	ft = { "markdown" },
	-- },

	--------------------------------
	-- SQL
	-- use {'dbext.vim'} -- I get a helptag error. Disabled for now because I don't use it.
	-- use {'tpope/vim-dadbod', event = "VimEnter"}

	--------------------------------
	-- CSV
	{
		"chen244/csv-tools.lua",
		ft = { "csv" },
		config = function()
			require("rc/pluginconfig/csv-tools")
		end,
	},

	--------------------------------
	-- Log
	-- -> treesitter

	--------------------------------
	-- Json

	--------------------------------
	-- Neovim Lua development
	-- do not customize K mapping
	-- { "tjdevries/nlua.nvim", event = "VimEnter" },
	-- { "tjdevries/manillua.nvim", event = "VimEnter" },
	{
		"bfredl/nvim-luadev",
		event = "VimEnter"
	},
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
