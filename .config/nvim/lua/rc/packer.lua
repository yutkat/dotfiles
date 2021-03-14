vim.api.nvim_exec([[
augroup vimrc_packer
  autocmd!
  autocmd BufWritePost .config/nvim/lua/rc/pluginlist.lua,.config/nvim/rc/pluginconfig/*.vim,.config/nvim/rc/pluginsetup/*.vim,.config/nvim/lua/rc/pluginconfig/*.lua PackerCompile
augroup END
]], true)

vim.api.nvim_exec([[
let g:plug = map(split(glob('~/.local/share/nvim/site/pack/packer/*/*'), "\n"), {key, val ->  fnamemodify(val, ":t")})
function! IsPluginInstalled(name) abort
  return index(g:plug, a:name) >= 0
endfunction
]], true)
