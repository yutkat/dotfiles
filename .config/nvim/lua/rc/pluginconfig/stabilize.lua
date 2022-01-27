require("stabilize").setup({
	force = true,
	forcemark = nil,
	ignore = {
		filetype = { "help", "list", "Trouble", "packer" },
		buftype = { "terminal", "quickfix", "loclist", "nofile" },
	},
})
