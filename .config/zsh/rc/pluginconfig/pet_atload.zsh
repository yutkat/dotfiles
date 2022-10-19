
function prev() {
	PREV=$(fc -lrn | head -n 1)
	sh -c "pet new `printf %q "$PREV"`"
}

function pet-select() {
	BUFFER=$(pet search --query "$LBUFFER")
	CURSOR=$#BUFFER
	zle redisplay
}
zle -N pet-select
# move pluginlist because async load occurs below error
# stty: 'standard input': Inappropriate ioctl for device
# [[ $- == *i* ]] && stty -ixon
bindkey '^s' pet-select
