require("portal").setup({ select_first = true })

vim.keymap.set("n", "<C-a>", function()
	require("portal.builtin").jumplist.tunnel_backward({
		max_results = 1,
		filter = function(v)
			return v.buffer == vim.fn.bufnr()
		end,
	})
end)
vim.keymap.set("n", "<C-g>", function()
	require("portal.builtin").jumplist.tunnel_forward({
		max_results = 1,
		filter = function(v)
			return v.buffer == vim.fn.bufnr()
		end,
	})
end)

local group_name = "vimrc_portal"
vim.api.nvim_create_augroup(group_name, { clear = true })
vim.api.nvim_create_autocmd(
	{ "BufAdd", "BufWinEnter", "ModeChanged", "TextYankPost", "TextChanged", "CmdlineLeave", "CursorHold" },
	{
		group = group_name,
		pattern = "*",
		callback = function()
			vim.cmd("normal! m'")
		end,
		once = false,
	}
)
