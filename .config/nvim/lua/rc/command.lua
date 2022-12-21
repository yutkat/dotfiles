vim.api.nvim_create_user_command("Terminals", "sp | terminal", { force = true })
vim.api.nvim_create_user_command("Terminalv", "vsp | terminal", { force = true })
vim.api.nvim_create_user_command("Unformat", "cnoreabbrev w noautocmd w", { force = true })

-- CDC = Change to Directory of Current file
vim.api.nvim_create_user_command("CdCurrentDirectory", "lcd %:p:h", { force = true })

-- Diff current buffer " :w !diff %-
vim.api.nvim_create_user_command(
	"DiffOrig",
	"vert new | set bt=nofile | r # | 0d_ | diffthis | wincmd p | diffthis",
	{ force = true }
)

vim.api.nvim_create_user_command("SetNumberToggle", "set number! relativenumber!", { force = true })

-- Change indent
vim.api.nvim_create_user_command("IndentChange", "set tabstop=<args> shiftwidth=<args>", { force = true, nargs = 1 })

vim.api.nvim_create_user_command("EncodingReload", "execute 'e ++enc=<args>'", { force = true, nargs = 1 })

-- delete blank lines
vim.api.nvim_create_user_command("DeleteBlankLines", function()
	local input = vim.fn.input("", ":g/^$/d")
	vim.cmd(input)
	vim.fn.histadd("cmd", input)
end, { force = true })
-- count word
vim.api.nvim_create_user_command("CountWord", function()
	local input = vim.fn.input("", "':%s/\\<<C-r><C-w>\\>/&/gn'")
	vim.cmd(input)
	vim.fn.histadd("cmd", input)
end, { force = true })
vim.api.nvim_create_user_command("SelectedInfo", "normal! gvg<C-g>", { force = true, range = "%" })

-- open definition in preview window
vim.api.nvim_create_user_command("PreviewDefinition", "normal! <C-w>}", { force = true })

-- Spell Dictionary
vim.api.nvim_create_user_command("AddCorrectSpell", "normal! zg", { force = true })
vim.api.nvim_create_user_command("AddWrongSpell", "normal! zw", { force = true })
vim.api.nvim_create_user_command("ChangeCorrectSpell", "normal! z=", { force = true })
vim.api.nvim_create_user_command("FixCorrectSpell", "ChangeCorrectSpell", { force = true })
vim.api.nvim_create_user_command("CorrectSpell", "ChangeCorrectSpell", { force = true })

-- Binary
vim.api.nvim_create_user_command("BinaryModeOn", "%!xxd -g1", { force = true })
vim.api.nvim_create_user_command("BinaryModeOff", "%!xxd -r", { force = true })
vim.api.nvim_create_user_command("HexDumpOn", "%!xxd -g1", { force = true })
vim.api.nvim_create_user_command("HexDumpOff", "%!xxd -r", { force = true })

-- Trim whitespace
vim.api.nvim_create_user_command("TrimWhiteSpace", "keeppatterns %s/\\s\\+$//e <Bar> :nohlsearch", { force = true })

-- Spell check
vim.api.nvim_create_user_command("SpellCheckOff", "setlocal nospell", { force = true })
vim.api.nvim_create_user_command("SpellCheckOn", "setlocal spell! spelllang=en_us", { force = true })

-- Nvim delmark
vim.api.nvim_create_user_command("DelMarks", "delmarks! | wshada!", { force = true })

-- sort startuptime
vim.api.nvim_create_user_command("SortStartupTime", "%!sort -k2nr", { force = true })

-- json
vim.api.nvim_create_user_command("JsonDemangle", "%!jq '.'", { force = true })

-- q record
vim.api.nvim_create_user_command("Recording", "normal! q<args>", { force = true, nargs = 1 })

-- file fullpath
vim.api.nvim_create_user_command("Filepath", "echo expand('%:p')", { force = true, nargs = 1 })
vim.api.nvim_create_user_command(
	"FileWithNumber e",
	"echo join([expand('%'),  line('.')], ':')",
	{ force = true, nargs = 1 }
)

