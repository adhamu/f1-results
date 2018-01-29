#!/usr/bin/env bash

set -x
set -e

FILE="app.js"
SRC_DIRECTORY="src/js"
OUTPUT_DIRECTORY="public/js"

mkdirp ${OUTPUT_DIRECTORY}
rimraf "${OUTPUT_DIRECTORY}/**/*.js"

browserify "${SRC_DIRECTORY}/${FILE}" -t [ babelify --presets [ env react ] ] | uglifyjs --compress --mangle -o "${OUTPUT_DIRECTORY}/${FILE}"

sed -i '' "/^  \"\/js\/app\.js/d" public/manifest.json

hashmark -s -l 12 -c public "/js/${FILE}" "{dir}/{name}.{hash}{ext}" --asset-map manifest.json

rimraf "${OUTPUT_DIRECTORY}/${FILE}"
