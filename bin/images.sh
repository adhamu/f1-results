#!/usr/bin/env bash

chalk -t '{yellow • Starting Images}'

mkdirp public/img

for i in src/img/*; do
    FILE=$(basename $i)
    EXTENSION="${FILE##*.}"
    FILE="${FILE%.*}"

    chalk -t "{blue • Minifying ${FILE}.${EXTENSION}}"
    imagemin ${i} > "public/img/${FILE}.${EXTENSION}"
    
    chalk -t "{blue • Hashing ${FILE}.${EXTENSION} and updating manifest}"
    sed -i '' "/^  \"\/img\/${FILE}\.${EXTENSION}/d" public/manifest.json
    hashmark -s -l 12 -c public "/img/${FILE}.${EXTENSION}" "{dir}/{name}.{hash}{ext}" --asset-map manifest.json
    rimraf "public/img/${FILE}.${EXTENSION}"
done

chalk -t '{green • Images complete}'
