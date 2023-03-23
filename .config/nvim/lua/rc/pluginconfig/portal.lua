require("portal").setup()
--require("portal.builtin").jumplist.tunnel()
-- Open a queried search for the jumplist going backwards (<c-o>)
-- Query for two jumps:
-- 1. A jump that is in the same buffer as the current buffer
-- 2. A jump that is in a buffer that has been modified
-- require("portal.builtin").jumplist.tunnel_backward({
-- 	slots = {
-- 		function(value)
-- 			return value.buffer == vim.fn.bufnr()
-- 		end,
-- 		function(value)
-- 			return vim.api.nvim_buf_get_option(value.buffer, "modified")
-- 		end,
-- 	},
-- })
vim.keymap.set("n", "[_SubLeader]o", function()
	require("portal.builtin").jumplist.tunnel_backward({
		max_results = 1,
		filter = function(v)
			return v.buffer == vim.fn.bufnr()
		end,
	})
end)
vim.keymap.set("n", "[_SubLeader]i", function()
	require("portal.builtin").jumplist.tunnel_forward({
		max_results = 1,
		filter = function(v)
			return v.buffer == vim.fn.bufnr()
		end,
	})
end)
