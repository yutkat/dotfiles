local wezterm = require("wezterm")
local utils = require("utils")
local scheme = wezterm.get_builtin_color_schemes()["nord"]

-- /etc/ssh/sshd_config
-- AcceptEnv TERM_PROGRAM_VERSION COLORTERM TERM TERM_PROGRAM WEZTERM_REMOTE_PANE
-- sudo systemctl reload sshd

---------------------------------------------------------------
--- keybinds
---------------------------------------------------------------
local tmux_keybinds = {
	{ key = "k", mods = "ALT", action = wezterm.action({ SpawnTab = "CurrentPaneDomain" }) },
	{ key = "j", mods = "ALT", action = wezterm.action({ CloseCurrentTab = { confirm = false } }) },
	{ key = "h", mods = "ALT", action = wezterm.action({ ActivateTabRelative = -1 }) },
	{ key = "l", mods = "ALT", action = wezterm.action({ ActivateTabRelative = 1 }) },
	{ key = "h", mods = "ALT|CTRL", action = wezterm.action({ MoveTabRelative = -1 }) },
	{ key = "l", mods = "ALT|CTRL", action = wezterm.action({ MoveTabRelative = 1 }) },
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
	{ key = "\\", mods = "ALT", action = wezterm.action({ SplitHorizontal = { domain = "CurrentPaneDomain" } }) },
	{ key = "h", mods = "ALT|SHIFT", action = wezterm.action({ ActivatePaneDirection = "Left" }) },
	{ key = "l", mods = "ALT|SHIFT", action = wezterm.action({ ActivatePaneDirection = "Right" }) },
	{ key = "k", mods = "ALT|SHIFT", action = wezterm.action({ ActivatePaneDirection = "Up" }) },
	{ key = "j", mods = "ALT|SHIFT", action = wezterm.action({ ActivatePaneDirection = "Down" }) },
	{ key = "h", mods = "ALT|SHIFT|CTRL", action = wezterm.action({ AdjustPaneSize = { "Left", 1 } }) },
	{ key = "l", mods = "ALT|SHIFT|CTRL", action = wezterm.action({ AdjustPaneSize = { "Right", 1 } }) },
	{ key = "k", mods = "ALT|SHIFT|CTRL", action = wezterm.action({ AdjustPaneSize = { "Up", 1 } }) },
	{ key = "j", mods = "ALT|SHIFT|CTRL", action = wezterm.action({ AdjustPaneSize = { "Down", 1 } }) },
	{ key = "Enter", mods = "ALT", action = "QuickSelect" },
}

local default_keybinds = {
	{ key = "c", mods = "CTRL|SHIFT", action = wezterm.action({ CopyTo = "Clipboard" }) },
	{ key = "v", mods = "CTRL|SHIFT", action = wezterm.action({ PasteFrom = "Clipboard" }) },
	{ key = "Insert", mods = "SHIFT", action = wezterm.action({ PasteFrom = "PrimarySelection" }) },
	{ key = "=", mods = "CTRL", action = "ResetFontSize" },
	{ key = "+", mods = "CTRL", action = "IncreaseFontSize" },
	{ key = "-", mods = "CTRL", action = "DecreaseFontSize" },
	{ key = "x", mods = "CTRL|SHIFT", action = "ActivateCopyMode" },
	{ key = "PageUp", mods = "ALT", action = wezterm.action({ ScrollByPage = -1 }) },
	{ key = "PageDown", mods = "ALT", action = wezterm.action({ ScrollByPage = 1 }) },
	{ key = "z", mods = "ALT", action = "ReloadConfiguration" },
	{ key = "z", mods = "ALT|SHIFT", action = wezterm.action({ EmitEvent = "toggle-tmux-keybinds" }) },
	{ key = "e", mods = "ALT", action = wezterm.action({ EmitEvent = "trigger-nvim-with-scrollback" }) },
	{ key = "q", mods = "ALT", action = wezterm.action({ CloseCurrentPane = { confirm = false } }) },
	{ key = "x", mods = "ALT", action = wezterm.action({ CloseCurrentPane = { confirm = false } }) },
	{
		key = "r",
		mods = "ALT",
		action = wezterm.action({
			ActivateKeyTable = {
				name = "resize_pane",
				one_shot = false,
				timeout_milliseconds = 3000,
				replace_current = false,
			},
		}),
	},
}

local function create_keybinds()
	return utils.merge_lists(default_keybinds, tmux_keybinds)
end

