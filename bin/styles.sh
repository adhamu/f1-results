#!/usr/bin/env bash

set -x
set -e

FILE="styles"
SRC_DIRECTORY="src/scss"
OUTPUT_DIRECTORY="public/css"

rimraf "${OUTPUT_DIRECTORY}/**/*.css"

node-sass --output-style compressed --omit-source-map-url -o ${OUTPUT_DIRECTORY} "${SRC_DIRECTORY}/${FILE}.scss"
postcss -u autoprefixer -r "${OUTPUT_DIRECTORY}/*" --no-map

if [ -f public/manifest.json ]; then
    sed -i '' "/^  \"\/css\/styles\.css/d" public/manifest.json
fi

hashmark -s -l 12 -c public "/css/${FILE}.css" "{dir}/{name}.{hash}{ext}" --asset-map manifest.json

rimraf "${OUTPUT_DIRECTORY}/${FILE}.css"
