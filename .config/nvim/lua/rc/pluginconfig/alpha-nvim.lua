local alpha = require 'alpha'
local dashboard = require 'alpha.themes.dashboard'
dashboard.section.header.val = vim.fn.readfile(vim.fn.expand(
                                                   '~/.config/nvim/rc/files/dashboard_custom_header.txt'))
dashboard.section.buttons.val = {
  dashboard.button('l', ' Open last session', ':SearchSession<CR>'),
  dashboard.button('h', ' Recently opened files', ':Telescope my_mru<CR>'),
  dashboard.button('f', ' Find file', ':Telescope find_files<CR>'),
  dashboard.button('e', ' New file', ':enew<CR>'),
  dashboard.button('b', ' Jump to bookmarks', ':Telescope marks<CR>'),
  dashboard.button('n', ' Memo New', ':NeuronNew<CR>'),
  dashboard.button('m', ' Memo List', ':NeuronFindZettels<CR>')
}
alpha.setup(dashboard.opts)
