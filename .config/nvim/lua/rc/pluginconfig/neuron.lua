require("neuron").setup({
	virtual_titles = true,
	mappings = false,
	run = nil, -- function to run when in neuron dir
	neuron_dir = vim.fn.stdpath("data") .. "/neuron/",
	leader = "gz", -- the leader key to for all mappings, remember with 'go zettel'
})

local utils = require("neuron/utils")
local Job = require("plenary/job")
local cmd = require("neuron/cmd")

cmd.new_edit_named = function(neuron_dir, name)
	if name == "" then
		name = vim.fn.input("filename: ")
	end
	if name == "" then
		return
	end

	Job:new({
		command = "neuron",
		args = { "new", name },
		cwd = neuron_dir,
		-- on_stderr = utils.on_stderr_factory("neuron new " .. name),
		interactive = false,
		on_exit = vim.schedule_wrap(function(job, return_val)
			utils.on_exit_return_check("neuron new", return_val)
			local data = table.concat(job:result())
			vim.cmd("edit " .. data)
			utils.start_insert_header()
		end),
	}):start()
end

vim.cmd(
	"command! -nargs=? NeuronNew lua require'neuron/cmd'.new_edit_named(require'neuron/config'.neuron_dir, \"<args>\")"
)
vim.cmd("command! NeuronEnterLink lua require'neuron'.enter_link()")
vim.cmd("command! NeuronFindZettels lua require'neuron/telescope'.find_zettels()")
vim.cmd("command! NeuronFindBacklinks lua require'neuron/telescope'.find_backlinks()")
vim.cmd("command! NeuronFindTags lua require'neuron/telescope'.find_tags()")
vim.cmd("command! NeuronRib lua require'neuron'.rib {address = '127.0.0.1:8200', verbose = true}")
vim.cmd("command! NeuronGotoNext lua require'neuron'.goto_next_extmark()")
vim.cmd("command! NeuronGotoPrev lua require'neuron'.goto_prev_extmark()]]")
