#!/usr/bin/env bash

git config --global include.path "$HOME/.gitconfig_shared"

if builtin command -v "delta" > /dev/null 2>&1; then
  git config --global pager.log 'delta | less'
  git config --global pager.show 'delta | less'
  git config --global pager.diff 'delta | less'
elif [[ -x /usr/share/git/diff-highlight/diff-highlight ]]; then
  if [[ ! -e "/usr/local/bin/diff-highlight" ]]; then
    sudo ln -snf /usr/share/git/diff-highlight/diff-highlight /usr/local/bin/
    git config --global pager.log 'diff-highlight | less'
    git config --global pager.show 'diff-highlight | less'
    git config --global pager.diff 'diff-highlight | less'
  fi
fi
