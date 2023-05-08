vim.api.nvim_set_hl(0, "LeapBackdrop", { link = "Comment" }) -- or some grey
vim.api.nvim_set_hl(0, "LeapMatch", {
	-- For light themes, set to 'black' or similar.
	fg = "white",
	bold = true,
	nocombine = true,
})
-- Of course, specify some nicer shades instead of the default "red" and "blue".
vim.api.nvim_set_hl(0, "LeapLabelPrimary", {
	fg = "red",
	bold = true,
	nocombine = true,
})
vim.api.nvim_set_hl(0, "LeapLabelSecondary", {
	fg = "blue",
	bold = true,
	nocombine = true,
})
-- Try it without this setting first, you might find you don't even miss it.
require("leap").opts.highlight_unlabeled_phase_one_targets = true
require("leap").opts.max_highlighted_traversal_targets = 500
require("leap").opts.case_sensitive = true
require("leap").opts.max_phase_one_targets = 3
require("leap").opts.safe_labels = {}

-- stylua: ignore
require("leap").opts.labels = {
	"a", "b", "c", "d", "e", "f", "g", "h", "i", "j", "k", "l", "m", "n", "o", "p", "q", "r", "s", "t", "u", "v", "w", "x", "y", "z",
	"A", "B", "C", "D", "E", "F", "G", "H", "I", "J", "K", "L", "M", "N", "O", "P", "Q", "R", "S", "T", "U", "V", "W", "X", "Y", "Z",
	"0", "1", "2", "3", "4", "5", "6", "7", "8", "9",
	"!", '"', "#", "$", "%", "&", "'", "(", ")", "*", "+", ",", "-", ".", "/", ":", ";", "<", "=", ">", "?", "@",
}

local function regex_by_word_start(s, start_pos)
	local sub = string.sub(s, start_pos)
	local regex = vim.regex("\\k\\+")
	if regex == nil then
		return nil
	end
	return regex:match_str(sub)
end

local function get_match_positions(targets, line_number)
	local line = vim.api.nvim_buf_get_lines(0, line_number - 1, line_number, false)[1]
	local start_pos = 1

	while true do
		local s, e = regex_by_word_start(line, start_pos)
		if not s then
			break
		end
		s = s + start_pos
		e = e + start_pos
		if s ~= e then
			table.insert(targets, { pos = { line_number, s } })
		end
		start_pos = e + 1
	end

	return targets
end

local function get_backward_words()
	local winid = vim.api.nvim_get_current_win()
	local wininfo = vim.fn.getwininfo(winid)[1]
	local cur_line = vim.fn.line(".")

	-- Get targets.
	local targets = {}
	local lnum = wininfo.topline
	while lnum <= cur_line do
		targets = get_match_positions(targets, lnum)
		lnum = lnum + 1
	end
	-- Sort them by vertical screen distance from cursor.
	local cur_screen_row = vim.fn.screenpos(winid, cur_line, 1)["row"]
	local function screen_rows_from_cur(t)
		local t_screen_row = vim.fn.screenpos(winid, t.pos[1], t.pos[2])["row"]
		return math.abs(cur_screen_row - t_screen_row)
	end
	table.sort(targets, function(t1, t2)
		return screen_rows_from_cur(t1) < screen_rows_from_cur(t2)
	end)

	if #targets >= 1 then
		return targets
	end
end

local function get_forward_words()
	local winid = vim.api.nvim_get_current_win()
	local wininfo = vim.fn.getwininfo(winid)[1]
	local cur_line = vim.fn.line(".")

	-- Get targets.
	local targets = {}
	local lnum = cur_line
	local botline = wininfo.botline
	while lnum <= botline do
		targets = get_match_positions(targets, lnum)
		lnum = lnum + 1
	end
	-- Sort them by vertical screen distance from cursor.
	local cur_screen_row = vim.fn.screenpos(winid, cur_line, 1)["row"]
	local function screen_rows_from_cur(t)
		local t_screen_row = vim.fn.screenpos(winid, t.pos[1], t.pos[2])["row"]
		return math.abs(cur_screen_row - t_screen_row)
	end
	table.sort(targets, function(t1, t2)
		return screen_rows_from_cur(t1) < screen_rows_from_cur(t2)
	end)

	if #targets >= 1 then
		return targets
	end
end

vim.keymap.set({ "n", "x" }, "SS", function()
	require("leap").leap({
		targets = get_backward_words(),
	})
end)

vim.keymap.set({ "n", "x" }, "Ss", function()
	require("leap").leap({
		targets = get_forward_words(),
	})
end)