-- edit plugin config
vim.api.nvim_create_user_command("EditPluginConfigVim", function()
	local plugin_name = string.match(vim.fn.expand("<cWORD>"), "['\"].*/(.*)['\"]")
	vim.cmd(
		"edit "
			.. vim.fn.resolve(vim.fn.expand(vim.fn.stdpath("config") .. "/rc/pluginconfig/"))
			.. "/"
			.. vim.fn.fnamemodify(plugin_name, ":r")
			.. ".vim"
	)
end, { force = true })
vim.api.nvim_create_user_command("EditPluginConfigLua", function()
	local plugin_name = string.match(vim.fn.expand("<cWORD>"), "['\"].*/(.*)['\"]")
	vim.cmd(
		"edit "
			.. vim.fn.resolve(vim.fn.expand(vim.fn.stdpath("config") .. "/lua/rc/pluginconfig/"))
			.. "/"
			.. vim.fn.fnamemodify(plugin_name, ":r")
			.. ".lua"
	)
end, { force = true })

-- profile
vim.api.nvim_create_user_command(
	"Profile",
	"profile start /tmp/nvim-profile.log | profile func * | profile file *",
	{ force = true }
)

vim.api.nvim_create_user_command("DeleteHiddenBuffers", function()
	local tpbl = {}
	for _, val in ipairs(vim.fn.range(1, vim.fn.tabpagenr("$"))) do
		for _, val2 in ipairs(vim.fn.tabpagebuflist(val)) do
			table.insert(tpbl, val2)
		end
	end
	for _, buf in ipairs(vim.fn.range(1, vim.fn.bufnr("$"))) do
		if vim.fn.bufexists(buf) == 1 and vim.fn.index(tpbl, buf) == -1 then
			vim.api.nvim_buf_delete(buf, { force = true })
		end
	end
end, { force = true })

vim.api.nvim_create_user_command("DeleteEmptyBuffers", function()
	for _, buf in ipairs(vim.fn.range(1, vim.fn.bufnr("$"))) do
		if
			vim.fn.buflisted(buf) ~= 0
			and vim.fn.empty(vim.fn.bufname(buf)) == 1
			and vim.fn.bufwinnr(buf) < 0
			and vim.fn.getbufvar(buf, "&mod") == 0
		then
			vim.api.nvim_buf_delete(buf, { force = true })
		end
	end
end, { force = true })

-- tab buffer window list
-- https://koturn.hatenablog.com/entry/2018/02/13/000000
vim.api.nvim_create_user_command("TabInfo", function()
	local function create_winid2bufnr_dict()
		local winid2bufnr_dict = {}
		for _, bnr in ipairs(vim.fn.range(1, vim.fn.bufnr("$"))) do
			for _, wid in ipairs(vim.fn.win_findbuf(bnr)) do
				winid2bufnr_dict[wid] = bnr
			end
		end
		return winid2bufnr_dict
	end
	print("====== Tab Page Info ======")
	local current_tnr = vim.fn.tabpagenr()
	local winid2bufnr_dict = create_winid2bufnr_dict()
	for _, tnr in ipairs(vim.fn.range(1, vim.fn.tabpagenr("$"))) do
		local current_winnr = vim.fn.tabpagewinnr(tnr)
		local symbol1 = (tnr == current_tnr) and ">" or " "
		print(symbol1 .. "Tab:" .. tnr)
		print("    Buffer number | Window Number | Window ID | Buffer Name")
		for _, wnr in ipairs(vim.fn.range(1, vim.fn.tabpagewinnr(tnr, "$"))) do
			local wid = vim.fn.win_getid(wnr, tnr)
			local bnr = winid2bufnr_dict[wid]
			local symbol2 = (wnr == current_winnr) and "*" or " "
			local c = string.format("%13d | %13d | %9d | %s", bnr, wnr, wid, vim.fn.bufname(bnr))
			print("   " .. symbol2 .. c)
		end
	end
end, { force = true, bar = true })
