
if [[ ! -r $ZHOMEDIR/completion.local/_gh ]]; then
  gh completion -s zsh > $ZHOMEDIR/completion.local/_gh
fi
