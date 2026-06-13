-- Markdown uses 2-space indentation (matches markdownlint MD007 default).
-- Overrides the bundled runtime ftplugin which forces tabstop/shiftwidth=4.
-- Structural correctness (ordered-list continuation, code blocks) is handled
-- by the formatter (prettier via conform) on save.
vim.opt_local.expandtab = true
vim.opt_local.tabstop = 2
vim.opt_local.softtabstop = 2
vim.opt_local.shiftwidth = 2

-- Continue list markers on a new line. The bundled markdown ftplugin disables
-- this (formatoptions-=r -=o, plus an "f" flag that only hanging-indents
-- instead of repeating the marker). Drop the "f" flag and re-enable r/o so
-- pressing <CR> (insert) or o/O (normal) on a "- ", "* ", "+ " or "> " line
-- re-inserts the marker.
vim.opt_local.comments = "b:-,b:*,b:+,n:>"
vim.opt_local.formatoptions:append("r")
vim.opt_local.formatoptions:append("o")
