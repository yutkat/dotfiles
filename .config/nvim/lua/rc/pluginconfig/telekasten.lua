local home = vim.fn.stdpath("data") .. "/zettelkasten"
local templ_dir = vim.fn.stdpath("config") .. "/zettelkasten/templates"
require("telekasten").setup({
	home = home,
	dailies = home .. "/" .. "daily",
	weeklies = home .. "/" .. "weekly",
	templates = templ_dir,
	extension = ".md",

	-- following a link to a non-existing note will create it
	follow_creates_nonexisting = true,
	dailies_create_nonexisting = true,
	weeklies_create_nonexisting = true,

	-- template for new notes (new_note, follow_link)
	template_new_note = templ_dir .. "/new_note.md",

	-- template for newly created daily notes (goto_today)
	template_new_daily = templ_dir .. "/daily.md",

	-- template for newly created weekly notes (goto_thisweek)
	template_new_weekly = templ_dir .. "/weekly.md",

	-- integrate with calendar-vim
	plug_into_calendar = true,
	calendar_opts = {
		-- calendar week display mode: 1 .. 'WK01', 2 .. 'WK 1', 3 .. 'KW01', 4 .. 'KW 1', 5 .. '1'
		weeknm = 4,
		-- use monday as first day of week: 1 .. true, 0 .. false
		calendar_monday = 1,
		-- calendar mark: where to put mark for marked days: 'left', 'right', 'left-fit'
		calendar_mark = "left-fit",
	},
})

vim.cmd([[
  command! ZkFind lua require('telekasten').find_notes()
  command! ZkFindDaily lua require('telekasten').find_daily_notes()
  command! ZkFindWeekly lua require('telekasten').find_weekly_notes()
  command! ZkSearch lua require('telekasten').search_notes()
  command! ZkLink lua require('telekasten').follow_link()
  command! ZkToday lua require('telekasten').goto_today()
  command! ZkNew lua require('telekasten').new_note()
  command! ZkTemplate :ua require('telekasten').new_templated_note()
  command! ZkYank lua require('telekasten').yank_notelink()
  command! ZkShow lua require('telekasten').show_calendar()
]])
