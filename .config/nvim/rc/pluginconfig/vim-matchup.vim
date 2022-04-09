let g:loaded_matchit = 1
hi MatchParenCur cterm=underline gui=underline
hi MatchWordCur cterm=underline gui=underline
let g:matchup_motion_enabled = 1
let g:matchup_text_obj_enabled = 1
let g:matchup_matchparen_deferred_show_delay = 300
omap % ]%

lua vim.api.nvim_clear_autocmds({event = {"TextChangedI", "TextChangedP", "TextChanged"}, group = "matchup_matchparen"})
