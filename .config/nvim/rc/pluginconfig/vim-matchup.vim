let g:loaded_matchit = 1
let g:matchup_motion_enabled = 0
let g:matchup_text_obj_enabled = 1
let g:matchup_matchparen_deferred = 1
let g:matchup_matchparen_deferred_show_delay = 300
let g:matchup_matchparen_deferred_hide_delay = 700
let g:matchup_matchparen_timeout = 300
let g:matchup_matchparen_insert_timeout = 60
omap % ]%

lua vim.api.nvim_clear_autocmds({event = {"TextChangedI", "TextChangedP", "TextChanged"}, group = "matchup_matchparen"})
