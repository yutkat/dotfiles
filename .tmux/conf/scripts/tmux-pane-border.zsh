#!/bin/zsh

if git_status=$(cd $1 && git status 2>/dev/null ); then
  git_branch="$(echo $git_status| awk 'NR==1 {print $3}')"
  case $git_status in
    *Changes\ not\ staged* ) state="#[fg=red]*#[default]" ;;
    *Changes\ to\ be\ committed* ) state="#[fg=yellow]+#[default]" ;;
    * ) state="#[fg=green] / #[default]" ;;
  esac
  if [[ $git_branch = "master" || $git_branch = "main" ]]; then
    git_info="#[underscore]#[bg=black,fg=cyan](${git_branch}#[default]|${state})"
  else
    git_info="#[underscore]#[bg=black,fg=cyan](${git_branch}#[default]|${state})"
  fi
else
  git_info=""
fi

directory="#[underscore]#[bg=black,fg=cyan]$1#[default]"

#echo "$directory$git_info"
echo "$directory"
