
bindkey-safe() { [[ -n "$1" ]] && bindkey -M $BIND_OPTION "$1" "$2" }

#bindkey-safe ${key[F1]} delete-char
#bindkey-safe ${key[F2]} delete-char
#bindkey-safe ${key[F3]} delete-char
#bindkey-safe ${key[F4]} delete-char
#bindkey-safe ${key[F5]} delete-char
#bindkey-safe ${key[F6]} delete-char
#bindkey-safe ${key[F7]} delete-char
#bindkey-safe ${key[F8]} delete-char
#bindkey-safe ${key[F9]} delete-char
#bindkey-safe ${key[F10]} delete-char
#bindkey-safe ${key[F11]} delete-char
#bindkey-safe ${key[F12]} delete-char
