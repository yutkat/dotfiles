require'neuron'.setup {
  virtual_titles = true,
  mappings = false,
  -- run = nil, -- function to run when in neuron dir
  neuron_dir = vim.fn.stdpath('data') .. "/neuron/",
  leader = "gz" -- the leader key to for all mappings, remember with 'go zettel'
}

vim.cmd("command! NeuronNew lua require'neuron/cmd'.new_edit(require'neuron'.config.neuron_dir)")
vim.cmd("command! NeuronEnterLink lua require'neuron'.enter_link()")
vim.cmd("command! NeuronFindZettels lua require'neuron/telescope'.find_zettels()")
vim.cmd("command! NeuronFindBacklinks lua require'neuron/telescope'.find_backlinks()")
vim.cmd("command! NeuronFindTags lua require'neuron/telescope'.find_tags()")
vim.cmd("command! NeuronRib lua require'neuron'.rib {address = '127.0.0.1:8200', verbose = true}")
vim.cmd("command! NeuronGotoNext lua require'neuron'.goto_next_extmark()")
vim.cmd("command! NeuronGotoPrev lua require'neuron'.goto_prev_extmark()]]")
