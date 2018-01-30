#!/usr/bin/env bash

start=`date +%s`

chalk -t "{yellow [`date +%T`] • Starting images}"

mkdirp public/img

for i in src/img/*; do
    FILE=$(basename $i)
    EXTENSION="${FILE##*.}"
    FILE="${FILE%.*}"

    chalk -t "{blue [`date +%T`] • Minifying ${FILE}.${EXTENSION}}"
    imagemin ${i} > "public/img/${FILE}.${EXTENSION}"
    
    chalk -t "{blue [`date +%T`] • Hashing ${FILE}.${EXTENSION} and updating manifest}"
    sed -i '' "/^  \"\/img\/${FILE}\.${EXTENSION}/d" public/manifest.json
    hashmark -s -l 12 -c public "/img/${FILE}.${EXTENSION}" "{dir}/{name}.{hash}{ext}" --asset-map manifest.json
    rimraf "public/img/${FILE}.${EXTENSION}"
done

end=`date +%s`

chalk -t "{green [`date +%T`] • Finished images in $((end-start))s}"
