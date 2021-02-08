-- Initial Configuration
vim.cmd('source ~/.vim/rc/init.vim')

-- ===============================

-- Base Configuration
vim.cmd('source ~/.vim/rc/base.vim')
vim.cmd('source ~/.vim/rc/base.nvim')

-- Layout Settings
vim.cmd('source ~/.vim/rc/display.vim')
vim.cmd('source ~/.vim/rc/statusline.vim')

-- Plugins
require'pluginlist'

-- Key mapping
vim.cmd('source ~/.vim/rc/keyconfig.vim')
vim.cmd('source ~/.vim/rc/mappings.vim')

-- Command
vim.cmd('source ~/.vim/rc/command.vim')
vim.cmd('source ~/.vim/rc/autocmd.vim')

-- Configuration
vim.api.nvim_exec([[
for f in split(glob('~/.vim/rc/myplugins/*.vim'), '\n')
  execute 'source ' . f
endfor
]],
true)
vim.api.nvim_exec([[
if has('nvim')
  for f in split(glob('~/.vim/rc/myplugins/*.nvim'), '\n')
    execute 'source ' . f
  endfor
endif
]],
true)


-- ===============================
if vim.g.vscode then
  vim.cmd('source ~/.vim/rc/vscode-neovim/mappings.vim')
end


-- ===============================

-- Local Configuration
vim.cmd("call vimrc#source_safe('~/.vimrc.local')")

