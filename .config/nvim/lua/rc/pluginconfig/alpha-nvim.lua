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

dashboard.section.header.val =
	vim.fn.readfile(vim.fs.normalize("~/.config/nvim/lua/rc/files/dashboard_custom_header.txt"))
dashboard.section.footer.val = "Total plugins: " .. require("lazy").stats().count
dashboard.section.header.opts.hl = "Question"
dashboard.section.buttons.val = {
	dashboard.button("s", " Open last session", ":PossessionLoadCurrent<CR>"),
	dashboard.button("h", "  Recently opened files", ":Telescope my_mru<CR>"),
	dashboard.button("f", " Find file", ":Telescope find_files<CR>"),
	dashboard.button("e", " New file", ":enew<CR>"),
	dashboard.button("b", " Jump to bookmarks", ":Telescope marks<CR>"),
	dashboard.button("n", " Memo New", ":Telekasten new_note<CR>"),
	dashboard.button("t", " Memo Today", ":Telekasten goto_today<CR>"),
	dashboard.button("w", " Memo Week", ":Telekasten goto_thisweek<CR>"),
	dashboard.button("m", " Memo List", ":Telekasten find_notes<CR>"),
	dashboard.button("p", " Update plugins", ":Lazy sync<CR>"),
	dashboard.button("q", " Exit", ":qa<CR>"),
}
alpha.setup(dashboard.config)

vim.api.nvim_create_augroup("vimrc_alpha", { clear = true })
vim.api.nvim_create_autocmd({ "User" }, {
	group = "vimrc_alpha",
	pattern = "AlphaReady",
	callback = function()
		if vim.fn.executable("onefetch") == 1 then
			local header = split(
				capture(
					[[onefetch 2>/dev/null | sed 's/\x1B[@A-Z\\\]^_]\|\x1B\[[0-9:;<=>?]*[-!"#$%&'"'"'()*+,.\/]*[][\\@A-Z^_`a-z{|}~]//g']],
					true
				),
				"\n"
			)
			if next(header) ~= nil then
				require("alpha.themes.dashboard").section.header.val = header
				require("alpha").redraw()
			end
		end
	end,
	once = true,
})
