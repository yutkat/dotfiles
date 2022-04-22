local function is_available_gps()
	local ok, _ = pcall(require, "nvim-gps")
	if not ok then
		return false
	end
	return require("nvim-gps").is_available()
end

local sections_1 = {
	lualine_a = { "mode" },
	lualine_b = { { "filetype", icon_only = true }, { "filename", path = 1 } },
	lualine_c = { { 'require("nvim-gps").get_location()', cond = is_available_gps } },
	lualine_x = { "require'lsp-status'.status()", "diagnostics" },
	lualine_y = { "branch", "diff" },
	lualine_z = { "location" },
}

local sections_2 = {
	lualine_a = { "mode" },
	lualine_b = { "" },
	lualine_c = { { "filetype", icon_only = true }, { "filename", path = 1 } },
	lualine_x = { "encoding", "fileformat", "filetype" },
	lualine_y = { "filesize", "progress" },
	lualine_z = { "location" },
}

vim.keymap.set({ "n" }, "!", function()
	local lualine_require = require("lualine_require")
	local modules = lualine_require.lazy_require({ config_module = "lualine.config" })
	local utils = require("lualine.utils.utils")

	local current_config = modules.config_module.get_config()
	if vim.inspect(current_config.sections) == vim.inspect(sections_1) then
		current_config.sections = utils.deepcopy(sections_2)
	else
		current_config.sections = utils.deepcopy(sections_1)
	end
	require("lualine").setup(current_config)
end, { noremap = true, expr = true })

local colors = {
	-- onedark
	-- blue = '#61afef',
	-- green = '#98c379',
	-- purple = '#c678dd',
	-- red1 = '#e06c75',
	-- red2 = '#be5046',
	-- yellow = '#e5c07b',
	-- fg = '#abb2bf',
	-- bg = '#282c34',
	-- gray1 = '#5c6370',
	-- gray2 = '#2c323d',
	-- gray3 = '#3e4452'
	-- nordfox
	black = "#3b4252",
	red = "#bf616a",
	green = "#a3be8c",
	yellow = "#ebcb8b",
	blue = "#81a1c1",
	magenta = "#b48ead",
	cyan = "#88c0d0",
	white = "#e5e9f0",
	foreground = "#b9bfca",
	background = "#2e3440",
}

local terminal_status_color = function(status)
	local mode_colors = {
		Running = colors.orange,
		Finished = colors.purple,
		Success = colors.blue,
		Error = colors.red,
		Command = colors.green,
	}

	return mode_colors[status]
end

local get_exit_status = function()
	local ln = vim.api.nvim_buf_line_count(0)
	while ln >= 1 do
		local l = vim.api.nvim_buf_get_lines(0, ln - 1, ln, true)[1]
		ln = ln - 1
		local exit_code = string.match(l, "^%[Process exited ([0-9]+)%]$")
		if exit_code ~= nil then
			return tonumber(exit_code)
		end
	end
end

local terminal_status = function()
	if
		vim.api.nvim_exec(
			[[echo trim(execute("filter /" . escape(nvim_buf_get_name(bufnr()), '~/') . "/ ls! uaF"))]],
			true
		) ~= ""
	then
		local result = get_exit_status()
		if result == nil then
			return "Finished"
		elseif result == 0 then
			return "Success"
		elseif result >= 1 then
			return "Error"
		end
		return "Finished"
	end
	if
		vim.api.nvim_exec(
			[[echo trim(execute("filter /" . escape(nvim_buf_get_name(bufnr()), '~/') . "/ ls! uaR"))]],
			true
		) ~= ""
	then
		return "Running"
	end
	return "Command"
end

local function get_terminal_status()
	if vim.bo.buftype ~= "terminal" then
		return ""
	end
	local status = terminal_status()
	vim.api.nvim_command(
		"hi LualineToggleTermStatus guifg=" .. colors.background .. " guibg=" .. terminal_status_color(status)
	)
	return status
end

local function toggleterm_statusline()
	return "ToggleTerm #" .. vim.b.toggle_number
end

local my_toggleterm = {
	sections = {
		lualine_a = { toggleterm_statusline },
		lualine_z = { { get_terminal_status, color = "LualineToggleTermStatus" } },
	},
	filetypes = { "toggleterm" },
}

local my_extension = {
	sections = { lualine_b = { "filetype" } },
	filetypes = { "packager", "vista", "NvimTree", "coc-explorer" },
}

require("lualine").setup({
	options = {
		icons_enabled = true,
		theme = "nightfox",
		component_separators = { left = "", right = "" },
		section_separators = { left = "", right = "" },
		disabled_filetypes = {},
		always_divide_middle = true,
		globalstatus = true,
	},
	sections = sections_1,
	inactive_sections = {
		lualine_a = { "mode" },
		lualine_b = {},
		lualine_c = { "filename" },
		lualine_x = { "location" },
		lualine_y = {},
		lualine_z = {},
	},
	tabline = {},
	extensions = { "quickfix", my_toggleterm, "symbols-outline", my_extension },
})
