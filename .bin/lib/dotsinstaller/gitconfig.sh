#!/usr/bin/env bash

git config --global include.path "$HOME/.gitconfig_shared"

if [[ -x /usr/share/git/diff-highlight/diff-highlight ]]; then
  if [[ ! -e "/usr/local/bin/diff-highlight" ]]; then
    sudo ln -snf /usr/share/git/diff-highlight/diff-highlight /usr/local/bin/
    git config --global pager.log 'diff-highlight | less'
    git config --global pager.show 'diff-highlight | less'
    git config --global pager.diff 'diff-highlight | less'
  fi
fi
