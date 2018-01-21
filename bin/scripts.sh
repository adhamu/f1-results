#!/usr/bin/env bash

set -x
set -e

rm -f public/js/app.js
babel ./src/js/app.js --out-file ./public/js/app.js
