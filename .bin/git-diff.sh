#!/usr/bin/env bash

if builtin command -v "delta" > /dev/null 2>&1; then
  delta $@
elif [[ -x /usr/share/git/diff-highlight/diff-highlight ]]; then
  /usr/share/git/diff-highlight/diff-highlight $@
else
  diff $@
fi
