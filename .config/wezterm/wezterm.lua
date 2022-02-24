local wezterm = require("wezterm")
local utils = require("utils")

---------------------------------------------------------------
--- keybinds
---------------------------------------------------------------
local tmux_keybinds = {
	{ key = "k", mods = "ALT", action = wezterm.action({ SpawnTab = "CurrentPaneDomain" }) },
	{ key = "j", mods = "ALT", action = wezterm.action({ CloseCurrentTab = { confirm = false } }) },
	{ key = "h", mods = "ALT", action = wezterm.action({ ActivateTabRelative = -1 }) },
	{ key = "l", mods = "ALT", action = wezterm.action({ ActivateTabRelative = 1 }) },
	{ key = "h", mods = "ALT|CTRL", action = wezterm.action({ MoveTabRelative = -1 }) },
	{ key = "l", mods = "ALT|CTRL", action = wezterm.action({ ActivateTabRelative = 1 }) },
	{ key = "k", mods = "ALT|CTRL", action = "ActivateCopyMode" },
	{ key = "j", mods = "ALT|CTRL", action = wezterm.action({ PasteFrom = "PrimarySelection" }) },
	{ key = "1", mods = "ALT", action = wezterm.action({ ActivateTab = 0 }) },
	{ key = "2", mods = "ALT", action = wezterm.action({ ActivateTab = 1 }) },
	{ key = "3", mods = "ALT", action = wezterm.action({ ActivateTab = 2 }) },
	{ key = "4", mods = "ALT", action = wezterm.action({ ActivateTab = 3 }) },
	{ key = "5", mods = "ALT", action = wezterm.action({ ActivateTab = 4 }) },
	{ key = "6", mods = "ALT", action = wezterm.action({ ActivateTab = 5 }) },
	{ key = "7", mods = "ALT", action = wezterm.action({ ActivateTab = 6 }) },
	{ key = "8", mods = "ALT", action = wezterm.action({ ActivateTab = 7 }) },
	{ key = "9", mods = "ALT", action = wezterm.action({ ActivateTab = 8 }) },
	{ key = "-", mods = "ALT", action = wezterm.action({ SplitVertical = { domain = "CurrentPaneDomain" } }) },
	{ key = "=", mods = "ALT", action = wezterm.action({ SplitHorizontal = { domain = "CurrentPaneDomain" } }) },
	{ key = "h", mods = "ALT|SHIFT", action = wezterm.action({ ActivatePaneDirection = "Left" }) },
	{ key = "l", mods = "ALT|SHIFT", action = wezterm.action({ ActivatePaneDirection = "Right" }) },
	{ key = "k", mods = "ALT|SHIFT", action = wezterm.action({ ActivatePaneDirection = "Up" }) },
	{ key = "j", mods = "ALT|SHIFT", action = wezterm.action({ ActivatePaneDirection = "Down" }) },
	{ key = "h", mods = "ALT|SHIFT|CTRL", action = wezterm.action({ AdjustPaneSize = { "Left", 1 } }) },
	{ key = "l", mods = "ALT|SHIFT|CTRL", action = wezterm.action({ AdjustPaneSize = { "Right", 1 } }) },
	{ key = "k", mods = "ALT|SHIFT|CTRL", action = wezterm.action({ AdjustPaneSize = { "Up", 1 } }) },
	{ key = "j", mods = "ALT|SHIFT|CTRL", action = wezterm.action({ AdjustPaneSize = { "Down", 1 } }) },
	{ key = " ", mods = "ALT", action = "QuickSelect" },
}

local default_keybinds = {
	{ key = "c", mods = "CTRL|SHIFT", action = wezterm.action({ CopyTo = "Clipboard" }) },
	{ key = "v", mods = "CTRL|SHIFT", action = wezterm.action({ PasteFrom = "Clipboard" }) },
	{ key = "Insert", mods = "SHIFT", action = wezterm.action({ PasteFrom = "PrimarySelection" }) },
	{ key = "=", mods = "CTRL", action = "ResetFontSize" },
	{ key = "+", mods = "CTRL", action = "IncreaseFontSize" },
	{ key = "-", mods = "CTRL", action = "DecreaseFontSize" },
	{ key = " ", mods = "CTRL|SHIFT", action = "QuickSelect" },
	{ key = "x", mods = "CTRL|SHIFT", action = "ActivateCopyMode" },
	{ key = "PageUp", mods = "ALT", action = wezterm.action({ ScrollByPage = -1 }) },
	{ key = "PageDown", mods = "ALT", action = wezterm.action({ ScrollByPage = 1 }) },
	{ key = "r", mods = "ALT", action = "ReloadConfiguration" },
	{ key = "r", mods = "ALT|SHIFT", action = wezterm.action({ EmitEvent = "toggle-tmux-keybinds" }) },
}

local function create_keybinds()
	return utils.merge_lists(default_keybinds, tmux_keybinds)
end

---------------------------------------------------------------
--- wezterm on
---------------------------------------------------------------
wezterm.on("format-tab-title", function(tab, tabs, panes, config, hover, max_width)
	local title = wezterm.truncate_right(utils.basename(tab.active_pane.foreground_process_name), max_width)
	return {
		{ Text = title },
	}
end)

wezterm.on("toggle-tmux-keybinds", function(window, pane)
	local overrides = window:get_config_overrides() or {}
	if not overrides.window_background_opacity then
		overrides.window_background_opacity = 0.95
		overrides.keys = default_keybinds
	else
		overrides.window_background_opacity = nil
		overrides.keys = utils.merge_lists(default_keybinds, tmux_keybinds)
	end
	window:set_config_overrides(overrides)
end)

---------------------------------------------------------------
--- load local_config
---------------------------------------------------------------
-- Write settings you don't want to make public, such as ssh_domains
local function load_local_config()
	local ok, _ = pcall(require, "./local")
	if not ok then
		return {}
	end
	require("./local").setup()
end
local local_config = load_local_config()

---------------------------------------------------------------
--- Config
---------------------------------------------------------------
local config = {
	font = wezterm.font("Cica"),
	use_ime = true,
	font_size = 10.0,
	color_scheme = "nordfox",
	color_scheme_dirs = { "$HOME/.config/wezterm/colors/" },
	hide_tab_bar_if_only_one_tab = true,
	adjust_window_size_when_changing_font_size = false,
	selection_word_boundary = " \t\n{}[]()\"'`,;:",
	window_padding = {
		left = 5,
		right = 5,
		top = 0,
		bottom = 0,
	},
	tab_bar_at_bottom = true,
	disable_default_key_bindings = true,
	keys = create_keybinds(),
}

return utils.merge_tables(config, local_config)
