-- Diff review (replaces sindrets/diffview.nvim).
-- gitsigns keeps the sign column and hunk actions/navigation (]c/[c, [_Git]h*, ih),
-- so mini.diff only colors line numbers and provides the inline overlay.
local diff = require("mini.diff")
diff.setup({
	view = { style = "number" },
	mappings = {
		apply = "",
		reset = "",
		textobject = "",
		goto_first = "",
		goto_prev = "",
		goto_next = "",
		goto_last = "",
	},
})

vim.keymap.set("n", "[_Git]d", diff.toggle_overlay, { desc = "Toggle diff overlay (buffer)" })
vim.keymap.set("n", "[_Git]D", function()
	require("snacks").picker.git_diff()
end, { desc = "Changed hunks (all files)" })

-- :GitDiff [rev]: changed hunks since rev (like :DiffviewOpen <rev>); no rev = working tree
vim.api.nvim_create_user_command("GitDiff", function(opts)
	require("snacks").picker.git_diff({ base = opts.args ~= "" and opts.args or nil })
end, { nargs = "?", desc = "Changed hunks since a revision" })
