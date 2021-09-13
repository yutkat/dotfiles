vim.api.nvim_exec([[
augroup vimrc_packer
  autocmd!
  autocmd BufWritePost .config/nvim/lua/rc/pluginlist.lua,.config/nvim/rc/pluginconfig/*.vim,.config/nvim/rc/pluginsetup/*.vim,.config/nvim/lua/rc/pluginconfig/*.lua PackerCompile
augroup END
]], true)

vim.api.nvim_exec([[
function! IsPluginInstalled(name) abort
  return luaeval("_G.packer_plugins['" .. a:name .. "'] ~= nil")
endfunction
]], true)

function AutocmdLazyConfig(plugin_name)
  local timer = vim.loop.new_timer()
  timer:start(1000, 0, vim.schedule_wrap(function()
    if _G.packer_plugins[plugin_name].loaded then
      timer:close() -- Always close handles to avoid leaks.
      vim.cmd(string.format('doautocmd User %s', "packer-" .. plugin_name))
    end
  end))
end

-- packer is too difficult customized configration
-- Not loading at startup
-- local packer = require'packer'
-- local util = require'packer.util'
-- packer.init({
--   compile_path = util.join_paths(vim.fn.stdpath('data'), 'plugin', 'packer_compiled.vim')
-- })
-- packer.reset()
