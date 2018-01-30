#!/usr/bin/env bash

start=`date +%s`

chalk -t "{yellow [`date +%T`] • Starting HTML}"

rimraf public/**/*.html

for i in src/*.html; do
    FILE=$(basename $i)
    
    chalk -t "{blue [`date +%T`] • Minifying ${FILE}}"
    htmlmin -o "public/${FILE}" ${i}
done


chalk -t "{blue [`date +%T`] • Rewriting references to hashed filenames}"
replaceinfiles -r public/manifest.json -s public/*.html -d 'public/{base}' -S

end=`date +%s`

chalk -t "{green [`date +%T`] • Finished HTML in $((end-start))s}"
