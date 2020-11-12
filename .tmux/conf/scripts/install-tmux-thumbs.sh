#!/usr/bin/env bash

if [[ -d ~/.tmux/plugins/tmux-thumbs ]]; then
  return
fi

git clone --depth=1 https://github.com/fcsonline/tmux-thumbs ~/.tmux/plugins/tmux-thumbs

if ! builtin command -v cargo >/dev/null 2>&1; then
  return
fi

(cd ~/.tmux/plugins/tmux-thumbs && cargo build --release)