---------------------------------------------------------------
--- functions
---------------------------------------------------------------
local function enable_wayland()
	local wayland = os.getenv("XDG_SESSION_TYPE")
	if wayland == "wayland" then
		return true
	end
	return false
end

local function create_tab_title(tab, tabs, panes, config, hover, max_width)
	local user_title = tab.active_pane.user_vars.panetitle
	if user_title ~= nil and #user_title > 0 then
		return tab.tab_index + 1 .. ":" .. user_title
	end

	local title = wezterm.truncate_right(utils.basename(tab.active_pane.foreground_process_name), max_width)
	if title == "" then
		local dir = string.gsub(tab.active_pane.title, "(.*[: ])(.*)]", "%2")
		dir = utils.convert_useful_path(dir)
		title = wezterm.truncate_right(dir, max_width)
	end

	local copy_mode, n = string.gsub(tab.active_pane.title, "(.+) mode: .*", "%1", 1)
	if copy_mode == nil or n == 0 then
		copy_mode = ""
	else
		copy_mode = copy_mode .. " :"
	end
	return copy_mode .. tab.tab_index + 1 .. ":" .. title
end

---------------------------------------------------------------
--- wezterm on
---------------------------------------------------------------
wezterm.on("format-tab-title", function(tab, tabs, panes, config, hover, max_width)
	local title = create_tab_title(tab, tabs, panes, config, hover, max_width)

	local SOLID_LEFT_ARROW = utf8.char(0x2590)
	local SOLID_RIGHT_ARROW = utf8.char(0x258c)
	local edge_background = scheme.background
	local background = scheme.ansi[1]
	local foreground = scheme.brights[5]

	if tab.is_active then
		background = scheme.brights[1]
		foreground = scheme.brights[8]
	elseif hover then
		background = scheme.foreground
		foreground = scheme.ansi[1]
	end
	local edge_foreground = background

	return {
		{ Attribute = { Intensity = "Bold" } },
		{ Background = { Color = edge_background } },
		{ Foreground = { Color = edge_foreground } },
		{ Text = SOLID_LEFT_ARROW },
		{ Background = { Color = background } },
		{ Foreground = { Color = foreground } },
		{ Text = title },
		{ Background = { Color = edge_background } },
		{ Foreground = { Color = edge_foreground } },
		{ Text = SOLID_RIGHT_ARROW },
		{ Attribute = { Intensity = "Normal" } },
	}
end)

-- https://github.com/wez/wezterm/issues/1680
local function update_window_background(window, pane)
	local overrides = window:get_config_overrides() or {}
	-- If there's no foreground process, assume that we are "wezterm connect" or "wezterm ssh"
	-- and use a different background color
	-- if pane:get_foreground_process_name() == nil then
	-- 	-- overrides.colors = { background = "blue" }
	-- 	overrides.color_scheme = "Red Alert"
	-- end

	if overrides.color_scheme == nil then
		return
	end
	if pane:get_user_vars().production == "1" then
		overrides.color_scheme = "OneHalfDark"
	end
	window:set_config_overrides(overrides)
end

local function update_tmux_style_tab(window, pane)
	local cwd_uri = pane:get_current_working_dir()
	local hostname, cwd = utils.split_from_url(cwd_uri)
	return {
		{ Attribute = { Underline = "Single" } },
		{ Attribute = { Italic = true } },
		{ Text = hostname },
	}
end

local function update_ssh_status(window, pane)
	local text = pane:get_domain_name()
	if text == "local" then
		text = ""
	end
	return {
		{ Attribute = { Underline = "Single" } },
		{ Attribute = { Italic = true } },
		{ Text = text .. " " },
	}
end

local function display_ime_on_right_status(window, pane)
	local compose = window:composition_status()
	if compose then
		compose = "COMPOSING: " .. compose
	end
	window:set_right_status(compose)
end

local function display_copy_mode(window, pane)
	local name = window:active_key_table()
	if name then
		name = "Mode: " .. name
	end
	return { { Attribute = { Italic = false } }, { Text = name or "" } }
end

