nnoremap <make>b <Cmd>AsyncTask project-build<CR> let g:asynctasks_extra_config = [ \ '~/.config/nvim/tasks/my_tasks.ini', \ ]
let g:asynctasks_template = {}
let g:asynctasks_template.cargo = [
      \ "[project-init]",
      \ "command=cargo update",
      \ "cwd=<root>",
      \ "",
      \ "[project-build]",
      \ "command=cargo build",
      \ "cwd=<root>",
      \ "errorformat=%. %#--> %f:%l:%c",
      \ "",
      \ "[project-run]",
      \ "command=cargo run",
      \ "cwd=<root>",
      \ "output=terminal",
      \ ]
