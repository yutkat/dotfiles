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

	image_link_style = "markdown",

	-- default sort option: 'filename', 'modified'
	sort = "modified",

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

	-- telescope actions behavior
	close_after_yanking = false,
	insert_after_inserting = true,

	-- tag notation: '#tag', ':tag:', 'yaml-bare'
	tag_notation = "#tag",

	-- command palette theme: dropdown (window) or ivy (bottom panel)
	command_palette_theme = "ivy",

	-- tag list theme:
	-- get_cursor: small tag list at cursor; ivy and dropdown like above
	show_tags_theme = "ivy",

	-- when linking to a note in subdir/, create a [[subdir/title]] link
	-- instead of a [[title only]] link
	subdirs_in_links = true,

	-- template_handling
	-- What to do when creating a new note via `new_note()` or `follow_link()`
	-- to a non-existing note
	-- - prefer_new_note: use `new_note` template
	-- - smart: if day or week is detected in title, use daily / weekly templates (default)
	-- - always_ask: always ask before creating a note
	template_handling = "smart",

	-- path handling:
	--   this applies to:
	--     - new_note()
	--     - new_templated_note()
	--     - follow_link() to non-existing note
	--
	--   it does NOT apply to:
	--     - goto_today()
	--     - goto_thisweek()
	--
	--   Valid options:
	--     - smart: put daily-looking notes in daily, weekly-looking ones in weekly,
	--              all other ones in home, except for notes/with/subdirs/in/title.
	--              (default)
	--
	--     - prefer_home: put all notes in home except for goto_today(), goto_thisweek()
	--                    except for notes with subdirs/in/title.
	--
	--     - same_as_current: put all new notes in the dir of the current note if
	--                        present or else in home
	--                        except for notes/with/subdirs/in/title.
	new_note_location = "smart",

	-- should all links be updated when a file is renamed
	rename_update_links = true,
})

local M = require("telekasten")
local linkutils = require("telekasten.utils.links")
local tkutils = require("telekasten.utils")
local scan = require("plenary.scandir")
local utils = require("telescope.utils")
local entry_display = require("telescope.pickers.entry_display")
local fileutils = require("telekasten.utils.files")
local actions = require("telescope.actions")
local pickers = require("telescope.pickers")
local finders = require("telescope.finders")
local conf = require("telescope.config").values

local picker_actions = {}

local function filter_filetypes(flist, ftypes)
	local new_fl = {}
	ftypes = ftypes or { M.Cfg.extension }

	local ftypeok = {}
	for _, ft in pairs(ftypes) do
		ftypeok[ft] = true
	end

	for _, fn in pairs(flist) do
		if ftypeok[fileutils.get_extension(fn)] then
			table.insert(new_fl, fn)
		end
	end
	return new_fl
end

local function find_files_sorted(opts)
	opts = opts or {}

	local file_list = scan.scan_dir(opts.cwd, {})
	local filter_extensions = opts.filter_extensions or M.Cfg.filter_extensions
	file_list = filter_filetypes(file_list, filter_extensions)
	local sort_option = opts.sort or "filename"
	if sort_option == "modified" then
		table.sort(file_list, function(a, b)
			return vim.fn.getftime(a) > vim.fn.getftime(b)
		end)
	else
		table.sort(file_list, function(a, b)
			return a > b
		end)
	end

	local counts = nil
	if opts.show_link_counts then
		counts = linkutils.generate_backlink_map(M.Cfg)
	end

	-- display with devicons
	local function iconic_display(display_entry)
		local display_opts = {
			path_display = function(_, e)
				return e:gsub(tkutils.escape(opts.cwd .. "/"), "")
			end,
		}

		local hl_group
		local display = utils.transform_path(display_opts, display_entry.value)

		display, hl_group = utils.transform_devicons(display_entry.value, display, false)

		if hl_group then
			return display, { { { 1, 3 }, hl_group } }
		else
			return display
		end
	end

	-- for media_files
	local popup_opts = {}
	opts.get_preview_window = function()
		return popup_opts.preview
	end

	local displayer = entry_display.create({
		separator = "",
		items = {
			{ width = 4 },
			{ width = 4 },
			{ remaining = true },
		},
	})

	local function make_display(entry)
		local fn = entry.value
		local nlinks = counts.link_counts[fn] or 0
		local nbacks = counts.backlink_counts[fn] or 0

		if opts.show_link_counts then
			local display, hl = iconic_display(entry)

			return displayer({
				{
					"L" .. tostring(nlinks),
					function()
						return {
							{ { 0, 1 }, "tkTagSep" },
							{ { 1, 3 }, "tkTag" },
						}
					end,
				},
				{
					"B" .. tostring(nbacks),
					function()
						return {
							{ { 0, 1 }, "tkTagSep" },
							{ { 1, 3 }, "DevIconMd" },
						}
					end,
				},
				{
					display,
					function()
						return hl
					end,
				},
			})
		else
			return iconic_display(entry)
		end
	end

	local function entry_maker(entry)
		local iconic_entry = {}
		iconic_entry.value = entry
		iconic_entry.path = entry
		iconic_entry.ordinal = entry
		if opts.show_link_counts then
			iconic_entry.display = make_display
		else
			iconic_entry.display = iconic_display
		end
		return iconic_entry
	end

	local previewer = conf.file_previewer(opts)

	opts.attach_mappings = opts.attach_mappings
		or function(_, _)
			actions.select_default:replace(picker_actions.select_default)
		end

	local picker = pickers.new(opts, {
		finder = finders.new_table({
			results = file_list,
			entry_maker = entry_maker,
		}),
		sorter = conf.generic_sorter(opts),
		previewer = previewer,
	})

	-- for media_files:
	local line_count = vim.o.lines - vim.o.cmdheight
	if vim.o.laststatus ~= 0 then
		line_count = line_count - 1
	end

	popup_opts = picker:get_window_options(vim.o.columns, line_count)

	picker:find()
end

function M.find_notes(opts)
	opts = opts or {}
	opts.insert_after_inserting = opts.insert_after_inserting or M.Cfg.insert_after_inserting
	opts.close_after_yanking = opts.close_after_yanking or M.Cfg.close_after_yanking

	local cwd = M.Cfg.home
	local find_command = M.Cfg.find_command
	local sort = M.Cfg.sort
	local attach_mappings = function(_, _)
		actions.select_default:replace(picker_actions.select_default)
		return true
	end

	find_files_sorted({
		prompt_title = "Find notes by name",
		cwd = cwd,
		find_command = find_command,
		attack = find_command,
		attach_mappings = attach_mappings,
		sort = sort,
	})
end
