-- Print a per-plugin summary after a headless `Lazy! sync` (plugupdate, CI)
-- instead of lazy.nvim's interleaved per-task output, which pluginlist.lua
-- turns off via `headless`.
local M = {}

local removed = {}

local function out(line)
	io.write(line .. "\n")
end

local function task_messages(task, min_level)
	local msgs = {}
	for _, entry in ipairs(task._log or {}) do
		if entry.level >= min_level and vim.trim(entry.msg) ~= "" then
			table.insert(msgs, vim.trim(entry.msg))
		end
	end
	return msgs
end

local function indent(text, prefix)
	return (prefix .. text:gsub("\n", "\n" .. prefix))
end

local function summarize()
	local Config = require("lazy.core.config")
	local updated, installed, problems = {}, {}, {}

	for name, plugin in vim.spairs(Config.plugins) do
		local state = plugin._ or {}
		if state.cloned then
			table.insert(installed, name)
		elseif state.updated and state.updated.from ~= state.updated.to then
			local commits = {}
			for _, task in ipairs(state.tasks or {}) do
				if task.name == "log" then
					vim.list_extend(commits, task_messages(task, vim.log.levels.DEBUG))
				end
			end
			table.insert(updated, { name = name, range = state.updated, commits = commits })
		end
		for _, task in ipairs(state.tasks or {}) do
			if task:has_warnings() then
				for _, msg in ipairs(task_messages(task, vim.log.levels.WARN)) do
					table.insert(problems, ("%s [%s]: %s"):format(name, task.name, msg))
				end
			end
		end
	end

	if #updated > 0 then
		out(("Updated (%d):"):format(#updated))
		for _, plugin in ipairs(updated) do
			out(("  %s %s..%s"):format(plugin.name, plugin.range.from:sub(1, 7), (plugin.range.to or "HEAD"):sub(1, 7)))
			for _, commits in ipairs(plugin.commits) do
				out(indent(commits, "    "))
			end
		end
	end
	if #installed > 0 then
		out(("Installed (%d): %s"):format(#installed, table.concat(installed, ", ")))
	end
	if #removed > 0 then
		out(("Removed (%d): %s"):format(#removed, table.concat(removed, ", ")))
	end
	if #updated + #installed + #removed == 0 then
		out("All plugins are up to date")
	end
	if #problems > 0 then
		out(("Problems (%d):"):format(#problems))
		for _, problem in ipairs(problems) do
			out(indent(problem, "  "))
		end
	end
end

function M.setup()
	local group = vim.api.nvim_create_augroup("rc_lazy_sync_summary", {})
	vim.api.nvim_create_autocmd("User", {
		group = group,
		pattern = "LazySyncPre",
		callback = function()
			removed = vim.tbl_map(function(plugin)
				return plugin.name
			end, require("lazy.core.config").to_clean)
		end,
	})
	vim.api.nvim_create_autocmd("User", {
		group = group,
		pattern = "LazySync",
		callback = summarize,
	})
end

return M
