#!/usr/bin/env bash

set -x
set -e

rimraf public/**/*.html

for i in src/*.html; do
    FILE=$(basename $i)
    htmlmin -o "public/${FILE}" ${i}
done

replaceinfiles -r public/manifest.json -s public/*.html -d 'public/{base}' -S
