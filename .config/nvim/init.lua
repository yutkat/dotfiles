-- Initial Configuration
vim.cmd('source ~/.config/nvim/rc/init.vim')

-- ===============================

-- Base Configuration
vim.cmd('source ~/.config/nvim/rc/base.vim')
vim.cmd('source ~/.config/nvim/rc/base.nvim')

-- Layout Settings
vim.cmd('source ~/.config/nvim/rc/display.vim')
vim.cmd('source ~/.config/nvim/rc/statusline.vim')

-- Plugins
require'pluginlist'

-- Key mapping
vim.cmd('source ~/.config/nvim/rc/keyconfig.vim')
vim.cmd('source ~/.config/nvim/rc/mappings.vim')

-- Command
vim.cmd('source ~/.config/nvim/rc/command.vim')
vim.cmd('source ~/.config/nvim/rc/autocmd.vim')

-- Configuration
vim.api.nvim_exec([[
for f in split(glob('~/.config/nvim/rc/myplugins/*.vim'), '\n')
  execute 'source ' . f
endfor
]],
true)
vim.api.nvim_exec([[
if has('nvim')
  for f in split(glob('~/.config/nvim/rc/myplugins/*.nvim'), '\n')
    execute 'source ' . f
  endfor
endif
]],
true)


-- ===============================
if vim.g.vscode then
  vim.cmd('source ~/.config/nvim/rc/vscode-neovim/mappings.vim')
end


-- ===============================

-- Local Configuration
vim.cmd("call vimrc#source_safe('~/.vimrc.local')")

