#!/usr/bin/env bash

set -x
set -e

nodemon -e css,scss -x "yarn build-styles"
