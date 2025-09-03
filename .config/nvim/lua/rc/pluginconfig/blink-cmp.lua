require("blink.cmp").setup({
  sources = {
    default = { "lsp", "path", "buffer", "snippets", "copilot", "ripgrep" },
    providers = {
      copilot = {
        name = "copilot",
        module = "blink-copilot",
        score_offset = 100,
        async = true,
      },
      ripgrep = {
        name = "Ripgrep",
        module = "blink-ripgrep",
      },
      snippets = {
        score_offset = 100,
      }
    },
  },
  snippets = { preset = "luasnip" },
  completion = {
    list = { selection = { preselect = true } },
    -- trigger = { show_in_snippet = false }
    documentation = { auto_show = true, auto_show_delay_ms = 500, treesitter_highlighting = false },
  },
  signature = { enabled = true },
  keymap = {
    preset = "super-tab",
    ["<CR>"] = { "accept", "fallback" },
  },
  cmdline = {
    completion = { menu = { auto_show = true }, list = { selection = { preselect = false } } },
    keymap = {
      preset = "super-tab",
      ["<CR>"] = { "accept", "fallback" },
    }
  },
})
