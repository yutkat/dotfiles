local dap = require 'dap'
dap.adapters.rust = {
  type = 'executable',
  attach = {pidProperty = "pid", pidSelect = "ask"},
  command = 'lldb-vscode', -- my binary was called 'lldb-vscode-11'
  env = {LLDB_LAUNCH_FLAG_LAUNCH_IN_TTY = "YES"},
  name = "lldb"
}

vim.fn.sign_define('DapBreakpoint', {text = '🛑', texthl = '', linehl = '', numhl = ''})

-- do not use a/d/r(sandwich)
vim.api.nvim_set_keymap('n', '<debugger>', '<Nop>', {noremap = true, silent = true})
vim.api.nvim_set_keymap('n', 's', '<debugger>', {})
vim.api.nvim_set_keymap('n', '<debugger>b', "<Cmd>lua require'dap'.toggle_breakpoint()<CR>",
                        {noremap = true, silent = true})
vim.api.nvim_set_keymap('n', '<debugger>c', "<Cmd>lua require'dap'.continue()<CR>",
                        {noremap = true, silent = true})
vim.api.nvim_set_keymap('n', '<debugger>n', "<Cmd>lua require'dap'.step_over()<CR>",
                        {noremap = true, silent = true})
vim.api.nvim_set_keymap('n', '<debugger>i', "<Cmd>lua require'dap'.step_into()<CR>",
                        {noremap = true, silent = true})
vim.api.nvim_set_keymap('n', '<debugger>o', "<Cmd>lua require'dap'.step_out()<CR>",
                        {noremap = true, silent = true})
vim.api.nvim_set_keymap('n', '<debugger>R', "<Cmd>lua require'dap'.repl.open()<CR>",
                        {noremap = true, silent = true})
vim.api.nvim_set_keymap('n', '<debugger>B',
                        "<Cmd>lua require'dap'.set_breakpoint(vim.fn.input('Breakpoint condition: '))<CR>",
                        {noremap = true, silent = true})
vim.api.nvim_set_keymap('n', '<debugger>l', "<Cmd>lua require'dap'.load_launchjs()<CR>",
                        {noremap = true, silent = true})
vim.api.nvim_set_keymap('n', '<debugger>g', "<Cmd>lua require'dap'.run_last()<CR>",
                        {noremap = true, silent = true})
-- telescope
vim.api.nvim_set_keymap('n', '<debugger>H',
                        "<Cmd>lua require'telescope'.extensions.dap.commands{}<CR>",
                        {noremap = true, silent = true})
vim.api.nvim_set_keymap('n', '<debugger>C',
                        "<Cmd>lua require'telescope'.extensions.dap.configurations{}<CR>",
                        {noremap = true, silent = true})
vim.api.nvim_set_keymap('n', '<debugger>P',
                        "<Cmd>lua require'telescope'.extensions.dap.list_breakpoints{}<CR>",
                        {noremap = true, silent = true})
vim.api.nvim_set_keymap('n', '<debugger>V',
                        "<Cmd>lua require'telescope'.extensions.dap.variables{}<CR>",
                        {noremap = true, silent = true})
vim.api.nvim_set_keymap('n', '<debugger>q', "<Cmd>lua require'dap'.disconnect({})<CR>",
                        {noremap = true, silent = true})

-- dap.configurations.rust = {
--   {
--     name = "Launch",
--     type = "rust",
--     request = "launch",
--     program = "",
--   },
-- }
