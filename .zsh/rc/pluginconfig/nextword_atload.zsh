
export NEXTWORD_DATA_PATH=~/.zsh/dictionary/nextword-data-large

function get_nextword_data() {
  echo "Takes a long time to download..."
  curl -L https://github.com/high-moctane/nextword-data/archive/large.tar.gz | tar zx -C ~/.zsh/dictionary/
}
