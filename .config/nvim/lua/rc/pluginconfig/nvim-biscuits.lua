require("nvim-biscuits").setup({
	default_config = { max_length = 12, min_destance = 5, prefix_string = " 📎 " },
	language_config = {
		html = { prefix_string = " 🌐 " },
		javascript = { prefix_string = " ✨ ", max_length = 80 },
	},
})
