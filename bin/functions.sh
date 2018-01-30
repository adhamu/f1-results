#!/usr/bin/env bash

function logline() {
    chalk -t "{$1 [`date +%T`] • $2}"
}
