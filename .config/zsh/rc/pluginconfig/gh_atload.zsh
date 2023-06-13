
if [[ ! -r $ZHOMEDIR/completions.local/_gh ]]; then
	gh completion -s zsh > $ZHOMEDIR/completions.local/_gh
fi
alias gi='aicommits'
