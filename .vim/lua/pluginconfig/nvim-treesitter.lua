require'nvim-treesitter.configs'.setup {
    highlight = {
        -- enable = false,                    -- false will disable the whole extension
        disable = { 'c', 'rust' },        -- list of language that will be disabled
    },
    incremental_selection = {
        enable = true,
        disable = { 'cpp', 'lua' },
        keymaps = {                       -- mappings for incremental selection (visual mappings)
            init_selection = 'gnn',         -- maps in normal mode to init the node/scope selection
            node_incremental = "grn",       -- increment to the upper named parent
            scope_incremental = "grc",      -- increment to the upper scope (as defined in locals.scm)
            node_decremental = "grm",       -- decrement to the previous node
        }
    },
    refactor = {
        highlight_defintions = {
            enable = true
        },
        smart_rename = {
            enable = true,
            smart_rename = "grr"              -- mapping to rename reference under cursor
        },
        navigation = {
            enable = true,
            goto_definition = "gnd",          -- mapping to go to definition of symbol under cursor
            list_definitions = "gnD"          -- mapping to list all definitions in current file
        }
    },
    ensure_installed = 'all' -- one of 'all', 'language', or a list of languages
}
