#!/bin/bash
git config --global color.ui auto
git config --global alias.branches 'branch -a'
git config --global alias.tags 'tag'
git config --global alias.stashes 'stash list'
git config --global alias.remotes 'remote -v'
git config --global alias.unstage 'reset -q HEAD --'
git config --global alias.discard 'checkout --'
git config --global alias.uncommit 'reset --mixed HEAD~'
git config --global alias.amend 'commit --amend'
git config --global alias.nevermind '!git reset --hard HEAD && git clean -d -f'
git config --global alias.graph "log --graph -10 --branches --remotes --tags  --format=format:'%Cgreen%h %Creset• %<(75,trunc)%s (%cN, %cr) %Cred%d' --date-order"
git config --global alias.precommit 'diff --cached --diff-algorithm=minimal -w'
git config --global alias.unmerged 'diff --name-only --diff-filter=U'
git config --global alias.branch-activity "for-each-ref --format='%(authordate) %(refname)' --sort=-committerdate refs/heads refs/remotes"
git config --global core.excludesfile ~/.gitignore_global

