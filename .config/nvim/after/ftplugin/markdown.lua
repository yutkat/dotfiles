-- Markdown uses 2-space indentation (matches markdownlint MD007 default).
-- Overrides the bundled runtime ftplugin which forces tabstop/shiftwidth=4.
-- Structural correctness (ordered-list continuation, code blocks) is handled
-- by the formatter (prettier via conform) on save.
vim.opt_local.expandtab = true
vim.opt_local.tabstop = 2
vim.opt_local.softtabstop = 2
vim.opt_local.shiftwidth = 2
