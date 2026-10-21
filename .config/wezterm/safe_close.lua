local wezterm = require("wezterm")
local act = wezterm.action
local utils = require("utils")

local M = {}

-- Closing a pane while a coding agent runs kills it with SIGHUP mid-turn (a tool call or file edit
-- can be cut off) and has left the shell that started it orphaned. Send its exit command first,
-- wait for it to quit, then close as before.
-- Set to false to make the keys close exactly as before (e.g. to reproduce the orphaned-nu hang
-- in .config/nushell/autoload/hangup.nu).
local ENABLED = true
local EXIT_TIMEOUT_MS = 5000
local POLL_MS = 100
local INTERPRETERS = { node = true, bun = true }
-- process name -> slash command that exits it
local AGENTS = { claude = "/exit", codex = "/quit" }

local function stem(path)
	if path == nil then
		return nil
	end
	return (utils.basename(path):gsub("%.%w+$", ""))
end

-- Returns the agent's exit command, or nil. Matches comm and argv[0] (the resolved executable of a
-- versioned install is a version number), plus the script name when argv[0] is an interpreter
-- (npm's codex is `node .../codex.js`).
local function agent_exit_command(pane)
	local ok, info = pcall(function()
		return pane:get_foreground_process_info()
	end)
	if not ok or info == nil then
		return nil
	end
	local argv = info.argv or {}
	local names = { stem(info.name), stem(argv[1]) }
	if argv[1] ~= nil and INTERPRETERS[stem(argv[1])] then
		table.insert(names, stem(argv[2]))
	end
	for _, name in pairs(names) do
		if AGENTS[name] then
			return AGENTS[name]
		end
	end
	return nil
end

local function request_exit(window, pane, command)
	-- Ctrl+C clears typed input or interrupts a running turn; typed text sent too fast reads as a
	-- paste, so Enter follows separately.
	window:perform_action(act.SendKey({ key = "c", mods = "CTRL" }), pane)
	wezterm.sleep_ms(300)
	window:perform_action(act.SendString(command), pane)
	wezterm.sleep_ms(200)
	window:perform_action(act.SendKey({ key = "Enter" }), pane)
end

local function exit_agent_panes(window, panes)
	if not ENABLED then
		return
	end
	local pending = {}
	for _, p in ipairs(panes) do
		local command = agent_exit_command(p)
		if command then
			request_exit(window, p, command)
			table.insert(pending, p)
		end
	end
	local waited = 0
	while #pending > 0 and waited < EXIT_TIMEOUT_MS do
		wezterm.sleep_ms(POLL_MS)
		waited = waited + POLL_MS
		local still = {}
		for _, p in ipairs(pending) do
			if agent_exit_command(p) then
				table.insert(still, p)
			end
		end
		pending = still
	end
end

M.close_tab = wezterm.action_callback(function(window, pane)
	exit_agent_panes(window, pane:tab():panes())
	window:perform_action(act.CloseCurrentTab({ confirm = true }), pane)
end)

M.close_pane = wezterm.action_callback(function(window, pane)
	exit_agent_panes(window, { pane })
	window:perform_action(act.CloseCurrentPane({ confirm = true }), pane)
end)

return M
