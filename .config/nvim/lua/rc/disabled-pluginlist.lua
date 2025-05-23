-- ==============================================================
--           Disable                                          {{{
-- ==============================================================
-- cSpell:disable

-- -> "folke/snacks.nvim"
-- {
-- 	"akinsho/toggleterm.nvim",
-- 	event = "VimEnter",
-- 	config = function()
-- 		require("rc/pluginconfig/toggleterm")
-- 	end,
-- },
-- -> "folke/snacks.nvim"
-- {
-- 	"lukas-reineke/indent-blankline.nvim",
-- 	event = "VimEnter",
-- 	config = function()
-- 		require("rc/pluginconfig/indent-blankline")
-- 	end,
-- },
-- -> "folke/snacks.nvim"
-- {
-- 	"goolord/alpha-nvim",
-- 	event = "BufEnter",
-- 	config = function()
-- 		require("rc/pluginconfig/alpha-nvim")
-- 	end,
-- },
-- -> "folke/snacks.nvim"
-- {
-- 	"nvim-neo-tree/neo-tree.nvim",
-- 	event = "VimEnter",
-- 	branch = "main",
-- 	config = function()
-- 		require("rc/pluginconfig/neo-tree")
-- 	end,
-- },
-- -> "folke/snacks.nvim"
-- {
-- 	"famiu/bufdelete.nvim",
-- 	event = "VeryLazy",
-- 	config = function()
-- 		require("rc/pluginconfig/bufdelete")
-- 	end,
-- },
-- -> "folke/snacks.nvim"
-- {
-- 	"rcarriga/nvim-notify",
-- 	event = "VeryLazy",
-- 	config = function()
-- 		require("rc/pluginconfig/nvim-notify")
-- 	end,
-- },
-- {
-- 	"stevearc/dressing.nvim",
-- 	event = "VeryLazy",
-- 	config = function()
-- 		require("rc/pluginconfig/dressing")
-- 	end,
-- },
--	{
--		"folke/neodev.nvim",
--		config = function()
--			require("rc/pluginconfig/neodev")
--		end,
--	},
--	{
--		"hek14/symbol-overlay.nvim",
--		event = "VeryLazy",
--		config = function()
--			require("rc/pluginconfig/symbol-overlay")
--		end,
--	},
-- -> nvim-highlight-colors
--	{
--		"norcalli/nvim-colorizer.lua",
--		event = "VeryLazy",
--		config = true,
--	},
-- -> copilot.lua
-- {
-- 	"zbirenbaum/copilot-cmp",
-- 	config = true,
-- },
-- Sometimes it gets stuck at startup.
-- {
-- 	"ahmedkhalf/project.nvim",
-- 	event = "BufWinEnter",
-- 	config = function()
-- 		require("rc/pluginconfig/project")
-- 	end,
-- },
-- {
-- 	"Pocco81/AbbrevMan.nvim",
-- 	event = "VeryLazy",
-- 	config = function()
-- 		require("rc/pluginconfig/AbbrevMan")
-- 	end,
-- },
-- ->HiPhish/rainbow-delimiters.nvim
-- {
-- 	"HiPhish/nvim-ts-rainbow2",
-- 	event = "BufReadPost",
-- 	config = function()
-- 		-- patch https://github.com/nvim-treesitter/nvim-treesitter/issues/1124
-- 		vim.cmd.edit({ bang = true })
-- 	end,
-- },
-- -> flash.nvim
-- {
-- 	"ggandor/leap.nvim",
-- 	event = "VeryLazy",
-- 	dependencies = {
-- 		"yutkat/leap-word.nvim",
-- 		config = function()
-- 			require("rc/pluginconfig/leap-word")
-- 		end,
-- 	},
-- 	config = function()
-- 		require("rc/pluginconfig/leap")
-- 	end,
-- },
-- {
-- 	"ggandor/leap-ast.nvim",
-- 	event = "VimEnter",
-- 	config = function()
-- 		require("rc/pluginconfig/leap-ast")
-- 	end,
-- },
-- {
-- 	"ggandor/flit.nvim",
-- 	event = "VeryLazy",
-- 	config = function()
-- 		require("rc/pluginconfig/flit")
-- 	end,
-- },
-- do not use
-- { "vigoux/architext.nvim" },
-- {
-- 	"phaazon/hop.nvim",
-- 	event = "VimEnter",
-- 	config = function()
-- 		require("rc/pluginconfig/hop")
-- 	end,
-- },
-- -> leap.nvim
-- {
-- 	"ggandor/lightspeed.nvim",
-- 	event = "VimEnter",
-- 	init = function()
-- 		vim.g.lightspeed_no_default_keymaps = true
-- 	end,
-- 	config = function()
-- 		require("rc/pluginconfig/lightspeed")
-- 	end,
-- },
-- -> "cnshsliu/smp.nvim",
-- { "iamcco/markdown-preview.nvim", ft = { "markdown" }, build = ":call mkdp#util#install()" },
-- -- @Vim script
-- {
-- 	"AndrewRadev/linediff.vim",
-- 	cmd = { "Linediff" },
-- },
-- { "neoclide/jsonc.vim", ft = { "json", "jsonc" } },
-- { "MTDL9/vim-log-highlighting", ft = { "log" } },
-- { "mechatroner/rainbow_csv", ft = { "csv" } },
-- buggy
-- use markdown-preview.nvim
-- if vim.fn.executable('glow') == 1 then
--   use {'npxbr/glow.nvim',
--     ft = {'markdown'},
--     build = ':GlowInstall',
--   }
-- end
-- archived
-- { "Pocco81/DAPInstall.nvim", after = { "nvim-dap" } },
-- { "rhysd/committia.vim" },
-- don't work
-- use {'tanvirtin/vgit.nvim'}
-- lua buf too simple
-- use {'windwp/nvim-projectconfig'}
-- use {
--   'ldelossa/litee-calltree.nvim',
--   after = {'nvim-lspconfig', 'litee.nvim'},
--   config = function() require('litee.calltree').setup({}) end
-- }
-- use {'ElPiloto/sidekick.nvim'}
-- {
-- 	"stevearc/aerial.nvim",
-- 	event = "VimEnter",
-- 	config = function()
-- 		require("rc/pluginconfig/aerial")
-- 	end,
-- },
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
-- micmine/jumpwire.nvim
-- { "tpope/vim-apathy", event = "VimEnter" },
-- {
-- 	"kana/vim-altr",
-- 	event = "VimEnter",
-- 	config = function()
-- 		vim.cmd("source ~/.config/nvim/rc/pluginconfig/vim-altr.vim")
-- 	end,
-- },
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
-- ZhiyuanLck/smart-pairs
-- use {'steelsojka/pears.nvim',
--   after = {'nvim-treesitter'},
--   config = function() require'rc/pluginconfig/pears' end
-- }
-- -> nvim-insx
-- {
-- 	"windwp/nvim-ts-autotag",
-- 	event = "VimEnter",
-- 	config = function()
-- 		require("rc/pluginconfig/nvim-ts-autotag")
-- 	end,
-- 	dependencies = { { "nvim-treesitter/nvim-treesitter" } },
-- },
-- {
--   'abecodes/tabout.nvim',
--   after = {'nvim-treesitter', 'coc.nvim'},
--   config = function() require 'rc/pluginconfig/tabout' end
-- }
--
-- don't work on rust
-- {
-- 	"TornaxO7/tree-setter",
-- 	after = { "nvim-treesitter" },
-- },
-- use {
--   'yutkat/dps-coding-now.nvim',
--   cond = function() return os.getenv("CODING_NOW_GITHUB_TOKEN") ~= nil end,
--   after = {'denops.vim'}
-- }
-- startup time didn't change much
-- {
-- 	"lewis6991/impatient.nvim",
-- 	config = function()
-- 		require("impatient")
-- 	end,
-- },
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
-- not use
-- {
-- 	"mrjones2014/legendary.nvim",
-- 	after = { "dressing.nvim", "telescope.nvim" },
-- 	config = function()
-- 		require("rc/pluginconfig/legendary")
-- 	end,
-- },
-- use {'kassio/neoterm'} -- include repl
-- use {'numToStr/FTerm.nvim'}
-- -> cmp-cmdline
-- wilder did not work
-- use {'VonHeikemen/fine-cmdline.nvim', dependencies = "MunifTanjim/nui.nvim"}
-- -> filer
-- https://github.com/neovim/neovim/pull/19419
-- {
-- 	"lewis6991/spellsitter.nvim",
-- 	after = "nvim-treesitter",
-- 	config = function()
-- 		require("rc/pluginconfig/spellsitter")
-- 	end,
-- },
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
-- don't work
-- use {'edluffy/hologram.nvim', config = function() require 'rc/pluginconfig/hologram' end}
-- set diffopt+=internal,algorithm:patience
-- { "chrisbra/vim-diff-enhanced", event = "VimEnter" },
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
-- -> do not use eventignore! https://github.com/luukvbaal/stabilize.nvim/commit/718561393f885dbbc9de8ed71089772af0dbbb3f
-- use {
--   'luukvbaal/stabilize.nvim',
--   event = "VimEnter",
--   config = function() require 'rc/pluginconfig/stabilize' end
-- }
-- {
-- 	"tkmpypy/chowcho.nvim",
-- 	event = "WinNew",
-- 	config = function()
-- 		require("rc/pluginconfig/chowcho")
-- 	end,
-- },
-- I didn't use zen-mode much
-- use {'kdav5758/TrueZen.nvim', cmd = {'TZAtaraxis', 'TZMinimalist', 'TZBottom', 'TZTop', 'TZLeft'}}
-- use {'folke/zen-mode.nvim', cmd = {'ZenMode'}}
-- There are Lua plugin. I haven't tried it yet because I'm satisfied with coc.
-- norcalli/nvim-colorizer.lua
-- use {'powerman/vim-plugin-AnsiEsc', event = "VimEnter"}
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
-- 	lazy = false
-- },
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
-- 	"nvim-telescope/telescope-packer.nvim",
-- 	config = function()
-- 		require("telescope").load_extension("packer")
-- 	end,
-- },
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
-- use {'nvim-lua/lsp-status.nvim', after = 'nvim-lspconfig'}
-- use {
--   'nvim-lua/lsp_extensions.nvim',
--   after = 'mason.nvim',
--   config = function() require 'rc/pluginconfig/lsp_extensions' end
-- }
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

-- -> lspsaga
-- {
-- 	"SmiteshP/nvim-navic",
-- 	init = function()
-- 		require("rc/pluginconfig/nvim-navic")
-- 	end,
-- },
-- Archived
-- {
-- 	"folke/lsp-colors.nvim",
-- },
-- use({
-- 	"gbprod/yanky.nvim",
-- 	event = "VimEnter",
-- 	config = function()
-- 		require("rc/pluginconfig/yanky")
-- 	end,
-- })
-- use({
-- 	"bfredl/nvim-miniyank",
-- 	event = "VimEnter",
-- 	config = function()
-- 		vim.cmd("source ~/.config/nvim/rc/pluginconfig/nvim-miniyank.vim")
-- 	end,
-- })
-- -> AckslD/nvim-neoclip.lua
-- use({
-- 	"gennaro-tedesco/nvim-peekup",
-- 	event = "VimEnter",
-- 	config = function()
-- 		require("rc/pluginconfig/nvim-peekup")
-- 	end,
-- })
-- use({
-- 	"johmsalas/text-case.nvim",
-- 	event = "VimEnter",
-- 	config = function()
-- 		require("rc/pluginconfig/text-case")
-- 	end,
-- })
-- -> ModeChanged
-- use({
-- 	"kevinhwang91/nvim-hclipboard",
-- 	after = { "LuaSnip" },
-- 	config = function()
-- 		require("hclipboard").start()
-- 	end,
-- })
-- -> andrewferrier/debugprint.nvim
-- use({
-- 	"sentriz/vim-print-debug",
-- 	event = "VimEnter",
-- 	config = function()
-- 		vim.cmd("source ~/.config/nvim/rc/pluginconfig/vim-print-debug.vim")
-- 	end,
-- })
-- -> williamboman/mason.nvim
-- use({
-- 	"williamboman/nvim-lsp-installer",
-- 	after = { "nvim-lspconfig", "cmp-nvim-lsp", "nlsp-settings.nvim" },
-- 	config = function()
-- 		require("rc/pluginconfig/nvim-lsp-installer")
-- 	end,
-- })
-- use({
-- 	"Vonr/align.nvim",
-- 	module = "align",
-- })
-- -> jinh0/eyeliner.nvim
-- use({
-- 	"unblevable/quick-scope",
-- 	event = "VimEnter",
-- 	config = function()
-- 		vim.cmd("source ~/.config/nvim/rc/pluginconfig/quick-scope.vim")
-- 	end,
-- })
-- because generate the file contents automatically
-- use {'vigoux/templar.nvim',
--   event = "VimEnter"
-- }
-- -> uga-rosa/translate.nvim
-- coc-translator
-- use({
-- 	"voldikss/vim-translator",
-- 	event = "VimEnter",
-- 	config = function()
-- 		vim.cmd("source ~/.config/nvim/rc/pluginconfig/vim-translator.vim")
-- 	end,
-- })
-- -> nvim-trevJ.lua
-- use({
-- 	"AckslD/nvim-revJ.lua",
-- 	requires = {
-- 		{ "kana/vim-textobj-user", event = "VimEnter" },
-- 		{ "sgur/vim-textobj-parameter", after = { "vim-textobj-user" } },
-- 	},
-- 	after = { "vim-textobj-user", "vim-textobj-parameter" },
-- 	config = function()
-- 		require("rc/pluginconfig/nvim-revJ")
-- 	end,
-- })
-- archived
-- use({
-- 	"akinsho/dependency-assist.nvim",
-- 	event = "VimEnter",
-- 	config = function()
-- 		require("rc/pluginconfig/dependency-assist")
-- 	end,
-- })
-- -> nvim-bqf
-- use {'yssl/QFEnter',
--   event = "VimEnter"
-- }
-- conflict with vim-test's quickfix
-- use {'itchyny/vim-qfedit' --should compare with use 'stefandtw/quickfix-reflector.vim'}
-- -> zettelkasten
-- use({
-- 	"mtth/scratch.vim",
-- 	cmd = { "Scratch" },
-- 	config = function()
-- 		vim.cmd("source ~/.config/nvim/rc/pluginconfig/scratch.vim")
-- 	end,
-- })
-- -> bfredl/nvim-miniyank
-- use {
--   'svermeulen/vim-yoink',
--   event = "VimEnter",
--   config = function() vim.cmd('source ~/.config/nvim/rc/pluginconfig/vim-yoink.vim') end
-- }
-- -> tkmpypy/chowcho.nvim
-- use {'dstein64/vim-win',
--   config = function() vim.cmd('source ~/.config/nvim/rc/pluginconfig/vim-win.vim') end
-- }
