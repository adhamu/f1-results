#!/usr/bin/env bash

set -x
set -e

SRC_FILE="styles.scss"
SRC_DIRECTORY="src/scss"
OUTPUT_FILE="styles.min.css"
OUTPUT_DIRECTORY="dist/css"

rm -f "${OUTPUT_DIRECTORY}/${OUTPUT_FILE}"
node-sass --include-path scss "${SRC_DIRECTORY}/${SRC_FILE}" "${OUTPUT_DIRECTORY}/${OUTPUT_FILE}"
