vim.api.nvim_create_user_command("Terminals", "sp | terminal", { force = true })
vim.api.nvim_create_user_command("Terminalv", "vsp | terminal", { force = true })
vim.api.nvim_create_user_command("Unformat", function()
	vim.keymap.set("ca", "w", "noautocmd w")
end, { force = true })

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
	local current_word = vim.fn.expand("<cword>")
	local input = vim.fn.input("", [[%s/\<]] .. current_word .. [[\>/&/gn]])
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
vim.api.nvim_create_user_command("EditPluginConfig", function()
	local plugin_name = string.match(vim.fn.expand("<cWORD>"), "['\"].*/(.*)['\"]")
	vim.cmd.edit(
		vim.fn.resolve(vim.fn.expand(vim.fn.stdpath("config") .. "/lua/rc/pluginconfig/"))
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
	for _, tabid in ipairs(vim.api.nvim_list_tabpages()) do
		for _, winid in ipairs(vim.api.nvim_tabpage_list_wins(tabid)) do
			local bufid = vim.api.nvim_win_get_buf(winid)
			tpbl[bufid] = true
		end
	end

	for _, bufid in ipairs(vim.api.nvim_list_bufs()) do
		if not tpbl[bufid] then
			vim.api.nvim_buf_delete(bufid, { force = true })
		end
	end
end, { force = true })

vim.api.nvim_create_user_command("DeleteEmptyBuffers", function()
	for _, bufid in ipairs(vim.api.nvim_list_bufs()) do
		if
				vim.api.nvim_get_option_value("buflisted", { buf = bufid })
				and vim.api.nvim_buf_get_name(bufid) == ""
				and vim.fn.bufwinnr(bufid) == -1
				and not vim.api.nvim_get_option_value("modified", { buf = bufid })
		then
			vim.api.nvim_buf_delete(bufid, { force = true })
		end
	end
end, { force = true })

-- tab buffer window list
-- https://koturn.hatenablog.com/entry/2018/02/13/000000
vim.api.nvim_create_user_command("TabInfo", function()
	local function create_winid2bufnr_dict()
		local winid2bufnr_dict = {}
		for _, bufid in ipairs(vim.api.nvim_list_bufs()) do
			for _, winid in ipairs(vim.api.nvim_list_wins()) do
				if vim.api.nvim_win_get_buf(winid) == bufid then
					winid2bufnr_dict[winid] = bufid
				end
			end
		end
		return winid2bufnr_dict
	end

	print("====== Tab Page Info ======")
	local current_tabid = vim.api.nvim_get_current_tabpage()
	local winid2bufnr_dict = create_winid2bufnr_dict()
	for _, tabid in ipairs(vim.api.nvim_list_tabpages()) do
		local current_winnr = vim.api.nvim_tabpage_get_win(tabid)
		local symbol1 = (tabid == current_tabid) and ">" or " "
		print(symbol1 .. "Tab:" .. tabid)
		print("    Buffer number | Window Number | Window ID | Buffer Name")
		for _, winid in ipairs(vim.api.nvim_tabpage_list_wins(tabid)) do
			local bufid = winid2bufnr_dict[winid]
			local symbol2 = (winid == current_winnr) and "*" or " "
			local c = string.format("%13d | %13d | %9d | %s", bufid, winid, winid, vim.api.nvim_buf_get_name(bufid))
			print("   " .. symbol2 .. c)
		end
	end
end, { force = true, bar = true })
