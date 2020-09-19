
if [[ ! -r ~/.zsh/completion.local/_gh ]]; then
  gh completion -s zsh > ~/.zsh/completion.local/_gh
fi