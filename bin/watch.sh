#!/usr/bin/env bash

concurrently -p "• {name}" -n "watch:html,watch:styles,watch:scripts,watch:images,http" -c "blue.bold,magenta.bold,green.bold,yellow.bold,cyan.bold" \
    "chokidar 'src/**/*.html' -c 'yarn html'" \
    "chokidar 'src/**/*.{css,scss}' -c 'yarn styles && yarn html'" \
    "chokidar 'src/**/*.{js,jsx}' -c 'yarn scripts && yarn html'" \
    "chokidar 'src/**/*.{jpg,jpeg,gif,png,svg,JPG,JPEG,GIF,PNG,SVG}' -c 'yarn images && yarn html'" \
    "http-server"
