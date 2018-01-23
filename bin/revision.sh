#!/usr/bin/env bash

set -x
set -e

hashmark -l 12 'public/**/*.{js,css}' '{dir}/{name}.{hash}{ext}' --asset-map public/manifest.json
