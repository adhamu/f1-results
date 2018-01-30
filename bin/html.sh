#!/usr/bin/env bash

source ./bin/functions.sh

start=`date +%s`

logline yellow "Starting HTML"

rimraf public/**/*.html

for i in src/*.html; do
    FILE=$(basename $i)
    
    logline blue "Minifying ${FILE}"
    htmlmin -o "public/${FILE}" ${i}
done


logline blue "Rewriting references to hashed filenames"
replaceinfiles -r public/manifest.json -s public/*.html -d 'public/{base}' -S

end=`date +%s`

logline green "Finished HTML in $((end-start))s"
