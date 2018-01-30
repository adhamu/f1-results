#!/usr/bin/env bash

chalk -t '{yellow • Starting HTML}'

rimraf public/**/*.html

for i in src/*.html; do
    FILE=$(basename $i)
    chalk -t "{blue • Minifying ${FILE}}"
    htmlmin -o "public/${FILE}" ${i}
done

chalk -t "{blue • Rewriting references to hashed filenames}"
replaceinfiles -r public/manifest.json -s public/*.html -d 'public/{base}' -S

chalk -t '{green • HTML complete}'
