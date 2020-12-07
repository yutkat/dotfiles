export NEXTWORD_DATA_PATH="${ZDATADIR}/dictionary/nextword-data-large"

function get_nextword_data() {
  echo "Takes a long time to download..."
  mkdir -p $(dirname $NEXTWORD_DATA_PATH)
  curl -L https://github.com/high-moctane/nextword-data/archive/large.tar.gz | tar zx -C $(dirname $NEXTWORD_DATA_PATH)
}
