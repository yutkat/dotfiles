local M = {}
local default_config = {}
M.options = {}

-- @param user_conf table
-- @return table
function M.set(user_conf)
	if user_conf == nil then
		M.options = default_config
		return default_config
	end
	if type(user_conf) ~= "table" then
		error("Configuration error")
	end
	M.options = vim.tbl_deep_extend("force", default_config, user_conf or {})
	return M.options
end

return M
