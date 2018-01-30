#!/usr/bin/env bash

start=`date +%s`

chalk -t "{yellow [`date +%T`] • Starting styles}"

FILE="styles"
SRC_DIRECTORY="src/scss"
OUTPUT_DIRECTORY="public/css"

chalk -t "{blue [`date +%T`] • Preparing output directory}"
rimraf "${OUTPUT_DIRECTORY}/**/*.css"

chalk -t "{blue [`date +%T`] • Compiling ${SRC_DIRECTORY}/${FILE}.scss}"
node-sass -q --output-style compressed --omit-source-map-url -o ${OUTPUT_DIRECTORY} "${SRC_DIRECTORY}/${FILE}.scss"

chalk -t "{blue [`date +%T`] • Applying autoprefixer}"
postcss -u autoprefixer -r "${OUTPUT_DIRECTORY}/*" --no-map

chalk -t "{blue [`date +%T`] • Hashing ${FILE}.css and updating manifest}"
if [ -f public/manifest.json ]; then
    sed -i '' "/^  \"\/css\/styles\.css/d" public/manifest.json
fi

hashmark -s -l 12 -c public "/css/${FILE}.css" "{dir}/{name}.{hash}{ext}" --asset-map manifest.json

rimraf "${OUTPUT_DIRECTORY}/${FILE}.css"

end=`date +%s`

chalk -t "{green [`date +%T`] • Finished styles in $((end-start))s}"
