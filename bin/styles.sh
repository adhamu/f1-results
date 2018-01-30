#!/usr/bin/env bash

source ./bin/functions.sh

start=`date +%s`

logline yellow "Starting styles"

FILE="styles"
SRC_DIRECTORY="src/scss"
OUTPUT_DIRECTORY="public/css"

logline blue "Preparing output directory"
rimraf "${OUTPUT_DIRECTORY}/**/*.css"

logline blue "Compiling ${SRC_DIRECTORY}/${FILE}.scss"
node-sass -q --output-style compressed --omit-source-map-url -o ${OUTPUT_DIRECTORY} "${SRC_DIRECTORY}/${FILE}.scss"

logline blue "Applying autoprefixer"
postcss -u autoprefixer -r "${OUTPUT_DIRECTORY}/*" --no-map

logline blue "Hashing ${FILE}.css and updating manifest"
if [ -f public/manifest.json ]; then
    sed -i '' "/^  \"\/css\/styles\.css/d" public/manifest.json
fi

hashmark -s -l 12 -c public "/css/${FILE}.css" "{dir}/{name}.{hash}{ext}" --asset-map manifest.json

rimraf "${OUTPUT_DIRECTORY}/${FILE}.css"

end=`date +%s`

logline green "Finished styles in $((end-start))s"
