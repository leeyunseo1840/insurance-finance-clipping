set -eu
mkdir -p app-source
tar -xzf source.tar.gz -C app-source
mkdir -p app-source/public/data
if [ -d data ]; then cp -r data/. app-source/public/data/; fi
cd app-source
npm ci
VITE_STATIC_NEWS=true npm run build:render
