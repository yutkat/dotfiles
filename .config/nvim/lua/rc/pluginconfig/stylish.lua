vim.cmd([[
amenu Plugin.Fugitive.GFetch :GFetch | amenu Plugin.Fugitive.GPull :GPull | amenu Plugin.Fugitive.GPush :GPush
amenu File.Filetype.One :echo 1 | amenu File.Filetype.Two :echo 2 | amenu File.Filetype.Three :echo 3
amenu Edit.Recent.Foo :echo 'foo' | amenu Edit.Recent.Bar :echo 'bar' | amenu Edit.Recent.Baz :echo 'baz'
amenu Edit.Diff.Revision_1 :echo 'rev_1' | amenu Edit.Diff.Revision_2 :echo 'rev_2' | amenu Edit.Diff.Revision_3 :echo 'rev_3'
]])

for i = 1, 16 do
	vim.cmd("amenu OverflowList.Test_Thing_" .. i .. " :echo " .. i)
end

vim.keymap.set("n", "<F12>", function()
	require("stylish").ui_menu(vim.fn.menu_get(""), { kind = "menu", prompt = "Main menu" }, function(res)
		print("### " .. res)
	end)
end, { noremap = true, silent = true })
