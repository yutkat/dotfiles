require'nvim-treesitter.configs'.setup {
  ensure_installed = 'all', -- one of 'all', 'language', or a list of languages
  highlight = {
    enable = true, -- false will disable the whole extension
    disable = {}, -- list of language that will be disabled
    custom_captures = { -- mapping of user defined captures to highlight groups
      -- ["foo.bar"] = "Identifier"   -- highlight own capture @foo.bar with highlight group "Identifier", see :h nvim-treesitter-query-extensions
    }
  },
  incremental_selection = {
    enable = true,
    keymaps = { -- mappings for incremental selection (visual mappings)
      -- node_incremental = "grn", -- increment to the upper named parent
      -- scope_incremental = "grc", -- increment to the upper scope (as defined in locals.scm)
      -- init_selection = 'gnn', -- maps in normal mode to init the node/scope selection
      -- node_decremental = "grm" -- decrement to the previous node
      init_selection = "<CR>",
      scope_incremental = "<CR>",
      node_incremental = "<TAB>",
      node_decremental = "<S-TAB>"
    }
  },
  indent = {enable = true},
  refactor = {
    highlight_definitions = {enable = false},
    highlight_current_scope = {enable = false},
    smart_rename = {
      enable = true,
      keymaps = {
        smart_rename = "Gr" -- mapping to rename reference under cursor
      }
    },
    navigation = {
      enable = true,
      keymaps = {
        goto_definition = "Gd", -- mapping to go to definition of symbol under cursor
        list_definitions = "GD" -- mapping to list all definitions in current file
      }
    }
  },
  textobjects = { -- syntax-aware textobjects
    select = {
      enable = true,
      disable = {},
      keymaps = {
        ["aF"] = "@function.outer",
        ["iF"] = "@function.inner",
        ["aC"] = "@class.outer",
        ["iC"] = "@class.inner",
        ["iB"] = "@block.inner",
        ["aB"] = "@block.outer",
        -- use sandwich
        -- ["i"] = "@call.inner",
        -- ["a"] = "@call.outer",
        -- ["a"] = "@comment.outer",
        ["iI"] = "@conditional.inner",
        ["aI"] = "@conditional.outer",
        ["iL"] = "@loop.inner",
        ["aL"] = "@loop.outer",
        ["iP"] = "@parameter.inner",
        ["aP"] = "@parameter.outer",
        ["aS"] = "@statement.outer",
        ["iD"] = {
          python = "(function_definition) @function",
          cpp = "(function_definition) @function",
          c = "(function_definition) @function",
          java = "(method_declaration) @function"
        }
      }
    },
    swap = {
      enable = true,
      swap_next = {["G>>"] = "@parameter.inner"},
      swap_previous = {["G<<"] = "@parameter.inner"}
    },
    move = {
      enable = true,
      goto_next_start = {["]m"] = "@function.outer", ["]]"] = "@class.outer"},
      goto_next_end = {["]M"] = "@function.outer", ["]["] = "@class.outer"},
      goto_previous_start = {["[m"] = "@function.outer", ["[["] = "@class.outer"},
      goto_previous_end = {["[M"] = "@function.outer", ["[]"] = "@class.outer"}
    }
  },
  textsubjects = {enable = true, keymaps = {['.'] = 'textsubjects-smart'}},
  rainbow = {
    enable = true,
    disable = {'cpp'} -- please disable lua and bash for now
  },
  pairs = {
    enable = false,
    disable = {},
    highlight_pair_events = {"CursorMoved"}, -- when to highlight the pairs, use {} to deactivate highlighting
    highlight_self = true,
    goto_right_end = false, -- whether to go to the end of the right partner or the beginning
    fallback_cmd_normal = "call matchit#Match_wrapper('',1,'n')", -- What command to issue when we can't find a pair (e.g. "normal! %")
    keymaps = {goto_partner = "<leader>%"}
  },
  context_commentstring = {enable = true}
}

vim.api.nvim_set_keymap('n', '<SubLeader>e', '<Cmd>e!<CR>', {noremap = false, silent = true})
