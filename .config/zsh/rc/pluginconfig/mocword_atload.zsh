export MOCWORD_DATA="${ZDATADIR}/dictionary/mocword.sqlite"

function mocword_data_download() {
  echo "Takes a long time to download..."
  mkdir -p $(dirname $MOCWORD_DATA)
  curl -L https://github.com/high-moctane/mocword-data/releases/download/eng20200217/mocword.sqlite.gz | gzip -d > $MOCWORD_DATA
}
