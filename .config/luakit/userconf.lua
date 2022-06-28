local modes = require("modes")

modes.remap_binds("normal", {
	{ "<Alt-h>", "<control-o>", true },
})
modes.remap_binds("normal", {
	{ "<Alt-l>", "<control-i>", true },
})
modes.remap_binds("normal", {
	{ "H", "gT", true },
})
modes.remap_binds("normal", {
	{ "L", "gt", true },
})

----------------------------------
-- Settings
----------------------------------
local settings = require("settings")
settings.webview.enable_smooth_scrolling = true
-- settings.window.home_page = "www.google.com"
local engines = settings.window.search_engines
engines.aur = "https://aur.archlinux.org/packages?O=0&K=%s"
engines.aw = "https://wiki.archlinux.org/index.php/Special:Search?fulltext=Search&search=%s"
engines.google = "https://www.google.com/search?name=f&hl=en&q=%s"

local editor = require("editor")
editor.editor_cmd = "wezterm start nvim {file} +{line}"

----------------------------------
-- Downloads
----------------------------------
-- Add download support
local downloads = require("downloads")
require("downloads_chrome")

-- Set download location
downloads.default_dir = os.getenv("HOME") .. "/Downloads"
downloads.add_signal("download-location", function(uri, file)
	if not file or file == "" then
		file = (
			string.match(uri, "/([^/]+)$")
			or string.match(uri, "^%w+://(.+)")
			or string.gsub(uri, "/", "_")
			or "untitled"
		)
	end
	return downloads.default_dir .. "/" .. file
end)

----------------------------------
-- Optional user script loading --
----------------------------------
require("adblock")
require("adblock_chrome")

local select = require("select")
select.label_maker = function()
	local chars = charset("fjkasdhguonmerwc")
	return trim(sort(reverse(chars)))
end
