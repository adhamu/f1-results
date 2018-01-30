#!/usr/bin/env bash

start=`date +%s`

chalk -t "{yellow [`date +%T`] • Starting scripts}"

FILE="index.js"
SRC_DIRECTORY="src/js"
OUTPUT_DIRECTORY="public/js"

chalk -t "{blue [`date +%T`] • Preparing output directory}"
mkdirp ${OUTPUT_DIRECTORY}
rimraf "${OUTPUT_DIRECTORY}/**/*.js"

chalk -t "{blue [`date +%T`] • Compiling "${SRC_DIRECTORY}/${FILE}"}"
browserify "${SRC_DIRECTORY}/${FILE}" --fast -t [ babelify --presets [ env react ] ] | uglifyjs -o "${OUTPUT_DIRECTORY}/${FILE}"

chalk -t "{blue [`date +%T`] • Hashing ${FILE} and updating manifest}"
if [ -f public/manifest.json ]; then
    sed -i '' "/^  \"\/js\/app\.js/d" public/manifest.json
fi

hashmark -s -l 12 -c public "/js/${FILE}" "{dir}/{name}.{hash}{ext}" --asset-map manifest.json

rimraf "${OUTPUT_DIRECTORY}/${FILE}"

end=`date +%s`

chalk -t "{green [`date +%T`] • Finished scripts in $((end-start))s}"
