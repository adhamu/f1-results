#!/usr/bin/env bash

chalk -t '{yellow • Starting Scripts}'

FILE="index.js"
SRC_DIRECTORY="src/js"
OUTPUT_DIRECTORY="public/js"

chalk -t '{blue • Preparing output directory}'
mkdirp ${OUTPUT_DIRECTORY}
rimraf "${OUTPUT_DIRECTORY}/**/*.js"

chalk -t "{blue • Compiling "${SRC_DIRECTORY}/${FILE}"}"
browserify "${SRC_DIRECTORY}/${FILE}" --fast -t [ babelify --presets [ env react ] ] | uglifyjs -o "${OUTPUT_DIRECTORY}/${FILE}"

chalk -t "{blue • Hashing ${FILE} and updating manifest}"
if [ -f public/manifest.json ]; then
    sed -i '' "/^  \"\/js\/app\.js/d" public/manifest.json
fi

hashmark -s -l 12 -c public "/js/${FILE}" "{dir}/{name}.{hash}{ext}" --asset-map manifest.json

rimraf "${OUTPUT_DIRECTORY}/${FILE}"
chalk -t '{green • Scripts complete}'
