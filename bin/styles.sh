#!/usr/bin/env bash

set -x
set -e

FILE="styles"
IN_EXT="scss"
SRC_DIRECTORY="src/scss"
OUTPUT_DIRECTORY="public/css"

rimraf "${OUTPUT_DIRECTORY}/**/*.css"

node-sass --output-style compressed --omit-source-map-url -o ${OUTPUT_DIRECTORY} "${SRC_DIRECTORY}/${FILE}.${IN_EXT}"
postcss -u autoprefixer -r "${OUTPUT_DIRECTORY}/*" --no-map
