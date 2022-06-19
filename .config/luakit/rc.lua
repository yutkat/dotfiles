-- Add download support
require("downloads")
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
