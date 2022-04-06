let g:loaded_matchit = 1
hi MatchParenCur cterm=underline gui=underline
hi MatchWordCur cterm=underline gui=underline
let g:matchup_motion_enabled = 1
let g:matchup_text_obj_enabled = 1
let g:matchup_matchparen_deferred_show_delay = 100
omap % ]%

lua vim.api.nvim_clear_autocmds({event = {"TextChangedI"}, group = "matchup_matchparen"})
