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
    disable = {'cpp', 'lua'},
    keymaps = { -- mappings for incremental selection (visual mappings)
      init_selection = 'gnn', -- maps in normal mode to init the node/scope selection
      node_incremental = "grn", -- increment to the upper named parent
      scope_incremental = "grc", -- increment to the upper scope (as defined in locals.scm)
      node_decremental = "grm" -- decrement to the previous node
    }
  },
  refactor = {
    highlight_definitions = {enable = true},
    highlight_current_scope = {enable = false},
    smart_rename = {
      enable = true,
      keymaps = {
        smart_rename = "grr" -- mapping to rename reference under cursor
      }
    },
    navigation = {
      enable = true,
      keymaps = {
        goto_definition = "gnd", -- mapping to go to definition of symbol under cursor
        list_definitions = "gnD" -- mapping to list all definitions in current file
      }
    }
  },
  textobjects = { -- syntax-aware textobjects
    select = {
      enable = true,
      disable = {},
      keymaps = {
        ["af"] = "@function.outer",
        ["if"] = "@function.inner",
        ["ac"] = "@class.outer",
        ["ic"] = "@class.inner",
        ["ib"] = "@block.inner",
        ["ab"] = "@block.outer",
        -- ["i"] = "@call.inner",
        -- ["a"] = "@call.outer",
        -- ["a"] = "@comment.outer",
        ["iC"] = "@conditional.inner",
        ["aC"] = "@conditional.outer",
        ["iL"] = "@loop.inner",
        ["aL"] = "@loop.outer",
        ["iP"] = "@parameter.inner",
        ["aP"] = "@parameter.outer",
        ["as"] = "@statement.outer",

        ["iF"] = {
          python = "(function_definition) @function",
          cpp = "(function_definition) @function",
          c = "(function_definition) @function",
          java = "(method_declaration) @function"
        }
      }
    },
    swap = {
      enable = true,
      swap_next = {["<leader>a"] = "@parameter.inner"},
      swap_previous = {["<leader>A"] = "@parameter.inner"}
    },
    move = {
      enable = true,
      goto_next_start = {["]m"] = "@function.outer", ["]]"] = "@class.outer"},
      goto_next_end = {["]M"] = "@function.outer", ["]["] = "@class.outer"},
      goto_previous_start = {
        ["[m"] = "@function.outer",
        ["[["] = "@class.outer"
      },
      goto_previous_end = {["[M"] = "@function.outer", ["[]"] = "@class.outer"}
    }
  },
  rainbow = {
    enable = false,
    disable = {'cpp', 'lua', 'bash'} -- please disable lua and bash for now
  }
}

vim.api.nvim_set_keymap('n', '<SubLeader>e', '<Cmd>e!<CR>', { noremap = false, silent = true })