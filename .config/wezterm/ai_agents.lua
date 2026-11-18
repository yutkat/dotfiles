local wezterm = require("wezterm")

-- Shared instance: on.lua and keybinds.lua both require this, so setup runs once and there is one
-- state table and one update-status handler.
local agents = wezterm.plugin.require("https://github.com/yutkat/ai-agents.wezterm")

agents.setup({
	backgrounds = { claude = "#3b332e", codex = "#2d3838" },
})

return agents
