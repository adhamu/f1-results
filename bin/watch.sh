#!/usr/bin/env bash

set -x
set -e

concurrently \
    "chokidar 'src/**/*.{css,scss}' -c 'yarn styles && yarn html'" \
    "chokidar 'src/**/*.js' -c 'yarn scripts && yarn html'" \
    "chokidar 'src/**/*.{jpg,jpeg,gif,png,svg,JPG,JPEG,GIF,PNG,SVG}' -c 'yarn images && yarn html'" \
    "http-server"
