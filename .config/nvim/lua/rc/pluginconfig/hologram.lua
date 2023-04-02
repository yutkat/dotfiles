local my_image = require("hologram.image"):new({
	source = "",
	row = 11,
	col = 0,
})

my_image:transmit() -- send image data to terminal

-- Move image 5 rows down after 1 second
vim.defer_fn(function()
	my_image:move(15, 0)
	my_image:adjust() -- must adjust to update image
end, 1000)

-- Crop image to 100x100 pixels after 2 seconds
vim.defer_fn(function()
	my_image:adjust({ crop = { 100, 100 } })
end, 2000)

-- Resize image to 75x50 pixels after 3 seconds
vim.defer_fn(function()
	my_image:adjust({ area = { 75, 50 } })
end, 3000)
