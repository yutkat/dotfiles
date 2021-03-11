
if [[ ! -r $ZHOMEDIR/completion.local/_gh ]]; then
  gh completion -s zsh > $ZHOMEDIR/completions.local/_gh
fi
