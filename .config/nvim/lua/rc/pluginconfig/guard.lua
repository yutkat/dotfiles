local ft = require("guard.filetype")
local g =require("guard")

g.tools.linter.selene = {
	cmd = "selene",
	args = { "--display-style", "quiet", "--display", "max-line-length: 120" },
	stdin = true,
	format = "line",
	pattern = "[^:]\\+\\d\\+:\\d\\+:\\s\\+\\(.*\\)",
}

-- use clang-format and clang-tidy for c files
ft("c"):fmt("clang-format"):lint("clang-tidy")

-- use stylua to format lua files and no linter
ft("lua"):fmt("stylua"):lint("selene")

-- multiple files register
ft("typescript,javascript,typescriptreact"):fmt("prettier")

require("guard").setup({
	fmt_on_save = true,
	lsp_as_default_formatter = true,
})
