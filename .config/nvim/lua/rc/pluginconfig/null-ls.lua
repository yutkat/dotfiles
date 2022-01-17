require("null-ls").setup({
  sources = {
    -- LuaFormatter off
    require("null-ls").builtins.formatting.stylua,
    require("null-ls").builtins.diagnostics.eslint,
    require("null-ls").builtins.diagnostics.shellcheck,
    require("null-ls").builtins.completion.spell
    -- LuaFormatter on
  },
  on_attach = function(client)
    if client.resolved_capabilities.document_formatting then
      vim.cmd([[
            augroup LspFormatting
                autocmd! * <buffer>
                autocmd BufWritePre <buffer> lua vim.lsp.buf.formatting_sync()
            augroup END
            ]])
    end
  end
})
