require("cmp_dictionary").setup({
  dic = {["*"] = "/usr/share/dict/cracklib-small"},
  -- The following are default values, so you don't need to write them if you don't want to change them
  exact = 2,
  async = false,
  capacity = 5,
  debug = false
})
