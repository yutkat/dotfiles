execute "lua require'pluginconfig/nvim-dap'"
" do not use a/d/r(sandwich)
nnoremap <debugger>   <Nop>
nmap    s <debugger>
nmap <debugger>l <Cmd>lua require'dap'.run()<CR>
nmap <debugger>c <Cmd>lua require'dap'.continue()<CR>
nmap <debugger>b <Cmd>lua require'dap'.toggle_breakpoint()<CR>
nmap <debugger>n <Cmd>lua require'dap'.step_over()<CR>
nmap <debugger>i <Cmd>lua require'dap'.step_into()<CR>

if IsPluginInstalled('telescope-dap.nvim')
  nmap <debugger>L <Cmd>lua require'telescope'.extensions.dap.commands{}<CR>
  nmap <debugger>C <Cmd>lua require'telescope'.extensions.dap.configurations{}<CR>
  nmap <debugger>B <Cmd>lua require'telescope'.extensions.dap.list_breakpoints{}<CR>
  nmap <debugger>V <Cmd>lua require'telescope'.extensions.dap.variables{}<CR>
endif
