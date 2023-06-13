local M = {}

function M.basename(s)
	return string.gsub(s, "(.*[/\\])(.*)", "%2")
end

function M.merge_tables(t1, t2)
	for k, v in pairs(t2) do
		if (type(v) == "table") and (type(t1[k] or false) == "table") then
			M.merge_tables(t1[k], t2[k])
		else
			t1[k] = v
		end
	end
	return t1
end

function M.merge_lists(t1, t2)
	local result = {}
	for _, v in pairs(t1) do
		table.insert(result, v)
	end
	for _, v in pairs(t2) do
		table.insert(result, v)
	end
	return result
end

function M.exists(tab, element)
	for _, v in pairs(tab) do
		if v == element then
			return true
		elseif type(v) == "table" then
			return M.exists(v, element)
		end
	end
	return false
end

function M.convert_home_dir(path)
	local cwd = path
	local home = os.getenv("HOME")
	cwd = cwd:gsub("^" .. home .. "/", "~/")
	if cwd == "" then
		return path
	end
	return cwd
end

function M.convert_useful_path(dir)
	local cwd = M.convert_home_dir(dir)
	return M.basename(cwd)
end

function M.split_from_url(dir)
	local cwd = ""
	local hostname = ""
	local cwd_uri = dir:sub(8)
	local slash = cwd_uri:find("/")
	if slash then
		hostname = cwd_uri:sub(1, slash - 1)
		-- Remove the domain name portion of the hostname
		local dot = hostname:find("[.]")
		if dot then
			hostname = hostname:sub(1, dot - 1)
		end
		cwd = cwd_uri:sub(slash)
		cwd = M.convert_useful_path(cwd)
	end
	return hostname, cwd
end

return M
