#!/bin/bash
git config --global color.ui auto
git config --global diff.noprefix true


# alias

## branch/tag
git config --global alias.branches 'branch -a --sort=-authordate'
git config --global alias.tags 'tag'
git config --global alias.remotes 'remote -v'
git config --global alias.current-branch 'rev-parse --abbrev-ref HEAD'
git config --global alias.branch 'branch --sort=-authordate'
git config --global alias.branch-activity "for-each-ref --format='%(authordate) %(refname)' --sort=-committerdate refs/heads refs/remotes"

## stage/commit
git config --global alias.stashes 'stash list'
git config --global alias.unstage 'reset -q HEAD --'
git config --global alias.discard 'checkout --'
git config --global alias.uncommit 'reset --mixed HEAD~'
git config --global alias.amend 'commit --amend'
git config --global alias.fix 'commit --amend'
git config --global alias.nevermind '!git reset --hard HEAD && git clean -d -f'
git config --global alias.refresh 'fetch --prune'
git config --global alias.precommit 'diff --cached --diff-algorithm=minimal -w'
git config --global alias.unmerged 'diff --name-only --diff-filter=U'

## merge
git config --global alias.merged "!f () {\
        git branch --merged | grep -v master | grep -v '*' | sed 's/^..//';\
    };f"

## log
git config --global alias.graph "log --graph -10 --branches --remotes --tags  --format=format:'%Cgreen%h %Creset• %<(75,trunc)%s (%cN, %cr) %Cred%d' --date-order"
git config --global alias.logline 'log --oneline --stat --branches'
git config --global alias.ll 'log --pretty=format:"%C(yellow)%h%Cred%d\\ %Creset%s%Cblue\\ [%cn]" --decorate --numstat'
git config --global alias.hist "log --pretty=format:'%h %ad | %s%d [%an]' --graph --date=short"
git config --global alias.tree 'log --graph --all --format=format:"%C(bold blue)%h%C(reset) - %C(bold green)(%ar)%C(reset) %C(white)%s%C(reset) %C(bold white)? %an%C(reset)%C(bold yellow)%d%C(reset)" --abbrev-commit --date=relative'

## diff
git config --global alias.wdiff 'diff --word-diff=color --unified=1'
git config --global alias.remember '!git diff $(git branch-root)'

## etc
git config --global alias.find "!git ls-files | grep -i"
git config --global alias.aliases "!git config --get-regexp '^alias\\.' | sed 's/alias\\.\\([^ ]*\\) \\(.*\\)/\\1\\\t => \\2/'"
git config --global alias.me '!git config --get-regexp user'


git config --global core.excludesfile ~/.gitignore_global

