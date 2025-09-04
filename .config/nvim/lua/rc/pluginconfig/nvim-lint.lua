require('lint').linters_by_ft = {
  lua = { 'selene', },
  sh = { 'shellcheck', },
  bash = { 'shellcheck', },
  zsh = { 'shellcheck', },
  javascript = { 'eslint_d' },
  typescript = { 'eslint_d' },
  rust = { 'clippy', },
  markdown = { 'markdownlint-cli2', },
}
require('lint').linters["markdownlint-cli2"].args = { "--config", "~/.config/markdownlint-cli2/.markdownlint-cli2.yaml" }

require("lint").try_lint()

vim.api.nvim_create_autocmd({ "BufWritePost" }, {
  callback = function()
    require("lint").try_lint()
    if vim.fn.filereadable(".vale.ini") > 0 then
      require("lint").try_lint({ "vale" })
    end
  end,
})
