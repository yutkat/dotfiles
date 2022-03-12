local alpha = require("alpha")
local dashboard = require("alpha.themes.dashboard")

local function capture(cmd, raw)
	local f = assert(io.popen(cmd, "r"))
	local s = assert(f:read("*a"))
	f:close()
	if raw then
		return s
	end
	s = string.gsub(s, "^%s+", "")
	s = string.gsub(s, "%s+$", "")
	s = string.gsub(s, "[\n\r]+", " ")
	return s
end

local function split(source, sep)
	local result, i = {}, 1
	while true do
		local a, b = source:find(sep)
		if not a then
			break
		end
		local candidat = source:sub(1, a - 1)
		if candidat ~= "" then
			result[i] = candidat
		end
		i = i + 1
		source = source:sub(b + 1)
	end
	if source ~= "" then
		result[i] = source
	end
	return result
end

local header = nil
if vim.fn.executable("onefetch") == 1 then
	header = split(capture("onefetch 2> /dev/null", true), "\n")
end
if next(header) == nil then
	header = vim.fn.readfile(vim.fn.expand("~/.config/nvim/lua/rc/files/dashboard_custom_header.txt"))
end
dashboard.section.header.val = header
dashboard.section.header.opts.hl = "Question"
-- dashboard.section.header.val = vim.fn.readfile(vim.fn.expand("~/.config/nvim/lua/rc/files/dashboard_custom_header.txt"))
dashboard.section.buttons.val = {
	dashboard.button("s", " Open last session", ":RestoreSession<CR>"),
	dashboard.button("h", " Recently opened files", ":Telescope my_mru<CR>"),
	dashboard.button("f", " Find file", ":Telescope find_files<CR>"),
	dashboard.button("e", " New file", ":enew<CR>"),
	dashboard.button("b", " Jump to bookmarks", ":Telescope marks<CR>"),
	dashboard.button("n", " Memo New", ":Telekasten new_note<CR>"),
	dashboard.button("t", " Memo Today", ":Telekasten goto_today<CR>"),
	dashboard.button("w", " Memo Week", ":Telekasten goto_thisweek<CR>"),
	dashboard.button("m", " Memo List", ":Telekasten find_notes<CR>"),
}
alpha.setup(dashboard.config)
