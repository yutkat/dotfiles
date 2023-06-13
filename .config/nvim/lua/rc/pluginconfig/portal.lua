require("portal").setup({ select_first = true })

vim.keymap.set("n", "<C-a>", function()
	require("portal.builtin").jumplist.tunnel_backward({
		max_results = 1,
		filter = function(v)
			return v.buffer == vim.api.nvim_get_current_buf()
		end,
	})
end)
vim.keymap.set("n", "<C-g>", function()
	require("portal.builtin").jumplist.tunnel_forward({
		max_results = 1,
		filter = function(v)
			return v.buffer == vim.api.nvim_get_current_buf()
		end,
	})
end)

local group_name = "vimrc_portal"
vim.api.nvim_create_augroup(group_name, { clear = true })
vim.api.nvim_create_autocmd(
	{ "BufAdd", "InsertLeave", "BufWinEnter", "TextYankPost", "TextChanged", "CmdlineLeave", "CursorHold" },
	{
		group = group_name,
		pattern = "*",
		callback = function()
			vim.cmd.normal({ "m'", bang = true })
		end,
		once = false,
	}
)
