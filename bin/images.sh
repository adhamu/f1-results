#!/usr/bin/env bash

set -x
set -e

for i in src/img/*; do
    FILE=$(basename $i)
    EXTENSION="${FILE##*.}"
    FILE="${FILE%.*}"

    imagemin ${i} > "public/img/${FILE}.${EXTENSION}"
    sed -i '' "/^  \"\/img\/${FILE}\.${EXTENSION}/d" public/manifest.json
    hashmark -s -l 12 -c public "/img/${FILE}.${EXTENSION}" "{dir}/{name}.{hash}{ext}" --asset-map manifest.json
    rimraf "public/img/${FILE}.${EXTENSION}"
done
