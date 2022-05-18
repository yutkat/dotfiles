local M = {}
local config = {}

function M.set(user_conf)
	if user_conf == nil or type(user_conf) ~= "table" then
		error("Configration error")
	end
	config = vim.tbl_deep_extend("force", config, user_conf or {})
	return config
end

return M
