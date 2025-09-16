local lint = require('lint')
local function pick_linters(linters)
  vim.print(linters)
  for _, l in ipairs(linters) do
    print(l)
    if lint.linters[l] and vim.fn.executable(lint.linters[l].cmd()) == 1 then
      return { l }
    end
  end
  return {}
end
local function make_linters_by_ft()
  return {
    lua        = { 'selene', },
    sh         = { 'shellcheck', },
    bash       = { 'shellcheck', },
    zsh        = { 'shellcheck', },
    rust       = { 'clippy', },
    python     = { 'ruff', },
    markdown   = { 'markdownlint-cli2', },
    javascript = pick_linters({ "biomejs", "eslint_d" }),
    typescript = pick_linters({ "biomejs", "eslint_d" }),
  }
end

lint.linters_by_ft = make_linters_by_ft()
lint.linters["markdownlint-cli2"].args = { "--config", "~/.config/markdownlint-cli2/.markdownlint-cli2.yaml" }

lint.try_lint()

vim.api.nvim_create_autocmd({ "BufWritePost" }, {
  callback = function()
    require("lint").try_lint()
    if vim.fn.filereadable(".vale.ini") > 0 then
      require("lint").try_lint({ "vale" })
    end
  end,
})
