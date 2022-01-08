-- Initial Configuration
require 'rc/init'

-- ===============================

-- Base Configuration
require 'rc/base'

-- Layout Settings
require 'rc/display'

-- Plugins
require 'rc/pluginlist'

-- Key mapping
-- vim.cmd('source ~/.config/nvim/rc/keyconfig.vim')
require 'rc/mappings'

-- Command
vim.cmd('source ~/.config/nvim/rc/command.vim')
vim.cmd('source ~/.config/nvim/rc/autocmd.vim')

-- Configuration
vim.api.nvim_exec([[
for f in split(glob('~/.config/nvim/rc/myplugins/*.vim'), '\n')
  execute 'source ' . f
endfor
]], true)
vim.api.nvim_exec([[
for f in split(glob('~/.config/nvim/rc/myplugins/*.nvim'), '\n')
  execute 'source ' . f
endfor
]], true)

-- ===============================
if vim.g.vscode then
  vim.cmd('source ~/.config/nvim/rc/vscode-neovim/mappings.vim')
end

-- ===============================

-- Local Configuration
vim.cmd("call vimrc#source_safe('~/.vimrc.local')")

