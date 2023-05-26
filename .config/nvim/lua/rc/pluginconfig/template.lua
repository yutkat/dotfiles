vim.filetype.add({ filename = { ["bash.sh"] = "sh" } })

require("template").setup({
	temp_dir = vim.fn.stdpath("config") .. "/template/",
})
