require("marks").setup({
	default_mappings = false, -- whether to map keybinds or not. default true
	builtin_marks = {}, -- which builtin marks to show. default {}
	cyclic = true, -- whether movements cycle back to the beginning/end of buffer. default true
	force_write_shada = false, -- whether the shada file is updated after modifying uppercase marks. default false
	bookmark_0 = { -- marks.nvim allows you to configure up to 10 bookmark groups, each with its own sign/virttext
		sign = "⚑",
		virt_text = "hello world",
	},
	mappings = {
		set_next = "m,",
		next = "m]",
		preview = "m;",
		set_bookmark0 = "m0",
		prev = false, -- pass false to disable only this default mapping
	},
})
