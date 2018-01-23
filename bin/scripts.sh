#!/usr/bin/env bash

set -x
set -e

FILE="app.js"
SRC_DIRECTORY="src/js"
OUTPUT_DIRECTORY="public/js"

mkdirp ${OUTPUT_DIRECTORY}
rimraf "${OUTPUT_DIRECTORY}/${FILE}"
browserify "${SRC_DIRECTORY}/${FILE}" -t [ babelify --presets [ env ] ] | uglifyjs --compress --mangle -o "${OUTPUT_DIRECTORY}/${FILE}"
