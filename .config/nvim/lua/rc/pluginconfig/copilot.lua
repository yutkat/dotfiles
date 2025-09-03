require("copilot").setup({
	suggestion = {
		auto_trigger = true,
		keymap = {
			accept = "<C-S-y>",
			accept_word = false,
			accept_line = false,
			next = "<C-S-n>",
			prev = "<C-S-p>",
			dismiss = "<C-S-]>",
		},
	},
})

vim.api.nvim_command("highlight link CopilotAnnotation LineNr")
vim.api.nvim_command("highlight link CopilotSuggestion LineNr")

vim.keymap.set("i", "<C-S-e>", function()
  -- Gracefully hide any completion menu if present (blink or cmp), then accept
  pcall(function()
    if package.loaded["blink.cmp"] then require("blink.cmp").hide() end
  end)
  pcall(function()
    if package.loaded["cmp"] then require("cmp").mapping.abort() end
  end)
  require("copilot.suggestion").accept()
end, {
	desc = "[copilot] accept suggestion",
	silent = true,
})
