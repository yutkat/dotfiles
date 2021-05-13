require('nvim-autopairs').setup()

local remap = vim.api.nvim_set_keymap
local npairs = require('nvim-autopairs')

-- skip it, if you use another global object
_G.MUtils = {}
MUtils.completion_confirm = function()
  if vim.fn.pumvisible() ~= 0 then
    if vim.fn.complete_info()["selected"] ~= -1 then
      return vim.fn["coc#_select_confirm"]()
    else
      return npairs.esc("<C-g>u<cr>")
    end
  else
    return npairs.autopairs_cr()
  end
end

remap('i', '<CR>', 'v:lua.MUtils.completion_confirm()', {expr = true, noremap = true})
