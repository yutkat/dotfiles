#==============================================================#
## Snippet
#==============================================================#

# ycino's config
function snippet-selection() {
  local SNIP_FILE="$HOME/.config/snippets/snippets"
  if [[ ! -f $SNIP_FILE ]]; then
    echo "Snippet file is not found [$SNIP_FILE]"
    return
  fi

  local out snippet key file
  IFS=$'\n' out=($(\grep -v "^#" $SNIP_FILE | \grep -v "^\s*$" | fzf --query "$LBUFFER" --prompt="Snippet> " --preview="bat ~/.config/snippets/{1}" --expect=ctrl-e))
  key=$(echo "$out" | head -1)
  snippet=$(echo "$out" | head -2 | tail -1)

  if [[ $snippet != "" ]]; then
    if [[ $key == "ctrl-e" ]]; then
      file=$(echo $snippet | cut -d' ' -f 1)
      vi ~/.config/snippets/$file
    else
      snippet=$(echo $snippet | awk '{for(i=2;i<NF;i++){printf("%s%s",$i,OFS=" ")}print $NF}')
      BUFFER=$snippet
      CURSOR=$#BUFFER
    fi
  fi
  zle reset-prompt
}
zle -N snippet-selection
bindkey '^X^s' snippet-selection

