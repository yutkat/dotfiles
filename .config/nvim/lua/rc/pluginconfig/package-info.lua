require("package-info").setup()

vim.cmd("command! PackageInfo lua require('package-info').show()")
