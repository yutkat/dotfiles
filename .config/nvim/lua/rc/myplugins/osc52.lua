if not os.getenv("SSH_CONNECTION") then
	return
end

-- https://neovim.discourse.group/t/how-can-i-customize-clipboard-provider-using-lua/2564/2
local function should_add(event)
	local length = #event.regcontents - 1
	for _, line in ipairs(event.regcontents) do
		length = length + #line
		if length > 10000 then
			return false
		end
	end
	return true
end

local groupname = "vimrc_osc52"
vim.api.nvim_create_augroup(groupname, { clear = true })
vim.api.nvim_create_autocmd({ "TextYankPost" }, {
	group = groupname,
	pattern = "*",
	callback = function()
		local event = vim.v.event
		if should_add(event) then
			local joined = vim.fn.join(event.regcontents, "\n")
			local based = vim.fn.system("base64 | tr -d '\n'", joined)
			vim.fn.chansend(vim.v.stderr, vim.fn.printf("\x1b]52;;%s\x1b\\", based))
		end
	end,
	once = false,
})
