local hipatterns = require("mini.hipatterns")
hipatterns.setup({})

-- Color palette for interesting-word marking (interestingwords.nvim defaults: pastel bg + dark fg)
local palette = {
	"#8CCBEA",
	"#A4E57E",
	"#FFDB72",
	"#FF7272",
	"#FFB3FF",
	"#9999FF",
}
for i, color in ipairs(palette) do
	vim.api.nvim_set_hl(0, "MiniHipatternsIW" .. i, { bg = color, fg = "#000000" })
end

local marked = {} -- key -> true
local next_color = 1

local function escape_pattern(s)
	return (s:gsub("[%(%)%.%%%+%-%*%?%[%]%^%$]", "%%%1"))
end

local function refresh()
	-- Force a clean recompute against the current global highlighters.
	-- (update() only works on already-enabled buffers; disable+enable is reliable
	-- and enable() re-highlights immediately.)
	for _, buf in ipairs(vim.api.nvim_list_bufs()) do
		if vim.api.nvim_buf_is_loaded(buf) and vim.bo[buf].buflisted then
			pcall(hipatterns.disable, buf)
			pcall(hipatterns.enable, buf)
		end
	end
end

local function toggle(text, whole_word)
	if not text or text == "" then
		return
	end
	local key = "iw_" .. text
	if marked[key] then
		hipatterns.config.highlighters[key] = nil
		marked[key] = nil
	else
		local group = "MiniHipatternsIW" .. next_color
		next_color = (next_color % #palette) + 1
		local pat = escape_pattern(text)
		if whole_word then
			pat = "%f[%w_]" .. pat .. "%f[^%w_]"
		end
		hipatterns.config.highlighters[key] = { pattern = pat, group = group }
		marked[key] = true
	end
	refresh()
end

local function clear_all()
	for key, _ in pairs(marked) do
		hipatterns.config.highlighters[key] = nil
	end
	marked = {}
	refresh()
end

local function get_visual()
	local save, save_type = vim.fn.getreg("v"), vim.fn.getregtype("v")
	vim.cmd('noautocmd normal! "vy')
	local text = vim.fn.getreg("v")
	vim.fn.setreg("v", save, save_type)
	return text
end

-- interestingwords replacement: <leader>m mark, <leader>M clear all
vim.keymap.set("n", "<leader>m", function()
	toggle(vim.fn.expand("<cword>"), true)
end, { desc = "Toggle interesting word" })
vim.keymap.set("x", "<leader>m", function()
	toggle(get_visual(), false)
end, { desc = "Toggle interesting selection" })
vim.keymap.set("n", "<leader>M", clear_all, { desc = "Clear interesting words" })
