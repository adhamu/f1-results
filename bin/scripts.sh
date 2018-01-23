#!/usr/bin/env bash

set -x
set -e

FILE="app.js"
SRC_DIRECTORY="src/js"
OUTPUT_DIRECTORY="public/js"

mkdirp ${OUTPUT_DIRECTORY}
rimraf "${OUTPUT_DIRECTORY}/**/*.js"

browserify "${SRC_DIRECTORY}/${FILE}" -t [ babelify --presets [ env ] ] | uglifyjs --compress --mangle -o "${OUTPUT_DIRECTORY}/${FILE}"

hashmark -l 12 -s "${OUTPUT_DIRECTORY}/${FILE}" "{dir}/{name}.{hash}{ext}" --asset-map public/manifest.json

rimraf "${OUTPUT_DIRECTORY}/${FILE}"
