require("copilot").setup({
	-- copilot.lua disables markdown by default; enable it (NES/completion in notes)
	filetypes = {
		markdown = true,
	},
	suggestion = {
		enabled = false,
		-- auto_trigger = true,
		-- keymap = {
		-- 	accept = "<C-S-y>",
		-- 	accept_word = false,
		-- 	accept_line = false,
		-- 	next = "<C-S-n>",
		-- 	prev = "<C-S-p>",
		-- 	dismiss = "<C-S-]>",
		-- },
	},
})

vim.api.nvim_command("highlight link CopilotAnnotation LineNr")
vim.api.nvim_command("highlight link CopilotSuggestion LineNr")

-- Let sidekick.nvim handle the Copilot LSP `didChangeStatus` notifications so
-- NES works on copilot.lua's bundled server (single server for completion + NES).
local function hook_sidekick_status(client)
	if client and client.name == "copilot" then
		client.handlers = client.handlers or {}
		client.handlers["didChangeStatus"] = require("sidekick.status").on_status
	end
end
vim.api.nvim_create_autocmd("LspAttach", {
	callback = function(args)
		hook_sidekick_status(vim.lsp.get_client_by_id(args.data.client_id))
	end,
})
for _, c in ipairs(vim.lsp.get_clients({ name = "copilot" })) do
	hook_sidekick_status(c)
end

-- vim.keymap.set("i", "<C-S-e>", function()
--   -- Gracefully hide any completion menu if present (blink or cmp), then accept
--   pcall(function()
--     if package.loaded["blink.cmp"] then require("blink.cmp").hide() end
--   end)
--   pcall(function()
--     if package.loaded["cmp"] then require("cmp").mapping.abort() end
--   end)
--   require("copilot.suggestion").accept()
-- end, {
-- 	desc = "[copilot] accept suggestion",
-- 	silent = true,
-- })
