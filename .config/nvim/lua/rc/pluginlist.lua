local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
if not vim.uv.fs_stat(lazypath) then
	vim
		.system({
			"git",
			"clone",
			"--filter=blob:none",
			"--single-branch",
			"https://github.com/folke/lazy.nvim.git",
			lazypath,
		}, { text = true })
		:wait()
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

	-- ------------------------------------------------------------
	-- Library

	--------------------------------
	-- Lua Library

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
		lazy = false,
		priority = 1000,
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
	},

	--------------------------------
	-- Language Server Protocol(LSP)
	{
		"neovim/nvim-lspconfig",
		event = { "BufReadPre", "BufNewFile" },
		config = function()
			require("rc/pluginconfig/nvim-lspconfig")
		end,
	},
	{
		"yutkat/mise-lspconfig.nvim",
		event = { "BufReadPre", "BufNewFile" },
		dependencies = { "neovim/nvim-lspconfig" },
		opts = {
			exclude = { "denols", "rust_analyzer" }, -- rust_analyzer: started by rustaceanvim
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
	-- Copilot runs as a plain LSP (copilot-language-server via mise-lspconfig);
	-- builtin vim.lsp.inline_completion (pluginconfig/blink-cmp.lua) and sidekick.nvim consume that client.
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
		cmd = { "TSManager", "TSUpdateSync" },
		config = function()
			require("rc/pluginconfig/tree-sitter-manager")
		end,
	},

	--------------------------------
	-- Treesitter textobject & operator

	--------------------------------
	-- Treesitter UI customize
	-- m-demare/hlargs.nvim -> LSP semantic tokens (@lsp.type.parameter)

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
	-- brenoprata10/nvim-highlight-colors -> mini.hipatterns hex colors + LSP document colors
	{
		"nvim-mini/mini.hipatterns",
		version = "*",
		event = "VeryLazy",
		config = function()
			require("rc/pluginconfig/mini-hipatterns")
		end,
	},
	-- TODO/FIXME/... comment keywords: nvim-mini/mini.hipatterns

	--------------------------------
	-- Filetype detection
	-- builtin vim.filetype (Lua filetype detection)

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
	-- current window separator highlight: rc/autocmd.lua

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
		"chrisgrieser/nvim-spider",
		event = "VeryLazy",
		config = function()
			require("rc/pluginconfig/nvim-spider")
		end,
	},

	----------------
	-- Vertical Move

	----------------
	-- Word Move
	{
		"yutkat/wb-only-current-line.nvim",
		event = "VeryLazy",
	},

	--------------------------------
	-- Jump
	-- jumplist filtered by buffer (<C-a>/<C-g>/g<C-o>/g<C-i>): rc/mappings.lua

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
		-- Track main: the Nightly CancelRedo rename fix is not in a release yet
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
	-- p/P -> builtin ]p/[p (rc/mappings.lua)
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
	-- * / g* without moving: search_stay() in rc/mappings.lua

	--------------------------------
	-- Replace

	--------------------------------
	-- Grep tool
	-- project-wide replace: snacks picker grep -> quickfix (<C-q>) -> :cdo s/.../.../

	--------------------------------------------------------------
	-- File switcher

	--------------------------------
	-- Open
	-- LSP definition: 'd (rc/treesitter.lua), <C-]> (LSP tagfunc)

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
	-- Pin a buffer to its window: builtin 'winfixbuf' (rc/autocmd.lua)

	--------------------------------
	-- Tab

	--------------------------------
	-- Filer
	-- folke/snacks.nvim explorer

	--------------------------------
	-- Window
	-- window selection: builtin <C-w> commands

	------------------------------------------------------------
	-- Standard Feature Enhancement

	--------------------------------
	-- Undo
	-- Builtin optional plugin (:Undotree), loaded through lazy.nvim instead of :packadd
	{
		dir = vim.env.VIMRUNTIME .. "/pack/dist/opt/nvim.undotree",
		name = "nvim.undotree",
		cmd = "Undotree",
	},

	--------------------------------
	-- Diff

	--------------------------------
	-- Mark
	-- folke/snacks.nvim statuscolumn (mark signs)

	--------------------------------
	-- Fold

	--------------------------------
	-- Manual
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
	-- quickfix list UI: folke/trouble.nvim (:Trouble quickfix)

	--------------------------------
	-- Session
	-- do not use the session per current directory
	{
		"nvim-mini/mini.sessions",
		version = "*",
		event = "VeryLazy", -- loaded early enough for the VimLeavePre autosave
		cmd = { "SessionSaveCurrent", "SessionLoadCurrent" }, -- `nvim -c SessionLoadCurrent` runs before VeryLazy
		config = function()
			require("rc/pluginconfig/mini-sessions")
		end,
	},

	--------------------------------
	-- Macro

	--------------------------------
	-- SpellCheck

	--------------------------------
	-- SpellCorrect (iabbr)

	--------------------------------
	-- Command
	{
		"yutkat/confirm-quit.nvim",
		event = "CmdlineEnter",
		config = function()
			require("confirm-quit").setup()
			vim.cmd("unabbreviate qa")
		end,
	},

	--------------------------------
	-- Commandline
	-- -> built-in ui2 (rc/display.lua)

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

	--------------------------------
	-- Popup Info
	-- -> built-in vim.lsp.buf.hover() (only LSP provider was used; mapped to Q in mappings.lua)

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

	--------------------------------
	-- Browser integration
	-- -> lalitmee/browse.nvim

	--------------------------------
	-- Mode extension
	-- cursor line number colored by mode: rc/autocmd.lua

	--------------------------------
	-- Template
	-- :Template <name> (rc/command.lua)

	--------------------------------
	-- Performance Improvement

	--------------------------------
	-- OpenAI

	--------------------------------
	-- Analytics

	--------------------------------
	-- LiveShare

	--------------------------------
	-- Patch

	--------------------------------
	-- etc

	--------------------------------------------------------------
	-- Coding

	--------------------------------
	-- Writing assistant
	-- indent settings: builtin editorconfig

	--------------------------------
	-- Reading assistant
	-- folke/snacks.nvim indent

	--------------------------------
	-- Comment out
	-- -> built-in gc/gcc/gb/gbc (0.10+); <C-_>/<C-/> mapped in mappings.lua

	--------------------------------
	-- Annotation

	--------------------------------
	-- Brackets
	-- -> blink.pairs highlights.matchparen
	{
		"saghen/blink.pairs",
		version = "*",
		dependencies = "saghen/blink.lib",
		-- Prebuilt binaries are only published for tagged releases.
		build = function()
			require("blink.pairs").download():pwait(60000)
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
	-- related file jump (:Other, <F6>, <C-S-T>): rc/myplugins/opt/other-file.lua

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
		-- blink.cmp requires luasnip only while completing/expanding, which
		-- lazy.nvim also resolves on demand.
		event = "InsertEnter",
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
	-- notjedi/nvim-rooter.lua -> vim.fs.root() autocmd in rc/autocmd.lua

	--------------------------------
	-- Git
	{
		"NeogitOrg/neogit",
		event = "VeryLazy",
		config = function()
			require("rc/pluginconfig/neogit")
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
	-- inline / side-by-side diff: gitsigns diffthis (pluginconfig/gitsigns.lua)

	--------------------------------
	-- Git command assistant
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

	--------------------------------
	-- Debugger
	{
		"mfussenegger/nvim-dap",
		keys = { { "<Leader>d", desc = "Debugger prefix" } }, -- lazy-load on the [_Debugger] prefix
		config = function()
			require("rc/pluginconfig/nvim-dap")
		end,
		dependencies = {
			{ "jbyuki/one-small-step-for-vimkind" },
		},
	},

	--------------------------------
	-- Print debugging (timber.nvim -> debugprint.nvim)
	{
		"andrewferrier/debugprint.nvim",
		version = "*",
		event = "VeryLazy",
		config = function()
			require("rc/pluginconfig/debugprint")
		end,
	},

	--------------------------------
	-- REPL

	--------------------------------------------------------------
	-- Programming Languages

	--------------------------------
	-- JavaScript

	--------------------------------
	-- Python

	--------------------------------
	-- Rust
	{
		"mrcjkb/rustaceanvim",
		version = "^9",
		lazy = false,
		-- after = { "nvim-lspconfig" },
		-- ft = { "rust" },
		-- config = function()
		-- 	require("rc/pluginconfig/rust-tools")
		-- end,
	},

	--------------------------------
	-- Markdown

	--------------------------------
	-- SQL

	--------------------------------
	-- CSV

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
				{ path = "${3rd}/luv/library", words = { "vim%.uv" } },
			},
		},
	},
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

if #vim.api.nvim_list_uis() == 0 then
	require("rc/lazy-sync-summary").setup()
end

require("lazy").setup(merge_lists(plugins, local_plugins), {
	defaults = {
		lazy = true, -- should plugins be lazy-loaded?
	},
	dev = {
		path = vim.fn.stdpath("data") .. "/dev",
	},
	-- Headless syncs print a summary from rc/lazy-sync-summary instead.
	headless = { process = false, log = false, task = false },
})
