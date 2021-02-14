vim.api.nvim_exec([[
let g:plug = map(split(glob('~/.local/share/nvim/site/pack/packer/*/*'), "\n"), {key, val ->  fnamemodify(val, ":t")})
function! IsPluginInstalled(name) abort
  return index(g:plug, a:name) >= 0
endfunction
]], true)