wezterm.on("update-right-status", function(window, pane)
	-- local tmux = update_tmux_style_tab(window, pane)
	local ssh = update_ssh_status(window, pane)
	local copy_mode = display_copy_mode(window, pane)
	update_window_background(window, pane)
	local status = utils.merge_lists(ssh, copy_mode)
	window:set_right_status(wezterm.format(status))
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

local io = require("io")
local os = require("os")

wezterm.on("trigger-nvim-with-scrollback", function(window, pane)
	local scrollback = pane:get_lines_as_text()
	local name = os.tmpname()
	local f = io.open(name, "w+")
	f:write(scrollback)
	f:flush()
	f:close()
	window:perform_action(
		wezterm.action({
			SpawnCommandInNewTab = {
				args = { os.getenv("HOME") .. "/.local/share/zsh/zinit/polaris/bin/nvim", name },
			},
		}),
		pane
	)
	wezterm.sleep_ms(1000)
	os.remove(name)
end)

---------------------------------------------------------------
--- SSH config integration
---------------------------------------------------------------
local function insert_ssh_domain_from_ssh_config(c)
	for host, config in pairs(wezterm.enumerate_ssh_hosts()) do
		table.insert(c.ssh_domains, {
			name = host,
			remote_address = config.hostname .. ":" .. config.port,
			username = config.user,
			multiplexing = "None",
			assume_shell = "Posix",
		})
	end
	return c
end

---------------------------------------------------------------
--- load local_config
---------------------------------------------------------------
-- Write settings you don't want to make public, such as ssh_domains
package.path = os.getenv("HOME") .. "/.local/share/wezterm/?.lua;" .. package.path
local function load_local_config(module)
	local m = package.searchpath(module, package.path)
	if m == nil then
		return {}
	end
	return dofile(m)
	-- local ok, _ = pcall(require, "local")
	-- if not ok then
	-- 	return {}
	-- end
	-- return require("local")
end
local local_config = load_local_config("local")

-- local local_config = {
-- 	ssh_domains = {
-- 		{
-- 			-- This name identifies the domain
-- 			name = "my.server",
-- 			-- The address to connect to
-- 			remote_address = "192.168.8.31",
-- 			-- The username to use on the remote host
-- 			username = "katayama",
-- 		},
-- 	},
-- }
-- return local_config

---------------------------------------------------------------
--- Config
---------------------------------------------------------------
local config = {
	-- font = wezterm.font("Cica"),
	-- font_size = 10.0,
	font = wezterm.font("UDEV Gothic 35NFLG"),
	font_size = 9.0,
	-- font_rules = {
	-- 	{
	-- 		italic = true,
	-- 		font = wezterm.font("Cica", { italic = true }),
	-- 	},
	-- 	{
	-- 		italic = true,
	-- 		intensity = "Bold",
	-- 		font = wezterm.font("Cica", { weight = "Bold", italic = true }),
	-- 	},
	-- },
	check_for_updates = false,
	use_ime = true,
	-- ime_preedit_rendering = "System",
	-- use_dead_keys = true,
	warn_about_missing_glyphs = false,
	-- enable_kitty_graphics = false,
	animation_fps = 10,
	cursor_blink_rate = 0,
	-- enable_wayland = enable_wayland(),
	color_scheme = "nordfox",
	color_scheme_dirs = { "$HOME/.config/wezterm/colors/" },
	hide_tab_bar_if_only_one_tab = false,
	adjust_window_size_when_changing_font_size = false,
	selection_word_boundary = " \t\n{}[]()\"'`,;:│=&!%",
	window_padding = {
		left = 5,
		right = 5,
		top = 0,
		bottom = 0,
	},
	use_fancy_tab_bar = false,
	colors = {
		tab_bar = {
			background = scheme.background,
			new_tab = { bg_color = scheme.background, fg_color = scheme.ansi[8], intensity = "Bold" },
			new_tab_hover = { bg_color = scheme.ansi[1], fg_color = scheme.brights[8], intensity = "Bold" },
			-- format-tab-title
			-- active_tab = { bg_color = "#121212", fg_color = "#FCE8C3" },
			-- inactive_tab = { bg_color = scheme.background, fg_color = "#FCE8C3" },
			-- inactive_tab_hover = { bg_color = scheme.ansi[1], fg_color = "#FCE8C3" },
		},
	},
	tab_bar_at_bottom = false,
	-- window_background_opacity = 0.8,
	disable_default_key_bindings = true,
	-- visual_bell = {
	-- 	fade_in_function = "EaseIn",
	-- 	fade_in_duration_ms = 150,
	-- 	fade_out_function = "EaseOut",
	-- 	fade_out_duration_ms = 150,
	-- },
	-- separate <Tab> <C-i>
	enable_csi_u_key_encoding = true,
	leader = { key = "Space", mods = "CTRL|SHIFT" },
	keys = create_keybinds(),
	key_tables = {
		resize_pane = {
			{ key = "LeftArrow", action = wezterm.action({ AdjustPaneSize = { "Left", 1 } }) },
			{ key = "h", action = wezterm.action({ AdjustPaneSize = { "Left", 1 } }) },
			{ key = "RightArrow", action = wezterm.action({ AdjustPaneSize = { "Right", 1 } }) },
			{ key = "l", action = wezterm.action({ AdjustPaneSize = { "Right", 1 } }) },
			{ key = "UpArrow", action = wezterm.action({ AdjustPaneSize = { "Up", 1 } }) },
			{ key = "k", action = wezterm.action({ AdjustPaneSize = { "Up", 1 } }) },
			{ key = "DownArrow", action = wezterm.action({ AdjustPaneSize = { "Down", 1 } }) },
			{ key = "j", action = wezterm.action({ AdjustPaneSize = { "Down", 1 } }) },
			-- Cancel the mode by pressing escape
			{ key = "Escape", action = "PopKeyTable" },
		},
		copy_mode = {
			{ key = "Escape", mods = "NONE", action = wezterm.action({ CopyMode = "Close" }) },
			{ key = "q", mods = "NONE", action = wezterm.action({ CopyMode = "Close" }) },
			-- move cursor
			{ key = "h", mods = "NONE", action = wezterm.action({ CopyMode = "MoveLeft" }) },
			{ key = "LeftArrow", mods = "NONE", action = wezterm.action({ CopyMode = "MoveLeft" }) },
			{ key = "j", mods = "NONE", action = wezterm.action({ CopyMode = "MoveDown" }) },
			{ key = "DownArrow", mods = "NONE", action = wezterm.action({ CopyMode = "MoveDown" }) },
			{ key = "k", mods = "NONE", action = wezterm.action({ CopyMode = "MoveUp" }) },
			{ key = "UpArrow", mods = "NONE", action = wezterm.action({ CopyMode = "MoveUp" }) },
			{ key = "l", mods = "NONE", action = wezterm.action({ CopyMode = "MoveRight" }) },
			{ key = "RightArrow", mods = "NONE", action = wezterm.action({ CopyMode = "MoveRight" }) },
			-- move word
			{ key = "RightArrow", mods = "ALT", action = wezterm.action({ CopyMode = "MoveForwardWord" }) },
			{ key = "f", mods = "ALT", action = wezterm.action({ CopyMode = "MoveForwardWord" }) },
			{ key = "\t", mods = "NONE", action = wezterm.action({ CopyMode = "MoveForwardWord" }) },
			{ key = "w", mods = "NONE", action = wezterm.action({ CopyMode = "MoveForwardWord" }) },
			{ key = "LeftArrow", mods = "ALT", action = wezterm.action({ CopyMode = "MoveBackwardWord" }) },
			{ key = "b", mods = "ALT", action = wezterm.action({ CopyMode = "MoveBackwardWord" }) },
			{ key = "\t", mods = "SHIFT", action = wezterm.action({ CopyMode = "MoveBackwardWord" }) },
			{ key = "b", mods = "NONE", action = wezterm.action({ CopyMode = "MoveBackwardWord" }) },
			{
				key = "e",
				mods = "NONE",
				action = wezterm.action({
					Multiple = {
						wezterm.action({ CopyMode = "MoveRight" }),
						wezterm.action({ CopyMode = "MoveForwardWord" }),
						wezterm.action({ CopyMode = "MoveLeft" }),
					},
				}),
			},
			-- move start/end
			{ key = "0", mods = "NONE", action = wezterm.action({ CopyMode = "MoveToStartOfLine" }) },
			{ key = "\n", mods = "NONE", action = wezterm.action({ CopyMode = "MoveToStartOfNextLine" }) },
			{ key = "$", mods = "SHIFT", action = wezterm.action({ CopyMode = "MoveToEndOfLineContent" }) },
			{ key = "$", mods = "NONE", action = wezterm.action({ CopyMode = "MoveToEndOfLineContent" }) },
			{ key = "e", mods = "CTRL", action = wezterm.action({ CopyMode = "MoveToEndOfLineContent" }) },
			{ key = "m", mods = "ALT", action = wezterm.action({ CopyMode = "MoveToStartOfLineContent" }) },
			{ key = "^", mods = "SHIFT", action = wezterm.action({ CopyMode = "MoveToStartOfLineContent" }) },
			{ key = "^", mods = "NONE", action = wezterm.action({ CopyMode = "MoveToStartOfLineContent" }) },
			{ key = "a", mods = "CTRL", action = wezterm.action({ CopyMode = "MoveToStartOfLineContent" }) },
			-- select
			{ key = " ", mods = "NONE", action = wezterm.action({ CopyMode = { SetSelectionMode = "Cell" } }) },
			{ key = "v", mods = "NONE", action = wezterm.action({ CopyMode = { SetSelectionMode = "Cell" } }) },
			{
				key = "v",
				mods = "SHIFT",
				action = wezterm.action({
					Multiple = {
						wezterm.action({ CopyMode = "MoveToStartOfLineContent" }),
						wezterm.action({ CopyMode = { SetSelectionMode = "Cell" } }),
						wezterm.action({ CopyMode = "MoveToEndOfLineContent" }),
					},
				}),
			},
			-- copy
			{
				key = "y",
				mods = "NONE",
				action = wezterm.action({
					Multiple = {
						wezterm.action({ CopyTo = "ClipboardAndPrimarySelection" }),
						wezterm.action({ CopyMode = "Close" }),
					},
				}),
			},
			{
				key = "y",
				mods = "SHIFT",
				action = wezterm.action({
					Multiple = {
						wezterm.action({ CopyMode = { SetSelectionMode = "Cell" } }),
						wezterm.action({ CopyMode = "MoveToEndOfLineContent" }),
						wezterm.action({ CopyTo = "ClipboardAndPrimarySelection" }),
						wezterm.action({ CopyMode = "Close" }),
					},
				}),
			},
			-- scroll
			{ key = "G", mods = "SHIFT", action = wezterm.action({ CopyMode = "MoveToScrollbackBottom" }) },
			{ key = "G", mods = "NONE", action = wezterm.action({ CopyMode = "MoveToScrollbackBottom" }) },
			{ key = "g", mods = "NONE", action = wezterm.action({ CopyMode = "MoveToScrollbackTop" }) },
			{ key = "H", mods = "NONE", action = wezterm.action({ CopyMode = "MoveToViewportTop" }) },
			{ key = "H", mods = "SHIFT", action = wezterm.action({ CopyMode = "MoveToViewportTop" }) },
			{ key = "M", mods = "NONE", action = wezterm.action({ CopyMode = "MoveToViewportMiddle" }) },
			{ key = "M", mods = "SHIFT", action = wezterm.action({ CopyMode = "MoveToViewportMiddle" }) },
			{ key = "L", mods = "NONE", action = wezterm.action({ CopyMode = "MoveToViewportBottom" }) },
			{ key = "L", mods = "SHIFT", action = wezterm.action({ CopyMode = "MoveToViewportBottom" }) },
			{ key = "PageUp", mods = "NONE", action = wezterm.action({ CopyMode = "PageUp" }) },
			{ key = "PageDown", mods = "NONE", action = wezterm.action({ CopyMode = "PageDown" }) },
			{ key = "b", mods = "CTRL", action = wezterm.action({ CopyMode = "PageUp" }) },
			{ key = "f", mods = "CTRL", action = wezterm.action({ CopyMode = "PageDown" }) },
			-- search
			{ key = "/", mods = "NONE", action = wezterm.action({ Search = { CaseSensitiveString = "" } }) },
			{ key = "n", mods = "NONE", action = wezterm.action({ CopyMode = "NextMatch" }) },
			{ key = "N", mods = "SHIFT", action = wezterm.action({ CopyMode = "PriorMatch" }) },
		},
		search_mode = {
			{ key = "Escape", mods = "NONE", action = wezterm.action({ CopyMode = "Close" }) },
			{ key = "Enter", mods = "NONE", action = "ActivateCopyMode" },
			{ key = "r", mods = "CTRL", action = wezterm.action({ CopyMode = "CycleMatchType" }) },
			{ key = "/", mods = "NONE", action = wezterm.action({ CopyMode = "ClearPattern" }) },
		},
	},
	mouse_bindings = {
		{
			event = { Up = { streak = 1, button = "Left" } },
			mods = "NONE",
			action = wezterm.action({ CompleteSelection = "PrimarySelection" }),
		},
		{
			event = { Up = { streak = 1, button = "Right" } },
			mods = "NONE",
			action = wezterm.action({ CompleteSelection = "Clipboard" }),
		},
		{
			event = { Up = { streak = 1, button = "Left" } },
			mods = "CTRL",
			action = "OpenLinkAtMouseCursor",
		},
	},
}

local merged_config = utils.merge_tables(config, local_config)
return insert_ssh_domain_from_ssh_config(merged_config)
