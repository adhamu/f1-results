#!/usr/bin/env bash

set -x
set -e

FILE="index.js"
SRC_DIRECTORY="src/js"
OUTPUT_DIRECTORY="public/js"

mkdirp ${OUTPUT_DIRECTORY}
rimraf "${OUTPUT_DIRECTORY}/**/*.js"

browserify "${SRC_DIRECTORY}/${FILE}" --fast -t [ babelify --presets [ env react ] ] | uglifyjs -o "${OUTPUT_DIRECTORY}/${FILE}"

if [ -f public/manifest.json ]; then
    sed -i '' "/^  \"\/js\/app\.js/d" public/manifest.json
fi

hashmark -s -l 12 -c public "/js/${FILE}" "{dir}/{name}.{hash}{ext}" --asset-map manifest.json

rimraf "${OUTPUT_DIRECTORY}/${FILE}"
