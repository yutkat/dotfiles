local modes = require("modes")

modes.remap_binds("normal", {
	{ "<Alt-h>", "<control-o>", true },
})
modes.remap_binds("normal", {
	{ "<Alt-l>", "<control-i>", true },
})
modes.remap_binds("normal", {
	{ "H", "gT", true },
})
modes.remap_binds("normal", {
	{ "L", "gt", true },
})
