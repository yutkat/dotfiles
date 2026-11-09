-- Jump between related files, e.g. source <-> test (replaces rgroli/other.nvim).
-- pattern: Lua pattern matched against the absolute path of the current file.
-- target: path with %1.. captures and optional globs; relative paths resolve from cwd.
local mappings = {
	{ pattern = "src/(.*)%.ts$", target = "test/%1.test.ts" },
	{ pattern = "test/(.*)%.test%.ts$", target = "src/%1.ts" },
	{ pattern = "lua/(.*)/(.*)%.lua$", target = "tests/%2_spec.lua" },
	{ pattern = "tests/(.*)_spec%.lua$", target = "lua/*/%1.lua" },
	{
		pattern = "%.config/nvim/lua/rc/pluginconfig/(.*)%.lua$",
		target = vim.fn.stdpath("data") .. "/lazy/%1*/README.md",
	},
}

local function candidates(path)
	local cwd = vim.uv.cwd() or ""
	local found = {}
	for _, m in ipairs(mappings) do
		local caps = { path:match(m.pattern) }
		if #caps > 0 then
			local target = m.target:gsub("%%(%d)", function(i)
				return caps[tonumber(i)] or ""
			end)
			if not vim.startswith(target, "/") then
				target = cwd .. "/" .. target
			end
			for _, f in ipairs(vim.fn.glob(target, false, true)) do
				if f ~= path and not vim.tbl_contains(found, f) then
					table.insert(found, f)
				end
			end
		end
	end
	return found
end

local function open_other()
	local found = candidates(vim.api.nvim_buf_get_name(0))
	if #found == 0 then
		vim.notify("No other file found", vim.log.levels.WARN)
	elseif #found == 1 then
		vim.cmd.edit(vim.fn.fnameescape(found[1]))
	else
		vim.ui.select(found, {
			prompt = "Other file",
			format_item = function(f)
				return vim.fn.fnamemodify(f, ":~:.")
			end,
		}, function(choice)
			if choice then
				vim.cmd.edit(vim.fn.fnameescape(choice))
			end
		end)
	end
end

vim.api.nvim_create_user_command("Other", open_other, { desc = "Open the related file" })
vim.keymap.set("n", "<F6>", open_other, { desc = "Open the related file" })
vim.keymap.set("n", "<C-S-T>", open_other, { desc = "Open the related file" })
