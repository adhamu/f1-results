#!/usr/bin/env bash

source ./bin/functions.sh

start=`date +%s`

logline yellow "Starting images"

mkdirp public/img

for i in src/img/*; do
    FILE=$(basename $i)
    EXTENSION="${FILE##*.}"
    FILE="${FILE%.*}"

    logline blue "Minifying ${FILE}.${EXTENSION}"
    imagemin ${i} > "public/img/${FILE}.${EXTENSION}"
    
    logline blue "Hashing ${FILE}.${EXTENSION} and updating manifest"
    sed -i '' "/^  \"\/img\/${FILE}\.${EXTENSION}/d" public/manifest.json
    hashmark -s -l 12 -c public "/img/${FILE}.${EXTENSION}" "{dir}/{name}.{hash}{ext}" --asset-map manifest.json
    rimraf "public/img/${FILE}.${EXTENSION}"
done

end=`date +%s`

logline green "Finished images in $((end-start))s"
