vim.filetype.add({ filename = { ["bash.sh"] = "sh" } })
local temp = require("template")
temp.temp_dir = vim.fn.stdpath("config") .. "/template/"
