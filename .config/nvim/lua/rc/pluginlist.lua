local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
if not vim.loop.fs_stat(lazypath) then
	vim.fn.system({
		"git",
		"clone",
		"--filter=blob:none",
		"--single-branch",
		"https://github.com/folke/lazy.nvim.git",
		lazypath,
	})
end
vim.opt.runtimepath:prepend(lazypath)

----------------------------------------------------------------
---- Load local plugins
local function load_local_plugins()
	if vim.fn.filereadable(vim.fn.expand("~/.nvim_pluginlist_local.lua")) == 1 then
		return dofile(vim.fn.expand("~/.nvim_pluginlist_local.lua"))
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
		event = "BufReadPre",
		config = function()
			require("rc/pluginconfig/mason")
		end,
	},

	-- ------------------------------------------------------------
	-- Library

	--------------------------------
	-- Vim script Library
	{ "tpope/vim-repeat", event = "VimEnter" },
	-- use {'mattn/webapi-vim'}

	--------------------------------
	-- Lua Library
	{ "nvim-lua/popup.nvim" },
	{ "nvim-lua/plenary.nvim" }, -- do not lazy load
	{ "kkharji/sqlite.lua" },
	{ "MunifTanjim/nui.nvim" },
	-- lspsaga
	-- {
	-- 	"SmiteshP/nvim-navic",
	-- 	init = function()
	-- 		require("rc/pluginconfig/nvim-navic")
	-- 	end,
	-- },

	--------------------------------
	-- UI Library
	{
		"stevearc/dressing.nvim",
		event = "VimEnter",
		config = function()
			require("rc/pluginconfig/dressing")
		end,
	},

	--------------------------------
	-- Denops Library
	-- use {'vim-denops/denops.vim'}

	--------------------------------
	-- Notify
	{
		"rcarriga/nvim-notify",
		event = "BufReadPre",
		config = function()
			require("rc/pluginconfig/nvim-notify")
		end,
	},

	--------------------------------
	-- ColorScheme
	{
		"EdenEast/nightfox.nvim",
		event = { "BufReadPre", "BufWinEnter" },
		config = function()
			require("rc/pluginconfig/nightfox")
		end,
	},

	--------------------------------
	-- Font
	-- use {'ryanoasis/vim-devicons'}
	{
		"kyazdani42/nvim-web-devicons",
		enabled = function()
			return not os.getenv("DISABLE_DEVICONS") or os.getenv("DISABLE_DEVICONS") == "false"
		end,
	},
	{
		"delphinus/cellwidths.nvim",
		event = "BufEnter",
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
			{ "hrsh7th/cmp-nvim-lsp-signature-help" },
			{ "hrsh7th/cmp-nvim-lsp-document-symbol" },
			{ "hrsh7th/cmp-buffer" },
			{ "hrsh7th/cmp-path" },
			-- { "hrsh7th/cmp-omni" },
			{ "hrsh7th/cmp-nvim-lua" },
			{
				"zbirenbaum/copilot-cmp",
				config = function()
					require("copilot_cmp").setup()
				end,
			},
			-- { "hrsh7th/cmp-copilot" },
			{ "hrsh7th/cmp-emoji" },
			{ "hrsh7th/cmp-calc" },
			{ "f3fora/cmp-spell" },
			{ "yutkat/cmp-mocword" },
			{
				"uga-rosa/cmp-dictionary",
				config = function()
					require("rc/pluginconfig/cmp-dictionary")
				end,
			},
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
		event = { "BufReadPre" },
		config = function()
			require("rc/pluginconfig/nvim-lspconfig")
		end,
		dependencies = {
			{
				"folke/neoconf.nvim",
				config = function()
					require("rc/pluginconfig/neoconf")
				end,
			},
			{
				"williamboman/mason-lspconfig.nvim",
				config = function()
					require("rc/pluginconfig/mason-lspconfig")
				end,
			},
			{ "weilbith/nvim-lsp-smag", after = "nvim-lspconfig" },
		},
	},
	-- -> hrsh7th/cmp-nvim-lsp-signature-help, hrsh7th/cmp-nvim-lsp-document-symbol
	-- {
	-- 	"ray-x/lsp_signature.nvim",
	-- 	after = "nvim-lspconfig",
	-- 	config = function()
	-- 		require("rc/pluginconfig/lsp_signature")
	-- 	end,
	-- },
	-- {
	-- 	"tamago324/nlsp-settings.nvim",
	-- 	after = { "nvim-lspconfig" },
	-- 	config = function()
	-- 		require("rc/pluginconfig/nlsp-settings")
	-- 	end,
	-- },
	-- library for litee
	-- use {
	--   'ldelossa/litee.nvim',
	--   after = 'nvim-lspconfig',
	--   config = function() require('litee.lib').setup({}) end
	-- }

	--------------------------------
	-- LSP's UI
	-- use {'nvim-lua/lsp-status.nvim', after = 'nvim-lspconfig'}
	-- use {
	--   'nvim-lua/lsp_extensions.nvim',
	--   after = 'mason.nvim',
	--   config = function() require 'rc/pluginconfig/lsp_extensions' end
	-- }
	{
		"glepnir/lspsaga.nvim",
		event = "VimEnter",
		config = function()
			require("rc/pluginconfig/lspsaga")
		end,
	},
	{
		"folke/lsp-colors.nvim",
	},
	{
		"folke/trouble.nvim",
		event = "VimEnter",
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
		event = "VimEnter",
		config = function()
			require("rc/pluginconfig/fidget")
		end,
	},
	-- use {
	--   'ray-x/navigator.lua',
	--   after = 'mason.nvim',
	--   dependencies = {'ray-x/guihua.lua', build = 'cd lua/fzy && make', opt = true},
	--   config = function() require 'rc/pluginconfig/navigator' end
	-- }
	-- use {
	--   'onsails/diaglist.nvim',
	--   after = 'nvim-lspconfig',
	--   config = function() require 'rc/pluginconfig/diaglist' end
	-- }
	-- -> lspsaa
	-- use {
	--   'rmagatti/goto-preview',
	--   after = 'nvim-lspconfig',
	--   config = function() require 'rc/pluginconfig/goto-preview' end
	-- }
	-- -> lspsaa
	-- use {
	--   'filipdutescu/renamer.nvim',
	--   after = 'nvim-lspconfig',
	--   config = function() require 'rc/pluginconfig/renamer' end
	-- }
	-- -> lspsaa
	-- use {
	--   'kosayoda/nvim-lightbulb',
	--   after = 'nvim-lspconfig',
	--   config = function() require 'rc/pluginconfig/nvim-lightbulb' end
	-- }
	-- weilbith/nvim-code-action-menu
	-- RishabhRD/nvim-lsputils
	-- aspeddro/lsp_menu.nvim

	--------------------------------
	-- AI completion
	-- use {'zxqfl/tabnine-vim'}
	-- { "github/copilot.vim", cmd = { "Copilot" } },
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
			{
				"nvim-telescope/telescope-frecency.nvim",
				config = function()
					require("telescope").load_extension("frecency")
				end,
			},
			-- I don't know how to use it.
			-- {
			-- 	"prochri/telescope-all-recent.nvim",
			-- 	config = function()
			-- 		require("telescope-all-recent").setup({})
			-- 	end,
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
			-- {
			-- 	"nvim-telescope/telescope-packer.nvim",
			-- 	config = function()
			-- 		require("telescope").load_extension("packer")
			-- 	end,
			-- },
			{
				"crispgm/telescope-heading.nvim",
				config = function()
					require("telescope").load_extension("heading")
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
				"nvim-telescope/telescope-media-files.nvim",
				enabled = function()
					return vim.fn.executable("ueberzug")
				end,
				config = function()
					require("telescope").load_extension("media_files")
				end,
			},
		},
	},
	-- {
	-- 	"nvim-telescope/telescope-project.nvim",
	-- 	after = { "telescope.nvim" },
	-- 	config = function()
	-- 		require("telescope").load_extension("project")
	-- 	end,
	-- },
	-- {
	-- 	"nvim-telescope/telescope-vimspector.nvim",
	-- 	after = { "telescope.nvim" },
	-- 	config = function()
	-- 		require("telescope").load_extension("vimspector")
	-- 	end,
	-- },
	-- {
	-- 	"nvim-telescope/telescope-ghq.nvim",
	-- 	after = { "telescope.nvim" },
	-- 	config = function()
	-- 		require("telescope").load_extension("ghq")
	-- 	end,
	-- },
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
		event = { "VimEnter" },
		build = ":TSUpdateSync",
		config = function()
			require("rc/pluginconfig/nvim-treesitter")
		end,
		dependencies = {
			{ "JoosepAlviste/nvim-ts-context-commentstring" },
			{ "nvim-treesitter/nvim-treesitter-refactor" },
			{ "nvim-treesitter/nvim-tree-docs" },
			{ "vigoux/architext.nvim" },
			{ "yioneko/nvim-yati" },
		},
	},
	-- -> use hop
	-- mfussenegger/nvim-treehopper
	-- {
	-- 	"bryall/contextprint.nvim",
	-- 	after = { "nvim-treesitter" },
	-- 	config = function()
	-- 		require("rc/pluginconfig/contextprint")
	-- 	end,
	-- },
	-- Error on :Gina status
	-- use {
	--   'code-biscuits/nvim-biscuits',
	--   after = {'nvim-treesitter', colorscheme},
	--   config = function() require 'rc/pluginconfig/nvim-biscuits' end
	-- }
	-- {
	-- 	"nvim-treesitter/playground",
	-- 	after = { "nvim-treesitter" },
	-- },

	--------------------------------
	-- Treesitter textobject & operator
	{ "nvim-treesitter/nvim-treesitter-textobjects", event = "VimEnter" },
	{
		"chrisgrieser/nvim-various-textobjs",
		event = "VimEnter",
		config = function()
			require("rc/pluginconfig/nvim-various-textobjs")
		end,
	},
	-- incremental-selection
	-- { "RRethy/nvim-treesitter-textsubjects", after = { "nvim-treesitter" } },
	{
		"mizlan/iswap.nvim",
		event = "VimEnter",
		config = function()
			require("rc/pluginconfig/iswap")
		end,
	},
	{
		"mfussenegger/nvim-treehopper",
		event = "VimEnter",
		config = function()
			require("rc/pluginconfig/nvim-treehopper")
		end,
	},
	{
		"David-Kunz/treesitter-unit",
		event = "VimEnter",
		config = function()
			require("rc/pluginconfig/treesitter-unit")
		end,
	},

	--------------------------------
	-- Treesitter UI customize
	{ "mrjones2014/nvim-ts-rainbow", event = "VimEnter" },
	{ "haringsrob/nvim_context_vt", event = "VimEnter" },
	{
		"m-demare/hlargs.nvim",
		event = "VimEnter",
		config = function()
			require("rc/pluginconfig/hlargs")
		end,
	},
	{
		"romgrk/nvim-treesitter-context",
		cmd = { "TSContextEnable" },
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
	-- There are Lua plugin. I haven't tried it yet because I'm satisfied with coc.
	-- norcalli/nvim-colorizer.lua
	-- use {'powerman/vim-plugin-AnsiEsc', event = "VimEnter"}
	{
		"xiyaowong/nvim-cursorword",
		event = "VimEnter",
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
		"norcalli/nvim-colorizer.lua",
		event = "VimEnter",
		config = function()
			require("colorizer").setup()
		end,
	},
	-- {
	-- 	"m00qek/baleia.nvim",
	-- 	event = "VimEnter",
	-- 	config = function()
	-- 		require("rc/pluginconfig/baleia")
	-- 	end,
	-- },
	{
		"t9md/vim-quickhl",
		event = "VimEnter",
		config = function()
			vim.cmd("source ~/.config/nvim/rc/pluginconfig/vim-quickhl.vim")
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
		event = "VimEnter",
		config = function()
			require("rc/pluginconfig/todo-comments")
		end,
	},
	{
		"melkster/modicator.nvim",
		event = "VimEnter",
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
	-- I didn't use zen-mode much
	-- use {'kdav5758/TrueZen.nvim', cmd = {'TZAtaraxis', 'TZMinimalist', 'TZBottom', 'TZTop', 'TZLeft'}}
	-- use {'folke/zen-mode.nvim', cmd = {'ZenMode'}}

	--------------------------------
	-- Sidebar
	-- conflict with clever-f (augroup sidebar_nvim_prevent_buffer_override)
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
		event = "VimEnter",
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
		lazy = false,
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
	{
		"edluffy/specs.nvim",
		cmd = { "SpecsEnable" },
		config = function()
			require("rc/pluginconfig/specs")
		end,
	},

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
	-- -> use snippets
	-- { "kana/vim-smartchr", event = "VimEnter" },
	-- use {'kana/vim-arpeggio', event = "VimEnter"}
	-- use {'tpope/vim-sexp-mappings-for-regular-people', event = "VimEnter"}

	--------------------------------
	-- Move
	{
		"phaazon/hop.nvim",
		event = "VimEnter",
		config = function()
			require("rc/pluginconfig/hop")
		end,
	},
	----------------
	-- Horizontal Move
	{
		"jinh0/eyeliner.nvim",
		event = "VimEnter",
		config = function()
			require("eyeliner").setup({})
		end,
	},
	-- use {'gukz/ftFt.nvim', event = "VimEnter", config = function() require 'rc/pluginconfig/ftFt' end}
	-- still wasn't great.
	{
		"ggandor/lightspeed.nvim",
		event = "VimEnter",
		init = function()
			vim.g.lightspeed_no_default_keymaps = true
		end,
		config = function()
			require("rc/pluginconfig/lightspeed")
		end,
	},

	----------------
	-- Vertical Move
	{
		"haya14busa/vim-edgemotion",
		event = "VimEnter",
		config = function()
			vim.cmd("source ~/.config/nvim/rc/pluginconfig/vim-edgemotion.vim")
		end,
	},
	{
		"machakann/vim-columnmove",
		event = "VimEnter",
		config = function()
			vim.cmd("source ~/.config/nvim/rc/pluginconfig/vim-columnmove.vim")
		end,
	},
	-- {
	-- 	"ziontee113/syntax-tree-surfer",
	-- 	event = "VimEnter",
	-- 	config = function()
	-- 		require("rc/pluginconfig/syntax-tree-surfer")
	-- 	end,
	-- },
	-- Not moving as expected
	-- { "drybalka/tree-climber.nvim", event = "VimEnter" },

	----------------
	-- Word Move
	{
		"justinmk/vim-ipmotion",
		event = "VimEnter",
		config = function()
			vim.cmd("source ~/.config/nvim/rc/pluginconfig/vim-ipmotion.vim")
		end,
	},
	{
		"bkad/CamelCaseMotion",
		event = "VimEnter",
		config = function()
			vim.cmd("source ~/.config/nvim/rc/pluginconfig/CamelCaseMotion.vim")
		end,
	},
	{ "yutkat/wb-only-current-line.nvim", event = "VimEnter" },

	--------------------------------
	-- Jump
	{
		"osyo-manga/vim-milfeulle",
		event = "VimEnter",
		config = function()
			vim.cmd("source ~/.config/nvim/rc/pluginconfig/vim-milfeulle.vim")
		end,
	},
	{
		"cbochs/portal.nvim",
		event = "VimEnter",
		config = function()
			require("rc/pluginconfig/portal")
		end,
	},
	{
		"kwkarlwang/bufjump.nvim",
		event = "VimEnter",
		config = function()
			require("rc/pluginconfig/bufjump")
		end,
	},
	-- -> bufferline
	-- {
	-- 	"Bakudankun/BackAndForward.vim",
	-- 	event = "VimEnter",
	-- 	config = function()
	-- 		vim.cmd("source ~/.config/nvim/rc/pluginconfig/BackAndForward.vim")
	-- 	end,
	-- },
	-- not useful but cool
	-- use {'nacro90/numb.nvim',
	--  config = function() require'rc/pluginconfig/numb' end
	-- }

	--------------------------------
	-- Scroll
	-- use {'psliwka/vim-smoothie'} -- slow
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
	-- -> treesitter incremental selection
	-- {
	-- 	"terryma/vim-expand-region",
	-- 	event = "VimEnter",
	-- 	init = function()
	-- 		vim.cmd("source ~/.config/nvim/rc/pluginsetup/vim-expand-region.vim")
	-- 	end,
	-- },
	-- -> do not use
	-- {
	-- 	"terryma/vim-multiple-cursors",
	-- 	event = "VimEnter",
	-- 	init = function()
	-- 		vim.cmd("source ~/.config/nvim/rc/pluginsetup/vim-multiple-cursors.vim")
	-- 	end,
	-- },
	-- {
	-- 	"kana/vim-niceblock",
	-- 	event = "VimEnter",
	-- 	config = function()
	-- 		vim.cmd("source ~/.config/nvim/rc/pluginconfig/vim-niceblock.vim")
	-- 	end,
	-- },
	-- use {'mg979/vim-visual-multi'} -- -> mapping infection

	--------------------------------
	--
	-- Edit/Insert
	{
		"RRethy/nvim-align",
		cmd = { "Align" },
	},
	-- {
	-- 	"thinca/vim-partedit",
	-- 	-- event = "VimEnter",
	-- 	cmd = { "Partedit" },
	-- },
	{
		"yutkat/delete-word-to-chars.nvim",
		event = "VimEnter",
		config = function()
			require("delete-word-to-chars").setup()
		end,
	},

	--------------------------------
	-- Text Object
	{
		"XXiaoA/ns-textobject.nvim",
		event = "VimEnter",
		config = function()
			require("rc/pluginconfig/ns-textobject")
		end,
	},

	--------------------------------
	-- Operator
	{
		"gbprod/substitute.nvim",
		event = "VimEnter",
		config = function()
			require("rc/pluginconfig/substitute")
		end,
	},
	{
		"kylechui/nvim-surround",
		event = "VimEnter",
		config = function()
			require("rc/pluginconfig/nvim-surround")
		end,
	},

	-----------------
	-- Join
	{
		"AckslD/nvim-trevJ.lua",
		event = "VimEnter",
		config = function()
			require("rc/pluginconfig/nvim-trevJ")
		end,
	},

	-----------------
	-- Adding and subtracting
	-- { "deris/vim-rengbang", event = "VimEnter" },
	{
		"monaqa/dial.nvim",
		event = "VimEnter",
		config = function()
			require("rc/pluginconfig/dial")
		end,
	},
	-- use {'zegervdv/nrpattern.nvim',
	--   config = function() require'rc/pluginconfig/nrpattern' end
	-- }

	--------------------------------
	-- Yank
	{
		"hrsh7th/nvim-pasta",
		event = "VimEnter",
		config = function()
			require("rc/pluginconfig/nvim-pasta")
		end,
	},
	{
		"AckslD/nvim-neoclip.lua",
		event = "VimEnter",
		config = function()
			require("rc/pluginconfig/nvim-neoclip")
		end,
	},
	{ "yutkat/osc52.nvim", event = "VimEnter" },
	-- { "chikatoike/concealedyank.vim", event = "VimEnter" },
	-- include yoink g:yoinkSyncSystemClipboardOnFocus
	{ "yutkat/save-clipboard-on-exit.nvim", event = "VimEnter" },

	--------------------------------
	-- Paste
	-- { "yutkat/auto-paste-mode.vim", event = "VimEnter" },
	{
		"tversteeg/registers.nvim",
		event = "VimEnter",
		enable = function()
			return vim.fn.has("clipboard") == 1
		end,
		config = function()
			require("rc/pluginconfig/registers")
		end,
	},
	{
		"AckslD/nvim-anywise-reg.lua",
		event = "VimEnter",
		config = function()
			require("rc/pluginconfig/nvim-anywise-reg")
		end,
	},
	-- -> AckslD/nvim-anywise-reg.lua
	-- {
	-- 	"deris/vim-pasta",
	-- 	event = "VimEnter",
	-- 	config = function()
	-- 		vim.cmd("source ~/.config/nvim/rc/pluginconfig/vim-pasta.vim")
	-- 	end,
	-- },

	--------------------------------------------------------------
	-- Search

	--------------------------------
	-- Find
	{
		"kevinhwang91/nvim-hlslens",
		event = "VimEnter",
		config = function()
			require("rc/pluginconfig/nvim-hlslens")
		end,
	},
	{
		"rapan931/lasterisk.nvim",
		event = "VimEnter",
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
	-- { "lambdalisue/reword.vim", event = "VimEnter" },
	-- { "haya14busa/vim-metarepeat", event = "VimEnter" },

	--------------------------------
	-- Grep tool
	{
		"windwp/nvim-spectre",
		event = "VimEnter",
		config = function()
			require("rc/pluginconfig/nvim-spectre")
		end,
	},
	-- use {'dyng/ctrlsf.vim'}

	--------------------------------------------------------------
	-- File switcher

	--------------------------------
	-- Open
	{ "wsdjeg/vim-fetch", event = "VimEnter" },

	--------------------------------
	-- Buffer
	{
		"famiu/bufdelete.nvim",
		event = "VimEnter",
		config = function()
			require("rc/pluginconfig/bufdelete")
		end,
	},

	--------------------------------
	-- Buffer switcher
	{
		"stevearc/stickybuf.nvim",
		event = "VimEnter",
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
	-- {
	-- 	"tkmpypy/chowcho.nvim",
	-- 	event = "WinNew",
	-- 	config = function()
	-- 		require("rc/pluginconfig/chowcho")
	-- 	end,
	-- },
	{
		"s1n7ax/nvim-window-picker",
		event = "VimEnter",
		config = function()
			require("rc/pluginconfig/nvim-window-picker")
		end,
	},
	-- use {'andymass/vim-tradewinds', event = "WinNew"}
	{
		"kwkarlwang/bufresize.nvim",
		event = "WinNew",
		config = function()
			require("rc/pluginconfig/bufresize")
		end,
	},
	-- -> do not use eventignore! https://github.com/luukvbaal/stabilize.nvim/commit/718561393f885dbbc9de8ed71089772af0dbbb3f
	-- use {
	--   'luukvbaal/stabilize.nvim',
	--   event = "VimEnter",
	--   config = function() require 'rc/pluginconfig/stabilize' end
	-- }

	------------------------------------------------------------
	-- Standard Feature Enhancement

	--------------------------------
	-- Undo
	{
		"debugloop/telescope-undo.nvim",
		event = "VimEnter",
		config = function()
			require("telescope").load_extension("undo")
		end,
	},
	-- {
	-- 	"simnalamburt/vim-mundo",
	-- 	-- event = "VimEnter"
	-- 	cmd = { "MundoShow" },
	-- },
	-- {
	-- 	"kevinhwang91/nvim-fundo",
	-- 	dependencies = { "kevinhwang91/promise-async", module = { "promise", "async" } },
	-- 	event = "VimEnter",
	-- 	build = function()
	-- 		require("fundo").install()
	-- 	end,
	-- 	config = function()
	-- 		require("fundo").setup()
	-- 	end,
	-- },
	-- use {'mbbill/undotree'} -- -> not maintained recently
	-- cool but too slow
	-- if not vim.g.vscode then
	--   use {'machakann/vim-highlightedundo',
	--     config = function() vim.cmd('source ~/.config/nvim/rc/pluginconfig/vim-highlightedundo.vim') end
	--   }
	-- end

	--------------------------------
	-- Diff
	{
		"AndrewRadev/linediff.vim",
		-- event = "VimEnter"
		cmd = { "Linediff" },
	},
	-- set diffopt+=internal,algorithm:patience
	-- { "chrisbra/vim-diff-enhanced", event = "VimEnter" },

	--------------------------------
	-- Mark
	{
		"chentoast/marks.nvim",
		event = "VimEnter",
		config = function()
			require("rc/pluginconfig/marks")
		end,
	},
	-- can't jump to the file number
	-- use {
	--   'ThePrimeagen/harpoon',
	--   event = "VimEnter",
	--   dependencies = {{'nvim-lua/plenary.nvim', opt = true}, {'nvim-lua/popup.nvim', opt = true}},
	--   config = function() require 'rc/pluginconfig/harpoon' end
	-- }
	-- use {
	--   'brandoncc/telescope-harpoon.nvim',
	--   after = {'harpoon', 'telescope.nvim'},
	--   config = function() require('telescope').load_extension('harpoon') end
	-- }
	-- don't work
	-- use {'edluffy/hologram.nvim', config = function() require 'rc/pluginconfig/hologram' end}

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
		event = "VimEnter",
		config = function()
			require("rc/pluginconfig/browse")
		end,
	},
	{
		"folke/which-key.nvim",
		event = "VimEnter",
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
	-- use lsp
	-- if vim.fn.executable("global") == 1 then
	-- 	{
	-- 		"jsfaint/gen_tags.vim",
	-- 		-- event = "VimEnter",
	-- 		cmd = { "GenCtags", "GenGTAGS" },
	-- 		config = function()
	-- 			vim.cmd("source ~/.config/nvim/rc/pluginconfig/gen_tags.vim")
	-- 		end,
	-- 	},
	-- end

	--------------------------------
	-- Quickfix
	{
		"kevinhwang91/nvim-bqf",
		event = "VimEnter",
		config = function()
			require("rc/pluginconfig/nvim-bqf")
		end,
	},
	{
		"gabrielpoca/replacer.nvim",
		event = "VimEnter",
		config = function()
			require("rc/pluginconfig/replacer")
		end,
	},
	{
		"stevearc/qf_helper.nvim",
		event = "VimEnter",
		config = function()
			require("rc/pluginconfig/qf_helper")
		end,
	},

	--------------------------------
	-- Session
	-- do not use the session per current directory
	{
		"jedrzejboczar/possession.nvim",
		lazy = false,
		config = function()
			require("rc/pluginconfig/possession")
		end,
	},
	-- {
	-- 	"Shatur/neovim-session-manager",
	-- 	config = function()
	-- 		require("rc/pluginconfig/neovim-session-manager")
	-- 	end,
	-- },
	-- {
	-- 	"olimorris/persisted.nvim",
	-- 	config = function()
	-- 		require("rc/pluginconfig/persisted")
	-- 	end,
	-- },

	--------------------------------
	-- Macro
	-- Not convenient
	-- {
	-- 	"zdcthomas/medit",
	-- 	event = "VimEnter",
	-- 	init = function()
	-- 		vim.cmd("source ~/.config/nvim/rc/pluginsetup/medit.vim")
	-- 	end,
	-- },

	--------------------------------
	-- SpellCheck
	-- -> null-ls(cspell)
	-- https://github.com/neovim/neovim/pull/19419
	-- {
	-- 	"lewis6991/spellsitter.nvim",
	-- 	after = "nvim-treesitter",
	-- 	config = function()
	-- 		require("rc/pluginconfig/spellsitter")
	-- 	end,
	-- },

	--------------------------------
	-- SpellCorrect (iabbr)
	{
		"Pocco81/AbbrevMan.nvim",
		event = "VimEnter",
		config = function()
			require("rc/pluginconfig/AbbrevMan")
		end,
	},

	--------------------------------
	-- Command
	{
		"sbulav/nredir.nvim",
		cmd = { "Nredir" },
	},
	-- { "thinca/vim-ambicmd", event = "VimEnter" },
	-- { "tyru/vim-altercmd", event = "VimEnter" },
	{
		"jghauser/mkdir.nvim",
		event = "VimEnter",
		config = function()
			require("mkdir")
		end,
	},
	{ "sQVe/sort.nvim", cmd = { "Sort" } },
	{ "yutkat/confirm-quit.nvim", event = "VimEnter" },
	{
		"smjonas/live-command.nvim",
		event = "CmdlineEnter",
		config = function()
			require("rc/pluginconfig/live-command")
		end,
	},
	-- -> filer
	-- use {'tpope/vim-eunuch'}

	--------------------------------
	-- Commandline
	{
		"folke/noice.nvim",
		event = "VimEnter",
		config = function()
			require("rc/pluginconfig/noice")
		end,
	},
	{ "hrsh7th/cmp-cmdline", event = "VimEnter" },
	{ "dmitmel/cmp-cmdline-history", event = "VimEnter" },
	-- -> cmp-cmdline
	-- wilder did not work
	-- use {'VonHeikemen/fine-cmdline.nvim', dependencies = "MunifTanjim/nui.nvim"}

	--------------------------------
	-- History
	{
		"yutkat/history-ignore.nvim",
		event = "CmdlineEnter",
		config = function()
			require("history-ignore").setup()
		end,
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
		event = "VimEnter",
		config = function()
			require("term-gf").setup()
		end,
	},
	-- use {'kassio/neoterm'} -- include repl
	-- use {'numToStr/FTerm.nvim'}

	--------------------------------
	-- Backup/Swap
	{
		"aiya000/aho-bakaup.vim",
		event = "VimEnter",
		init = function()
			vim.cmd("source ~/.config/nvim/rc/pluginsetup/aho-bakaup.vim")
		end,
	},
	-- use {'chrisbra/vim-autosave'}

	--------------------------------------------------------------
	-- New features

	--------------------------------
	-- Translate
	{
		"uga-rosa/translate.nvim",
		event = "VimEnter",
		config = function()
			require("rc/pluginconfig/translate")
		end,
	},

	--------------------------------
	-- Popup Info
	{
		"lewis6991/hover.nvim",
		event = "VimEnter",
		config = function()
			require("rc/pluginconfig/hover")
		end,
	},

	--------------------------------
	-- Screenshot
	-- Not much use
	-- { "segeljakt/vim-silicon", cmd = { "Silicon" } },

	--------------------------------
	-- Command Palette
	-- not use
	-- {
	-- 	"mrjones2014/legendary.nvim",
	-- 	after = { "dressing.nvim", "telescope.nvim" },
	-- 	config = function()
	-- 		require("rc/pluginconfig/legendary")
	-- 	end,
	-- },

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
	-- Furkanzmc/zettelkasten.nvim
	-- if vim.fn.executable("zk") == 1 then
	-- 	{
	-- 		"mickael-menu/zk-nvim",
	-- 		event = "VimEnter",
	-- 		build = function()
	-- 			local dir = vim.fn.stdpath("data") .. "/zk/"
	-- 			os.execute("mkdir -p " .. dir)
	-- 		end,
	-- 		config = function()
	-- 			require("rc/pluginconfig/zk-nvim")
	-- 		end,
	-- 	},
	-- end
	-- use {'stevearc/gkeep.nvim', event = "VimEnter", build = ':UpdateRemotePlugins'}

	--------------------------------
	-- Scratch
	-- -> memo plugin

	--------------------------------
	-- Hex
	-- -> https://github.com/WerWolv/ImHex
	-- { "Shougo/vinarise.vim", cmd = { "Vinarise" } },

	--------------------------------
	-- Browser integration
	-- {
	-- 	"tyru/open-browser.vim",
	-- 	event = "VimEnter",
	-- 	config = function()
	-- 		vim.cmd("source ~/.config/nvim/rc/pluginconfig/open-browser.vim")
	-- 	end,
	-- },
	-- { "tyru/open-browser-github.vim", after = { "open-browser.vim" } },

	--------------------------------
	-- Mode extension
	{
		"anuvyklack/hydra.nvim",
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
		"glepnir/template.nvim",
		event = "VimEnter",
		config = function()
			require("rc/pluginconfig/template")
		end,
	},

	--------------------------------
	-- Performance Improvement
	-- startup time didn't change much
	-- {
	-- 	"lewis6991/impatient.nvim",
	-- 	config = function()
	-- 		require("impatient")
	-- 	end,
	-- },

	--------------------------------
	-- OpenAI
	{
		"jackMort/ChatGPT.nvim",
		cmd = { "ChatGPT", "ChatGPTActAs" },
		config = function()
			require("chatgpt").setup({
				-- optional configuration
			})
		end,
	},

	--------------------------------
	-- Analytics
	{
		"wakatime/vim-wakatime",
		event = "VimEnter",
		enabled = function()
			return (not os.getenv("DISABLE_WAKATIME") or os.getenv("DISABLE_WAKATIME") == "true")
				and vim.fn.filereadable(vim.fn.expand("~/.wakatime.cfg")) == 1
		end,
	},

	--------------------------------
	-- LiveShare
	-- use {'jbyuki/instant.nvim'}

	--------------------------------
	-- Patch
	-- https://github.com/neovim/neovim/issues/12587
	-- Cursor position shifted when indentation is lost
	-- if has('nvim')
	--  use {'antoinemadec/FixCursorHold.nvim'}
	-- endif

	--------------------------------
	-- etc
	-- use {
	--   'yutkat/dps-coding-now.nvim',
	--   cond = function() return os.getenv("CODING_NOW_GITHUB_TOKEN") ~= nil end,
	--   after = {'denops.vim'}
	-- }
	-- use {'sunjon/extmark-toy.nvim'}

	--------------------------------------------------------------
	-- Coding

	--------------------------------
	-- Writing assistant
	{
		"nmac427/guess-indent.nvim",
		event = { "BufNewFile", "BufReadPre" },
		config = function()
			require("guess-indent").setup()
		end,
	},
	-- { "zsugabubus/crazy8.nvim", event = { "BufNewFile", "BufReadPost" } },
	-- NMAC427/guess-indent.nvim
	{
		"rareitems/put_at_end.nvim",
		event = { "BufNewFile", "BufReadPre" },
		config = function()
			require("rc/pluginconfig/put_at_end")
		end,
	},
	-- don't work on rust
	-- {
	-- 	"TornaxO7/tree-setter",
	-- 	after = { "nvim-treesitter" },
	-- },
	-- use ime
	-- {
	-- 	"protex/better-digraphs.nvim",
	-- 	event = "InsertEnter",
	-- 	config = function()
	-- 		require("rc/pluginconfig/better-digraphs")
	-- 	end,
	-- },
	-- use {
	--   'abecodes/tabout.nvim',
	--   after = {'nvim-treesitter', 'coc.nvim'},
	--   config = function() require 'rc/pluginconfig/tabout' end
	-- }
	--
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
		event = "VimEnter",
		config = function()
			require("rc/pluginconfig/line-notes")
		end,
	},
	-- romgrk/nvim-treesitter-context

	--------------------------------
	-- Comment out
	{
		"numToStr/Comment.nvim",
		event = "VimEnter",
		config = function()
			require("rc/pluginconfig/Comment")
		end,
	},
	{
		"s1n7ax/nvim-comment-frame",
		event = "VimEnter",
		config = function()
			require("rc/pluginconfig/nvim-comment-frame")
		end,
		dependencies = { { "nvim-treesitter/nvim-treesitter" } },
	},
	{
		"LudoPinelli/comment-box.nvim",
		event = "VimEnter",
		config = function()
			require("rc/pluginconfig/comment-box")
		end,
	},

	--------------------------------
	-- Annotation
	{
		"danymat/neogen",
		event = "VimEnter",
		config = function()
			require("rc/pluginconfig/neogen")
		end,
	},

	--------------------------------
	-- Brackets
	{ "theHamsta/nvim-treesitter-pairs", event = "VimEnter" },
	-- do not work correnctly
	{
		"monkoose/matchparen.nvim",
		event = "VimEnter",
		config = function()
			require("rc/pluginconfig/matchparen")
		end,
	},
	-- {
	-- 	"m4xshen/autoclose.nvim",
	-- 	event = "VimEnter",
	-- 	config = function()
	-- 		require("rc/pluginconfig/autoclose")
	-- 	end,
	-- },
	-- {
	-- 	"windwp/nvim-autopairs",
	-- 	event = "VimEnter",
	-- 	config = function()
	-- 		require("rc/pluginconfig/nvim-autopairs")
	-- 	end,
	-- },
	{
		"hrsh7th/nvim-insx",
		event = "VimEnter",
		config = function()
			require("rc/pluginconfig/nvim-insx")
		end,
	},
	-- ZhiyuanLck/smart-pairs
	-- use {'steelsojka/pears.nvim',
	--   after = {'nvim-treesitter'},
	--   config = function() require'rc/pluginconfig/pears' end
	-- }
	{
		"windwp/nvim-ts-autotag",
		event = "VimEnter",
		config = function()
			require("rc/pluginconfig/nvim-ts-autotag")
		end,
		dependencies = { { "nvim-treesitter/nvim-treesitter" } },
	},

	--------------------------------
	-- Endwise
	{
		"RRethy/nvim-treesitter-endwise",
		event = "VimEnter",
		dependencies = { { "nvim-treesitter/nvim-treesitter" } },
	},

	--------------------------------
	-- Code jump
	-- {
	-- 	"kana/vim-altr",
	-- 	event = "VimEnter",
	-- 	config = function()
	-- 		vim.cmd("source ~/.config/nvim/rc/pluginconfig/vim-altr.vim")
	-- 	end,
	-- },
	{
		"rgroli/other.nvim",
		event = "VimEnter",
		config = function()
			require("rc/pluginconfig/other")
		end,
	},
	-- micmine/jumpwire.nvim
	-- { "tpope/vim-apathy", event = "VimEnter" },

	--------------------------------
	-- Test
	{
		"klen/nvim-test",
		event = "VimEnter",
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
		event = "VimEnter",
		config = function()
			require("rc/pluginconfig/overseer")
		end,
	},
	-- {
	-- 	"yutkat/taskrun.nvim",
	-- 	after = { "toggleterm.nvim", "nvim-notify" },
	-- 	config = function()
	-- 		require("rc/pluginconfig/taskrun")
	-- 	end,
	-- },
	-- {
	-- 	"pianocomposer321/yabs.nvim",
	-- 	event = "VimEnter",
	-- 	config = function()
	-- 		require("rc/pluginconfig/yabs")
	-- 	end,
	-- },

	--------------------------------
	-- Lint
	{
		"jose-elias-alvarez/null-ls.nvim",
		event = "VimEnter",
		config = function()
			require("rc/pluginconfig/null-ls")
		end,
	},

	--------------------------------
	-- Format
	-- -> null-ls.nvim
	-- { "gpanders/editorconfig.nvim", event = "VimEnter" },
	-- -> null-ls
	-- use {
	--   'lukas-reineke/format.nvim',
	--   event = "VimEnter",
	--   config = function() require 'rc/pluginconfig/format' end
	-- }
	-- -> null-ls
	-- {
	-- 	"cappyzawa/trim.nvim",
	-- 	event = "VimEnter",
	-- 	config = function()
	-- 		require("trim").setup()
	-- 	end,
	-- },

	--------------------------------
	-- Code outline
	-- use {'ElPiloto/sidekick.nvim'}
	{
		"stevearc/aerial.nvim",
		event = "VimEnter",
		config = function()
			require("rc/pluginconfig/aerial")
		end,
	},
	-- use {
	--   'simrat39/symbols-outline.nvim',
	--   event = "VimEnter",
	--   config = function() require 'rc/pluginconfig/symbols-outline' end
	-- }
	-- use {
	--   'ldelossa/litee-symboltree.nvim',
	--   after = {'nvim-lspconfig', 'litee.nvim'},
	--   config = function() require('litee.symboltree').setup({}) end
	-- }

	--------------------------------
	-- Call Hierarchy
	-- use {
	--   'ldelossa/litee-calltree.nvim',
	--   after = {'nvim-lspconfig', 'litee.nvim'},
	--   config = function() require('litee.calltree').setup({}) end
	-- }

	----------------------------------
	---- Snippet
	{
		"L3MON4D3/LuaSnip",
		event = "VimEnter",
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
	-- use {'ygm2/rooter.nvim', event = "VimEnter"}
	{
		"ahmedkhalf/project.nvim",
		event = "BufWinEnter",
		config = function()
			require("rc/pluginconfig/project")
		end,
	},
	-- {
	-- 	"airblade/vim-rooter",
	-- 	event = "VimEnter",
	-- 	config = function()
	-- 		vim.cmd("source ~/.config/nvim/rc/pluginconfig/vim-rooter.vim")
	-- 	end,
	-- },
	{
		"klen/nvim-config-local",
		lazy = false,
		config = function()
			require("rc/pluginconfig/nvim-config-local")
		end,
	},
	-- lua buf too simple
	-- use {'windwp/nvim-projectconfig'}

	--------------------------------
	-- Git
	{
		"TimUntersberger/neogit",
		event = "BufReadPre",
		config = function()
			require("rc/pluginconfig/neogit")
		end,
	},
	{
		"akinsho/git-conflict.nvim",
		event = "VimEnter",
		config = function()
			require("git-conflict").setup()
		end,
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
		event = "VimEnter",
		config = function()
			require("rc/pluginconfig/diffview")
		end,
	},
	-- don't work
	-- use {'tanvirtin/vgit.nvim'}

	--------------------------------
	-- Git command assistant
	-- { "rhysd/committia.vim" },
	{ "hotwatermorning/auto-git-diff", ft = { "gitrebase" } },

	--------------------------------
	-- GitHub
	{ "pwntester/octo.nvim", cmd = { "Octo" } },

	--------------------------------
	-- Debugger
	{
		"mfussenegger/nvim-dap",
		event = "VimEnter",
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
			{ "theHamsta/nvim-dap-virtual-text" },
			{
				"nvim-telescope/telescope-dap.nvim",
			},
		},
	},
	-- archived
	-- { "Pocco81/DAPInstall.nvim", after = { "nvim-dap" } },
	{
		"andrewferrier/debugprint.nvim",
		event = "VimEnter",
		config = function()
			require("rc/pluginconfig/debugprint")
		end,
	},

	--------------------------------
	-- REPL
	{
		"hkupty/iron.nvim",
		event = "VimEnter",
		config = function()
			require("rc/pluginconfig/iron")
		end,
	},

	--------------------------------------------------------------
	-- Programming Languages

	--------------------------------
	-- JavaScript
	{
		"vuki656/package-info.nvim",
		event = "VimEnter",
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
	-- use {'python-mode/python-mode',
	--   branch = 'develop',
	--   ft = {'python'},
	--   config = function() vim.cmd('source ~/.config/nvim/rc/pluginconfig/python-mode.vim') end
	-- }
	-- use {'mgedmin/python-imports.vim',
	--   ft = {'python'}
	-- }

	--------------------------------
	-- Rust
	{
		"simrat39/rust-tools.nvim",
		-- after = { "nvim-lspconfig" },
		-- ft = { "rust" },
		-- config = function()
		-- 	require("rc/pluginconfig/rust-tools")
		-- end,
	},
	-- use {'rhysd/rust-doc.vim',
	--   ft = {'rust'},
	--   config = function() vim.cmd('source ~/.config/nvim/rc/pluginconfig/rust-doc.vim') end
	-- }

	--------------------------------
	-- Markdown
	{ "iamcco/markdown-preview.nvim", ft = { "markdown" }, build = ":call mkdp#util#install()" },
	-- use markdown-preview.nvim
	-- if vim.fn.executable('glow') == 1 then
	--   use {'npxbr/glow.nvim',
	--     ft = {'markdown'},
	--     build = ':GlowInstall',
	--   }
	-- end
	{
		"SidOfc/mkdx",
		ft = { "markdown" },
		init = function()
			vim.cmd("source ~/.config/nvim/rc/pluginsetup/mkdx.vim")
		end,
	},
	{
		"dhruvasagar/vim-table-mode",
		cmd = { "TableModeEnable" },
		config = function()
			vim.cmd("source ~/.config/nvim/rc/pluginconfig/vim-table-mode.vim")
		end,
	},
	-- slow to build
	-- use {'euclio/vim-markdown-composer',
	--   build = 'cargo build --release'
	-- }

	--------------------------------
	-- SQL
	-- use {'dbext.vim'} -- I get a helptag error. Disabled for now because I don't use it.
	-- use {'tpope/vim-dadbod', event = "VimEnter"}
	{ "alcesleo/vim-uppercase-sql", event = "VimEnter" },

	--------------------------------
	-- CSV
	-- { "mechatroner/rainbow_csv", ft = { "csv" } },
	-- buggy
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
	-- { "MTDL9/vim-log-highlighting", ft = { "log" } },

	--------------------------------
	-- Json
	-- { "neoclide/jsonc.vim", ft = { "json", "jsonc" } },

	--------------------------------
	-- Neovim Lua development
	-- do not customize K mapping
	-- { "tjdevries/nlua.nvim", event = "VimEnter" },
	-- { "tjdevries/manillua.nvim", event = "VimEnter" },
	{ "bfredl/nvim-luadev", event = "VimEnter" },
	{ "folke/neodev.nvim" },
	-- { "wadackel/nvim-syntax-info", cmd = { "SyntaxInfo" } },
}

require("lazy").setup(vim.tbl_deep_extend("force", plugins, local_plugins), {
	defaults = {
		lazy = true, -- should plugins be lazy-loaded?
	},
	dev = {
		path = vim.fn.stdpath("data") .. "/dev",
	},
})
