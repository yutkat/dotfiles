zstyle ':autocomplete:list-choices:*' max-lines 90%
zstyle ':autocomplete:*' groups always
# zstyle ':autocomplete:tab:*' widget-style menu-select
zstyle ':autocomplete:tab:*' insert-unambiguous yes
zstyle ':autocomplete:tab:*' widget-style menu-complete
zstyle ':autocomplete:*' magic off
zstyle ':autocomplete:*' fuzzy-search off
zstyle ':autocomplete:*' key-binding off
# zstyle ':autocomplete:*' config off
zstyle ':completion:*' tag-order '! history-words recent-directories recent-files' '-'

